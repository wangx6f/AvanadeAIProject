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
protocol GalleryDelegate {
    func artworkListDidReady(artworkList:[Artwork])
    func artworkListWillReady()
    func errorDidOccur(_ error:Error)
}



// Ought to be implemented by bookmark controller that needs to handle any new changes on detail of a specific artwork
protocol DetailDelegate {
    func artworkDidReady(commentList:[Comment])
    func artworkWillReady()
    func errorDidOccur(_ error:Error)
}

// Ought to be implemented by bookmark controller that needs to handle any new changes on bookmark list
protocol BookmarkDelegate {
    func bookmarkListDidReady(bookmarkList:[Artwork])
    func bookmarkListWillReady()
    func errorDidOccur(_ error:Error)
}

final class DataManager {
    public static let sharedInstance = DataManager()
    
    public var galleryDelegate : GalleryDelegate?
    
    public var detailDelegate : DetailDelegate?
    
    public var bookmarkDelegate : BookmarkDelegate?
    
    public var selectedArtwork : Artwork?
    
    private let dataProvider: DataProviderProtocol
    private let TOKEN_KEYCHAIN_KEY = "token"
    private let keychain : KeychainSwift
    
    
    private init() {
        dataProvider = AzureDataProvider();
        keychain = KeychainSwift();
    }
    
    public func loginStatus() -> Bool {
        return getToken() != nil
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
                }
            })
        }
    }
    

    
    public func getProfile(completion: @escaping DataProviderProtocol.profileCompletion) {
        dataProvider.getProfile(token: getToken(), completion: completion)
    }
    
    public func updateProfile(profile:User,completion: @escaping DataProviderProtocol.errorHandler) {
        dataProvider.updateProfile(token: getToken(), profile: profile, completion: completion)
    }
    
    
    // MARK: clear all cache
    public func logOut() {
        selectedArtwork = nil
        keychain.delete(TOKEN_KEYCHAIN_KEY)
    }
    
    private func filterArtworkList(artworkList:[Artwork]?,filter:GalleryFilter) -> [Artwork] {
        // TODO : do filtering here
        return artworkList!
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
