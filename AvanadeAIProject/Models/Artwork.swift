//
//  Artwork.swift
//  AvanadeAIProject
//
//  Created by Timothy DenOuden on 1/9/18.
//  Copyright © 2018 Avanade. All rights reserved.
//

import Foundation
import Gloss

class Artwork : JSONDecodable {

    
    private var _id: String?
    static public let JSON_ID = "id"
    
    private var _title: String?
    static public let JSON_TITLE = "title"
    
    private var _description: String?
    static public let JSON_DESCRIPTION = "description"
    
    private var _height : Float?
    static public let JSON_HEIGTH = "height"
    
    private var _width : Float?
    static public let JSON_WIDTH = "width"
    
    private var _sourceImageURL: String?
    static public let JSON_SOURCE_URL = "sourceImageUrl"
    
    private var _afterImageURL: String?
    static public let JSON_AFTER_URL = "afterImageUrl"

    private var _author: String?
    static public let JSON_AUTHOR = "author"

//    private var _isSaved: Bool
//    private var _myRating: Int
    
//    private var _commentCount: Int
//    private var _voteCount: Int
//    private var _rating: Double
//    private var _ratingCount : Int
    var id: String? {
        get { return _id }
    }
    
    var title: String? {
        get { return _title }
    }
    
    var description: String? {
        get { return _description }
    }
    
    var height : Float? {
        get {return _height}
    }
    
    var width : Float? {
        get {return _width}
    }
    
    var sourceImageURL : String? {
        get {return _sourceImageURL}
    }
    
    var afterImageURL : String? {
        get {return _afterImageURL}
    }
    
    var author: String? {
        get { return _author }
    }
    
//    var voteCount: Int {
//        get { return _voteCount }
//    }
//    var isSaved: Bool {
//        get { return _isSaved }
//    }
//    var rating: Double {
//        get { return _rating }
//    }
    
    required init?(json: JSON) {
        _id = Artwork.JSON_ID <~~ json
        _title = Artwork.JSON_TITLE <~~ json
        _description = Artwork.JSON_DESCRIPTION <~~ json
        _height = Artwork.JSON_HEIGTH <~~ json
        _width = Artwork.JSON_WIDTH <~~ json
        _sourceImageURL = Artwork.JSON_SOURCE_URL <~~ json
        _afterImageURL = Artwork.JSON_AFTER_URL <~~ json
        _author = Artwork.JSON_AUTHOR <~~ json
        
        
    }
    
}

