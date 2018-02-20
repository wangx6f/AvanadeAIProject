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
    
    func getArtworkList(token:String?,completion:@escaping artworkListCompletion)
    
    func getCommentList(token:String?,artworkId:String?,completion:@escaping commentListCompletion)
    
    func postComment(token:String?,content:String?,artworkId:String?,completion:@escaping errorHandler)
    
    typealias authCompletion =  (Bool?,String?,Error?)->Void
    typealias profileCompletion = (User?,Error?)->Void
    typealias artworkListCompletion = ([Artwork]?,Error?)->Void
    typealias errorHandler = (Error?)->Void
    typealias commentListCompletion = ([Comment]?,Error?)->Void

}


