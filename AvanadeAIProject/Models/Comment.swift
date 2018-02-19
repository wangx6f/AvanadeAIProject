//
//  Comment.swift
//  AvanadeAIProject
//
//  Created by Xinyuan Wang on 2/14/18.
//  Copyright © 2018 Avanade. All rights reserved.
//

import Foundation
import Gloss

class Comment : JSONDecodable {
    
    private var _id : String?
    static public let JSON_ID = "id"
    
    private var _reviewer : String?
    static public let JSON_REVIEWER = "reviewer"
    
    private var _editable : Bool?
    static public let JSON_EDITABLE = "editable"
    
    private var _content : String?
    static public let JSON_CONTENT = "content"
    
    var id : String? {
        get {return _id}
    }
    
    var reviewer : String? {
        get {return _reviewer}
    }
    
    var editable : Bool? {
        get {return _editable}
    }
    
    var content : String? {
        get {return _content}
    }
    
    required init?(json: JSON) {
        _id = Comment.JSON_ID <~~ json
        _reviewer = Comment.JSON_REVIEWER <~~ json
        _editable = Comment.JSON_EDITABLE <~~ json
        _content = Comment.JSON_CONTENT <~~ json
    }
    
    
}
