//
//  AzureWebServiceDataProvider.swift
//  AvanadeAIProject
//
//  Created by Xinyuan Wang on 5/20/18.
//  Copyright © 2018 Avanade. All rights reserved.
//

import Foundation
import Alamofire
import Gloss

class AzureWebServiceDataProvider : DataProviderProtocol {
    
    let baseURL = "https://art-machina-web-service.azurewebsites.net/api/"
    
    func login(email: String, password: String, completion: @escaping DataProviderProtocol.authCompletion) {
        let parameters : Parameters = ["email":email,"password":password]
        Alamofire.request(baseURL+"auth/login/", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { (response) in
                self.handleAuth(response: response, completion: completion)
        }
    }
    
    func register(newUser: User, password: String, completion: @escaping DataProviderProtocol.authCompletion) {
        var parameters : Parameters = newUser.toJSON()!
        parameters["password"] = password
        Alamofire.request(baseURL+"auth/register/",method: .post, parameters:parameters, encoding:JSONEncoding.default)
            .responseJSON { (response) in
                self.handleAuth(response: response, completion: completion)
        }
    }
    
    private func handleAuth(response:DataResponse<Any>,completion:authCompletion) {
        if let error = self.handleError(response) {
            completion(false,nil,error)
            return
        }
        if let res = response.value as? [String:Any] {
            completion(true,res["token"] as? String,nil)
        }
    }
    
    
    func getProfile(token: String?, completion: @escaping DataProviderProtocol.profileCompletion) {
        Alamofire.request(baseURL+"profile/",method: .get,headers:self.generateHeader(token))
            .responseJSON { (response) in
                if let error = self.handleError(response) {
                    completion(nil, error)
                    return
                }
                if let res = response.value as? [String:Any] {
                    completion(User(json: res), nil)
                }
        }
    }
    
    func updateProfile(token: String?, profile: User, completion: @escaping DataProviderProtocol.errorHandler) {
        Alamofire.request(baseURL+"profile/",method: .post, parameters:profile.toJSON(),encoding:JSONEncoding.default, headers:self.generateHeader(token)).responseJSON { (response) in
            completion(self.handleError(response))
        }
        
    }
    
    func getArtworkList(token: String?, completion: @escaping DataProviderProtocol.artworkListCompletion) {
        Alamofire.request(baseURL+"artworks/").responseJSON { (response) in
            self.handleArtworkList(response: response, completion: completion)
        }
    }
    
    private func handleArtworkList(response:DataResponse<Any>,completion:artworkListCompletion) {
        if let error = self.handleError(response) {
            completion(nil,error)
            return
        }
        if let res = response.value as? [[String:Any]] {
            let artworkList = res.map({ (artwork) -> Artwork in
                return Artwork(json: artwork)!
            })
            completion(artworkList,nil)
        }
    }
    
    func getCommentList(token: String?, artworkId: String?, completion: @escaping DataProviderProtocol.commentListCompletion) {
        Alamofire.request(baseURL+"artworks/"+artworkId!+"/comments/").responseJSON { (response) in
            if let error = self.handleError(response) {
                completion(nil, error)
                return
            }
            if let res = response.value as? [[String:Any]] {
                let commentList = res.map({ (comment) -> Comment in
                    return Comment(json: comment)!
                })
                completion(commentList,nil)
            }
        }
    }
    
    func postComment(token: String?, content: String?, artworkId: String?, completion: @escaping DataProviderProtocol.errorHandler) {
        let parameters : Parameters = ["content":content!]
        Alamofire.request(baseURL+"artworks/"+artworkId!+"/comments/",method: .post, parameters:parameters,encoding:JSONEncoding.default, headers:self.generateHeader(token)).responseJSON { (response) in
            completion(self.handleError(response))
        }
        
    }
    
    func deleteComment(token: String?, commentId: String?, completion: @escaping DataProviderProtocol.errorHandler) {
        Alamofire.request(baseURL+"comments/"+commentId!+"/",method:.delete,headers:self.generateHeader(token)).responseJSON { (response) in
            completion(self.handleError(response))
        }
    }
    
    func reportComment(token: String?, commentId: String?, completion: @escaping DataProviderProtocol.errorHandler) {
        Alamofire.request(baseURL+"comments/"+commentId!+"/report/",method:.get,headers:self.generateHeader(token)).responseJSON { (response) in
            completion(self.handleError(response))
        }
    }
    
    func getArtwork(token: String?, artworkId: String?, completion: @escaping DataProviderProtocol.artworkCompletion) {
        Alamofire.request(baseURL+"artworks/"+artworkId!+"/",method:.get,headers:self.generateHeader(token)).responseJSON { (response) in
            if let error = self.handleError(response) {
                completion(nil,error)
                return
            }
            if let res = response.value as? [String:Any] {
                completion(Artwork(json: res),nil)
            }
        }
    }
    
    func updateBookmark(token: String?, artworkId: String?, newBookmarkState: Bool?, completion: @escaping DataProviderProtocol.errorHandler) {
        let parameters : Parameters = ["is_bookmarked":newBookmarkState!]
        Alamofire.request(baseURL+"artworks/"+artworkId!+"/bookmark/", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: self.generateHeader(token)).responseJSON { (response) in
            completion(self.handleError(response))
        }
    }
    
    func updateRating(token: String?, artworkId: String?, newRating: Int?, completion: @escaping DataProviderProtocol.errorHandler) {
        let parameters : Parameters = ["rating":newRating!]
        Alamofire.request(baseURL+"artworks/"+artworkId!+"/rating/", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: self.generateHeader(token)).responseJSON { (response) in
            completion(self.handleError(response))
        }
    }
    
    func getBookmarkList(token: String?, completion: @escaping DataProviderProtocol.artworkListCompletion) {
        Alamofire.request(baseURL+"bookmarks/", method: .get,headers: self.generateHeader(token)).responseJSON { (response) in
            self.handleArtworkList(response: response, completion: completion)
        }
    }
    
    func getPasswordResetUrl(completion: @escaping DataProviderProtocol.urlCompletion) {
        completion(baseURL+"password/forget/",nil)
    }
    
    private func generateHeader(_ token:String?) -> HTTPHeaders {
        return token == nil ? [:] : ["Authorization": "Bearer " + token!]
    }
    
    private func handleError(_ response:DataResponse<Any>) -> Error? {
        let statusCode : Int? = response.response?.statusCode
        if statusCode == nil {
            return response.error
        }
        if response.response?.statusCode == 200 {
            return nil
        } else {
            return HTTPResponseError(statusCode!, description: HTTPURLResponse.localizedString(forStatusCode: statusCode!))
        }
    }
    
    
    
}
