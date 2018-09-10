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
    
    func getPasswordResetUrl(completion: @escaping DataProviderProtocol.urlCompletion) {
        client?.invokeAPI("password", body: nil, httpMethod: "GET", parameters: nil, headers: nil, completion: { (result, response, error) in
            if response == nil {
                completion(nil,error)
                return
            }
            
            if response?.statusCode != 200 {
                completion(nil,HTTPResponseError((response?.statusCode)!, description: (error?.localizedDescription)!))
                return
            }
            completion((result as? NSDictionary)?.value(forKey: "url") as? String,nil)
        })
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
    
    func getProfile(token: String?, completion: @escaping profileCompletion) {
        client?.invokeAPI("profile", body: nil, httpMethod: "GET", parameters: nil, headers:generateHeader(token) , completion: { (result, response, error) in
            
            if response == nil {
                completion(nil,error)
                return
            }
            
            if response?.statusCode != 200 {
                completion(nil,HTTPResponseError((response?.statusCode)!, description: (error?.localizedDescription)!))
                return
            }
            completion(User(json: result as! JSON),nil)
        })
    }
    
    func updateProfile(token: String?, profile: User, completion: @escaping errorHandler) {
        client?.invokeAPI("profile", body: profile.toJSON(), httpMethod: "POST", parameters: nil, headers: generateHeader(token), completion: { (result, response, error) in
                self.errorOnlyResponseHandler(result: result, response: response, error: error, completion: completion)
        })
    }
    
    func updateGoogleProfile(profile: User, completion: @escaping DataProviderProtocol.authCompletion) {
        client?.invokeAPI("googleauth", body: profile.toJSON(), httpMethod: "PUT", parameters: nil, headers: nil, completion: { (result, response, error) in
            self.authResponseHandler(result: result, response: response, error: error, completion: completion)
        })
    }
    
    func updateFacebookProfile(profile: User, completion: @escaping DataProviderProtocol.authCompletion) {
        client?.invokeAPI("facebookauth", body: profile.toJSON(), httpMethod: "PUT", parameters: nil, headers: nil, completion: { (result, response, error) in
            self.authResponseHandler(result: result, response: response, error: error, completion: completion)
        })
    }
    
    func getArtworkList(token: String?, completion: @escaping artworkListCompletion) {
        client?.invokeAPI("artworks", body: nil, httpMethod: "GET", parameters: nil, headers: generateHeader(token), completion: { (result, response, error) in
            self.artworkListResponseHandler(result: result, response: response, error: error, completion: completion)
        })
    }
    
    func getArtwork(token: String?, artworkId: String?, completion: @escaping DataProviderProtocol.artworkCompletion) {
        client?.invokeAPI("artworks", body: nil, httpMethod: "GET", parameters: ["artworkId":artworkId!], headers: generateHeader(token), completion: { (result, response, error) in
            if response == nil {
                completion(nil,error)
                return
            }
            if response?.statusCode != 200 {
                completion(nil,HTTPResponseError((response?.statusCode)!, description: (error?.localizedDescription)!))
                return
            }
            completion(Artwork(json: result as! JSON),nil)
        })
    }
    
    func updateBookmark(token: String?, artworkId: String?, newBookmarkState: Bool?, completion: @escaping DataProviderProtocol.errorHandler) {
        client?.invokeAPI("bookmark", body: ["id":artworkId!,"isBookmarked":newBookmarkState!], httpMethod: "POST", parameters: nil, headers: generateHeader(token), completion: { (result, response, error) in
            self.errorOnlyResponseHandler(result: result, response: response, error: error, completion: completion)
        })
    }
    
    func updateRating(token: String?, artworkId: String?, newRating: Int?, completion: @escaping DataProviderProtocol.errorHandler) {
        client?.invokeAPI("rating", body: ["id":artworkId!,"rating":newRating!], httpMethod: "POST", parameters: nil, headers: generateHeader(token), completion: { (result, response, error) in
            self.errorOnlyResponseHandler(result: result, response: response, error: error, completion: completion)
        })
    }
    
    func getCommentList(token:String?,artworkId: String?, completion: @escaping commentListCompletion) {
        client?.invokeAPI("comments", body: nil, httpMethod: "GET", parameters: ["artworkId":artworkId!], headers: generateHeader(token), completion: { (result, response, error) in
            if response == nil {
                completion(nil,error)
                return
            }
            if response?.statusCode != 200 {
                completion(nil,HTTPResponseError((response?.statusCode)!, description: (error?.localizedDescription)!))
                return
            }
            var commentList = [Comment]()
            for comment in result as! NSArray {
                commentList.append(Comment(json: comment as! JSON)!)
            }
            completion(commentList,nil)
        })
    }
    
    func postComment(token: String?, content: String?, artworkId: String?, completion: @escaping errorHandler) {
        client?.invokeAPI("comments", body: ["artworkId":artworkId,"content":content], httpMethod: "POST", parameters: nil, headers: generateHeader(token), completion: { (result, response, error) in
                self.errorOnlyResponseHandler(result: result, response: response, error: error, completion: completion)
        })
    }
    
    func deleteComment(token: String?, commentId: String?, completion: @escaping errorHandler) {
        client?.invokeAPI("comments", body:nil, httpMethod: "DELETE", parameters: ["commentId":commentId!], headers: generateHeader(token), completion: { (result, response, error) in
                self.errorOnlyResponseHandler(result: result, response: response, error: error, completion: completion)
        })
    }
    
    func reportComment(token: String?, commentId: String?, completion: @escaping errorHandler) {
        client?.invokeAPI("report", body:["commentId":commentId!], httpMethod: "POST", parameters:nil , headers: generateHeader(token), completion: { (result, response, error) in
            self.errorOnlyResponseHandler(result: result, response: response, error: error, completion: completion)
        })
    }
    
    func getBookmarkList(token: String?, completion: @escaping DataProviderProtocol.artworkListCompletion) {
        client?.invokeAPI("bookmark", body: nil, httpMethod: "GET", parameters: nil, headers: generateHeader(token), completion: { (result, response, error) in
            self.artworkListResponseHandler(result: result, response: response, error: error, completion: completion)
        })
    }

    
    
    private func generateHeader(_ token:String?) -> [AnyHashable:Any]? {
        return token == nil ? nil : ["Authorization":"Bearer "+token!]
    }
    
    private func artworkListResponseHandler(result:Any?, response:HTTPURLResponse?, error:Error?, completion:artworkListCompletion) {
        if response == nil {
            completion(nil,error)
            return
        }
        if response?.statusCode != 200 {
            completion(nil,HTTPResponseError((response?.statusCode)!, description: (error?.localizedDescription)!))
            return
        }
        var artworkList = [Artwork]()
        for artwork in result as! NSArray {
            artworkList.append(Artwork(json: artwork as! JSON)!)
        }
        completion(artworkList,nil)
    }
    
    private func authResponseHandler(result:Any?, response:HTTPURLResponse?, error:Error?, completion:authCompletion) {
        
        if response == nil {
            completion(nil,nil,error)
            return
        }
        
        if response?.statusCode != 200 {
            completion(nil,nil,HTTPResponseError((response?.statusCode)!,description: (error?.localizedDescription)!))
            return
        }

        let _result = result as! NSDictionary
        completion(_result.value(forKey: "success") as? Bool,_result.value(forKey: "payload") as? String, nil)
        return
    }
    
    private func errorOnlyResponseHandler(result:Any?, response:HTTPURLResponse?, error:Error?, completion:errorHandler) {
        if response == nil {
            completion(error)
            return
        }
        if response?.statusCode != 200 {
            completion(HTTPResponseError((response?.statusCode)!, description: (error?.localizedDescription)!))
            return
        }
        completion(nil)
    }
    
    
    
    
    
    
}
