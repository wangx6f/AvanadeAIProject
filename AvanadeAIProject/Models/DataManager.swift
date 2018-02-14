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

protocol GalleryDelegate {
    func artworkListDidReady(artworkList:[Artwork])
    func artworkListWillReady()
    func errorDidOccur(_ error:Error)
}

final class DataManager {
    static let sharedInstance = DataManager()
    
    private let dataProvider: DataProviderProtocol
    
    private let TOKEN_KEYCHAIN_KEY = "token"
    private let keychain : KeychainSwift
    
    private var artworkListCache : [Artwork]?
    
    public var selectedArtwork : Artwork?
    
    public var galleryDelegate : GalleryDelegate?
  
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
    
    public func updateArtworkList(filter:GalleryFilter,fromNetwork:Bool = false) {
        if let delegate = galleryDelegate {
            delegate.artworkListWillReady()
            if artworkListCache == nil || fromNetwork {
                dataProvider.getArtworkList(token: getToken(), completion: { (artworkList, error) in
                    if error != nil {
                        delegate.errorDidOccur(error!)
                    } else {
                        self.artworkListCache = artworkList
                        delegate.artworkListDidReady(artworkList: self.filterArtworkList(filter))
                    }
                })
            } else {
                delegate.artworkListDidReady(artworkList: filterArtworkList(filter))
            }
        }
    }
    
    private func filterArtworkList(_ filter:GalleryFilter) -> [Artwork] {
        // TODO : do filtering here
        return self.artworkListCache!
    }
    
    public func getProfile(completion: @escaping DataProviderProtocol.profileCompletion) {
        
        dataProvider.getProfile(token: getToken(), completion: completion)
        
    }
    
    public func updateProfile(profile:User,completion: @escaping DataProviderProtocol.errorHandler) {
        dataProvider.updateProfile(token: getToken(), profile: profile, completion: completion)
    }
    
    // TODO: clear all cache
    public func logOut() {
        keychain.delete(TOKEN_KEYCHAIN_KEY)
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
