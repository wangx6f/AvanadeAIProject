//
//  AzureDataProvider.swift
//  AvanadeAIProject
//
//  Created by Xinyuan Wang on 2/4/18.
//  Copyright © 2018 Avanade. All rights reserved.
//

import Foundation
import MicrosoftAzureMobile
import Gloss

class AzureDataProvider : DataProviderProtocol {

    private var client: MSClient?
    
    init(){
        // Setup the client connection with Microsoft Azure
        client = MSClient(
            applicationURLString:"https://avanademobileapp.azurewebsites.net"
        )
    }
    
    func login(email: String, password: String, completion: @escaping authCompletion) {
        client?.invokeAPI("auth", body: ["email":email,"password":password], httpMethod: "POST", parameters: nil, headers: nil, completion: { (result, response, error) in
            self.authResponseHandler(result: result, response: response, error: error, completion: completion)
            
        })
    }
    
    func register(newUser: User, password: String, completion: @escaping authCompletion) {
        var userWithPassword = newUser.toJSON()
        userWithPassword!["password"] = password
        client?.invokeAPI("auth", body:userWithPassword, httpMethod: "PUT", parameters: nil, headers: nil, completion: { (result, response, error) in
            self.authResponseHandler(result: result, response: response, error: error, completion: completion)
        })
    }
    
    func getProfile(token: String, completion: @escaping profileCompletion) {
        client?.invokeAPI("profile", body: nil, httpMethod: "GET", parameters: nil, headers:generateHeader(token) , completion: { (result, response, error) in
            if let _ = error {
                completion(nil,error)
                return
            }
            if response?.statusCode != 200 {
                completion(nil,HTTPResponseError((response?.statusCode)!))
                return
            }
            completion(User(json:result as! JSON),nil)
        })
    }
    
    private func generateHeader(_ token:String) -> [AnyHashable:Any] {
        return ["Authorization":"Bearer "+token]
    }
    
    private func authResponseHandler(result:Any?, response:HTTPURLResponse?, error:Error?, completion:authCompletion) {
        
        if let _ = error {
            completion(nil,nil,error)
            return
        }
        if response?.statusCode != 200 {
            completion(nil,nil,HTTPResponseError((response?.statusCode)!))
            return
        }
        let _result = result as! NSDictionary
        completion(_result.value(forKey: "success") as? Bool,_result.value(forKey: "payload") as? String, nil)
        return
    }
    
    
    
}
