//
//  DataProviderProtocol.swift
//  AvanadeAIProject
//
//  Created by Timothy DenOuden on 1/10/18.
//  Copyright © 2018 Avanade. All rights reserved.
//

import Foundation
import UIKit

protocol DataProviderProtocol {
   
    func login(email:String,password:String,completion: @escaping authCompletion)
    
    func register(newUser:User,password:String,completion:@escaping authCompletion)
    
    func getProfile(token:String?,completion:@escaping profileCompletion)
    
    func updateProfile(token:String?,profile:User,completion:@escaping errorHandler)
    
    func updateGoogleProfile(profile:User,completion:@escaping authCompletion)
    
    func updateFacebookProfile(profile:User,completion:@escaping authCompletion)
    
    func getArtworkList(token:String?,completion:@escaping artworkListCompletion)
    
    func getCommentList(token:String?,artworkId:String?,completion:@escaping commentListCompletion)
    
    func postComment(token:String?,content:String?,artworkId:String?,completion:@escaping errorHandler)
    
    func deleteComment(token:String?,commentId:String?,completion:@escaping errorHandler)
    
    func reportComment(token:String?,commentId:String?,completion:@escaping errorHandler)
    
    func getArtwork(token:String?,artworkId:String?,completion:@escaping artworkCompletion)
    
    func updateBookmark(token:String?,artworkId:String?,newBookmarkState:Bool?,completion:@escaping errorHandler)
    
    func updateRating(token:String?,artworkId:String?,newRating:Int?,completion:@escaping errorHandler)
    
    func getBookmarkList(token:String?,completion:@escaping artworkListCompletion)
    
    func getPasswordResetUrl(completion:@escaping urlCompletion)
    
    typealias authCompletion =  (Bool?,String?,Error?)->Void
    typealias profileCompletion = (User?,Error?)->Void
    typealias artworkListCompletion = ([Artwork]?,Error?)->Void
    typealias errorHandler = (Error?)->Void
    typealias commentListCompletion = ([Comment]?,Error?)->Void
    typealias artworkCompletion = (Artwork?,Error?)->Void
    typealias urlCompletion = (String?,Error?)->Void

}


