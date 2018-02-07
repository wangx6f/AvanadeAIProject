//
//  DataManager.swift
//  AvanadeAIProject
//
//  Created by Timothy DenOuden on 1/10/18.
//  Copyright © 2018 Avanade. All rights reserved.
//

import Foundation
import UIKit

final class DataManager {
    static let sharedInstance = DataManager()
    
    private let dataProvider: DataProviderProtocol
    
    private var token : String?
  
    private init() {
        dataProvider = AzureDataProvider();
    }
    
//    func imageFrom(url: String) -> UIImage {
//        return dataProvider.imageFrom(url: url)
//    }
//
//    func userWith(id: Int) -> User {
//        return dataProvider.userWith(id: id)
//    }
//
//    func artworkWith(id: Int) -> Artwork {
//        return dataProvider.artworkWith(id: id)
//    }
    
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
