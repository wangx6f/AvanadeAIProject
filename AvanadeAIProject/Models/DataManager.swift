//
//  DataManager.swift
//  AvanadeAIProject
//
//  Created by Timothy DenOuden on 1/10/18.
//  Copyright © 2018 Avanade. All rights reserved.
//

import Foundation
import UIKit
import KeychainSwift

// Ought to be implemented by controller that needs to handle any new changes on artwork list
protocol GalleryDelegate : NSObjectProtocol {
    func artworkListDidReady(artworkList:[Artwork])
    func artworkListWillReady()
    func errorDidOccur(_ error:Error)
}



// Ought to be implemented by bookmark controller that needs to handle any new changes on detail of a specific artwork
protocol DetailDelegate : NSObjectProtocol {
    func commentListDidReady(commentList:[Comment])
    func commentListWillReady()
    func refreshArtwork()
    func errorDidOccur(_ error:Error)
}

// Ought to be implemented by bookmark controller that needs to handle any new changes on bookmark list
protocol BookmarkDelegate : NSObjectProtocol {
    func bookmarkListDidReady(bookmarkList:[Artwork])
    func bookmarkListWillReady()
    func errorDidOccur(_ error:Error)
}


final class DataManager {
    
    // MARK: public property
    public static let sharedInstance = DataManager()
    
    weak public var galleryDelegate : GalleryDelegate?
    
    weak public var detailDelegate : DetailDelegate?
    
    weak public var bookmarkDelegate : BookmarkDelegate?

    
    // MARK: private field
    private let dataProvider: DataProviderProtocol
    
    private let TOKEN_KEYCHAIN_KEY = "token"
    
    private let keychain : KeychainSwift
    
    private var searchEngine : SearchEngine?
    
    private var _selectedArtwork : Artwork?
    
    private init() {
        dataProvider = AzureDataProvider();
        keychain = KeychainSwift();
    }
    
    public var selectedArtwork : Artwork? {
        set {
            _selectedArtwork = newValue
            if _selectedArtwork == nil {
                return
            }
            updateSelectedArtwork()

        }
        get {return _selectedArtwork}
    }
    
    
    
    public func loginStatus() -> Bool {
        return getToken() != nil
    }
    
    public func getPasswordResetUrl(completion:@escaping DataProviderProtocol.urlCompletion) {
        dataProvider.getPasswordResetUrl(completion: completion)
    }
    
    public func login(email:String,password:String,completion:@escaping DataProviderProtocol.authCompletion){
        dataProvider.login(email: email, password: password) { (success, message,error) in
            self.authCompletionHandler(success: success, message: message, error: error, completion: completion)
        }
    }
    
    public func register(newUser:User,password:String,completion:@escaping DataProviderProtocol.authCompletion){
        dataProvider.register(newUser: newUser, password: password) { (success, message,error) in
            self.authCompletionHandler(success: success, message: message, error: error, completion: completion)
        }
    }
    
    public func updateArtworkList(filter:GalleryFilter) {
        if let delegate = galleryDelegate {
            delegate.artworkListWillReady()
            
            dataProvider.getArtworkList(token: getToken(), completion: { (artworkList, error) in
                if error != nil {
                    delegate.errorDidOccur(error!)
                } else {
                    delegate.artworkListDidReady(artworkList: self.filterArtworkList(artworkList: artworkList, filter: filter))
                    // Also update the cached list in the search engine
                    if self.searchEngine == nil {
                        self.searchEngine = SearchEngine(token: self.getToken(), artworkList: artworkList)
                    } else {
                        self.searchEngine?.updateArtworkTable(artworkList: artworkList!)
                    }
                }
            })
        }
    }
    
    public func updateBookmarkList() {
        if let delegate = bookmarkDelegate {
            delegate.bookmarkListWillReady()
            dataProvider.getBookmarkList(token: getToken(), completion: { (artworkList, error) in
                if error != nil {
                    delegate.errorDidOccur(error!)
                } else {
                    delegate.bookmarkListDidReady(bookmarkList: artworkList!)
                }
            })
        }
    }
    
    public func toggleBookmark() {
        if let artwork = _selectedArtwork {
            dataProvider.updateBookmark(token: getToken(), artworkId: artwork.id, newBookmarkState: artwork.bookmarked == nil ? nil : !artwork.bookmarked!, completion: { (error) in
                if let error = error, let detailDelegate = self.detailDelegate {
                    detailDelegate.errorDidOccur(error)
                    return
                }
                self.updateSelectedArtwork()
            })
        }
    }
    
    public func updateRating(newRating:Int) {
        if let artwork = _selectedArtwork {
            dataProvider.updateRating(token: getToken(), artworkId: artwork.id, newRating: newRating, completion: { (error) in
                if let error = error, let detailDelegate = self.detailDelegate {
                    detailDelegate.errorDidOccur(error)
                    return
                }
                self.updateSelectedArtwork()
            })
        }
    }
    
    public func updateCommentList() {
        if let delegate = detailDelegate, let id = selectedArtwork?.id {
            delegate.commentListWillReady()
            dataProvider.getCommentList(token: getToken(), artworkId: id, completion: { (commentList, error) in
                if error != nil {
                    delegate.errorDidOccur(error!)
                } else {
                    delegate.commentListDidReady(commentList: commentList!.reversed())
                }
            })
        }
    }
    
    public func postComment(content:String?) {
        if let delegate = detailDelegate, let id = selectedArtwork?.id {
            dataProvider.postComment(token: getToken(), content: content, artworkId: id, completion: { (error) in
                if error != nil {
                    delegate.errorDidOccur(error!)
                } else {
                    self.updateCommentList()
                }
            })
        }
    }
    
    public func deleteComment(comment:Comment?,completion: @escaping DataProviderProtocol.errorHandler) {
        if let comment = comment {
            dataProvider.deleteComment(token: getToken(), commentId: comment.id, completion: { (error) in
                if error == nil {
                    self.updateCommentList()
                }
                completion(error)
            })
        }
    }
    
    public func search(keyword:String,completion:@escaping DataProviderProtocol.artworkListCompletion) {
        if searchEngine != nil {
            completion(searchEngine?.search(keyword: keyword),nil)
        }
    }
    
    public func getSearchHistory(completion:@escaping DataProviderProtocol.artworkListCompletion) {
        if searchEngine != nil {
            completion(searchEngine?.getHistory(),nil)
        }
    }

    public func addSearchHistory(artwork:Artwork) {
        if searchEngine != nil {
            searchEngine?.addHistory(artwork: artwork)
        }
    }
    
    public func clearSearchHistory() {
        searchEngine?.clearHistory()
    }
    
    public func getProfile(completion: @escaping DataProviderProtocol.profileCompletion) {
        dataProvider.getProfile(token: getToken(), completion: completion)
    }
    
    public func updateProfile(profile:User,completion: @escaping DataProviderProtocol.errorHandler) {
        dataProvider.updateProfile(token: getToken(), profile: profile, completion: completion)
    }
    
    
    // todo: clear all cache
    public func logOut() {
        selectedArtwork = nil
        searchEngine = nil
        keychain.delete(TOKEN_KEYCHAIN_KEY)

    }
    
    private func filterArtworkList(artworkList:[Artwork]?,filter:GalleryFilter) -> [Artwork] {
        if artworkList == nil {
            return []
        }
        switch filter.getSelectedSortOption() {
        case .hottest:
            return artworkList!.sorted(by: { (a1, a2) -> Bool in
                if let c1 = a1.viewCount, let c2 = a2.viewCount {
                    return c1 > c2
                } else {
                    return false
                }
            })
        case .best_rated:
            return artworkList!.sorted(by: { (a1, a2) -> Bool in
                if let c1 = a1.rating, let c2 = a2.rating {
                    return c1 > c2
                } else {
                    return false
                }
            })
        case .most_rated:
            return artworkList!.sorted(by: { (a1, a2) -> Bool in
                if let c1 = a1.rateCount, let c2 = a2.rateCount {
                    return c1 > c2
                } else {
                    return false
                }
            })
        case .most_recent:
            return artworkList!.reversed()
        }
    }
    
    private func updateSelectedArtwork() {
        dataProvider.getArtwork(token: getToken(), artworkId: selectedArtwork?.id) { (artwork, error) in
            if let error = error, let detailDelegate = self.detailDelegate {
                detailDelegate.errorDidOccur(error)
                return
            }
            self._selectedArtwork = artwork
            if let detailDelegate = self.detailDelegate {
                detailDelegate.refreshArtwork()
            }
        }
    }
    
    private func getToken() -> String? {
        return keychain.get(TOKEN_KEYCHAIN_KEY)
    }
    
    private func authCompletionHandler(success:Bool?,message:String?,error:Error?,completion:@escaping DataProviderProtocol.authCompletion) {
        if success != nil && success! {
            keychain.set(message!, forKey: TOKEN_KEYCHAIN_KEY)
        }
        completion(success,message,error)
        
    }
    


}
