//
//  DataManager.swift
//  AvanadeAIProject
//
//  Created by Timothy DenOuden on 1/10/18.
//  Copyright © 2018 Avanade. All rights reserved.
//

import Foundation
import UIKit

protocol GalleryDelegate {
    func artworkListDidReady(artworkList:[Artwork])
    func artworkListWillReady()
    func errorDidOccur(_ error:Error)
}

final class DataManager {
    static let sharedInstance = DataManager()
    
    private let dataProvider: DataProviderProtocol
    
    private var token : String?
    
    private var artworkListCache : [Artwork]?
    
    public var galleryDelegate : GalleryDelegate?
  
    private init() {
        dataProvider = AzureDataProvider();
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
                dataProvider.getArtworkList(token: token!, completion: { (artworkList, error) in
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
        
        dataProvider.getProfile(token: token!, completion: completion)
        
    }
    
    public func updateProfile(profile:User,completion: @escaping DataProviderProtocol.errorHandler) {
        dataProvider.updateProfile(token: token!, profile: profile, completion: completion)
    }
    
    // TODO: clear all cache
    public func logOut() {
        token = nil
    }
    
    private func authCompletionHandler(success:Bool?,message:String?,error:Error?,completion:@escaping DataProviderProtocol.authCompletion) {
        
        if success != nil && success! {
            self.token = message
        }
        completion(success,message,error)
        
    }
    


}
