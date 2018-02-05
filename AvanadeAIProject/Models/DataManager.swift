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
    
    private var user : User?
    
    
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
        
        // check whether the user has been cached
        if let _ = user {
            completion(user,nil)
            return
        }
        dataProvider.getProfile(token: self.token!) { (user, error) in
            self.user = user
            completion(user,error)
        }
    }
    
    private func authCompletionHandler(success:Bool?,message:String?,error:Error?,completion:@escaping DataProviderProtocol.authCompletion) {
        
        if success != nil && success! {
            self.token = message
        }
        completion(success,message,error)
        
    }

}
