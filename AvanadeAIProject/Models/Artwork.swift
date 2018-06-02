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
    static public let JSON_HEIGTH = "processed_image_height"
    
    private var _width : Float?
    static public let JSON_WIDTH = "processed_image_width"
    
    private var _referenceImageURL: String? //added for original artist's artwork
    static public let JSON_REFERENCE_URL = "reference_image_url"
    
    private var _sourceImageURL: String?
    static public let JSON_SOURCE_URL = "source_image_url"
    
    private var _afterImageURL: String?
    static public let JSON_AFTER_URL = "processed_image_url"

    private var _author: String?
    static public let JSON_AUTHOR = "author"
    
    private var _rating : Float?
    static public let JSON_RATING = "rating"
    
    private var _ratingCount : Int?
    static public let JSON_RATING_COUNT = "rating_count"
    
    private var _commentCount : Int?
    static public let JSON_COMMENT_COUNT = "comment_count"
    
    private var _viewCount : Int?
    static public let JSON_VIEW_COUNT = "view_count"
    
    private var _bookmarked : Bool?
    static public let JSON_BOOKMARKED = "is_bookmarked"
    
    private var _curRating : Int?
    static public let JSON_CUR_RATING = "my_rating"

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
    
    var referenceImageURL : String? { //added to get the artist's original image (i.e the real "The Starry Night")
        get {return _referenceImageURL}
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
    
    var rateCount: Int? {
        get { return _ratingCount }
    }
    
    var rating: Float? {
        get { return _rating }
    }
    
    var commentCount: Int? {
        get { return _commentCount }
    }
    
    var viewCount : Int? {
        get {return _viewCount}
    }
    
    var bookmarked : Bool? {
        get {return _bookmarked}
    }
    
    var curRating : Int? {
        get {return _curRating}
    }
    
    required init?(json: JSON) {
        if let id: Int = Artwork.JSON_ID <~~ json {
            _id = String(id)
        }
        _title = Artwork.JSON_TITLE <~~ json
        _description = Artwork.JSON_DESCRIPTION <~~ json
        _height = Artwork.JSON_HEIGTH <~~ json
        _width = Artwork.JSON_WIDTH <~~ json
        _referenceImageURL = Artwork.JSON_REFERENCE_URL <~~ json
        _sourceImageURL = Artwork.JSON_SOURCE_URL <~~ json
        _afterImageURL = Artwork.JSON_AFTER_URL <~~ json
        _author = Artwork.JSON_AUTHOR <~~ json
        _ratingCount = Artwork.JSON_RATING_COUNT <~~ json
        _rating = Artwork.JSON_RATING <~~ json
        _commentCount = Artwork.JSON_COMMENT_COUNT <~~ json
        _viewCount = Artwork.JSON_VIEW_COUNT <~~ json
        _bookmarked = Artwork.JSON_BOOKMARKED <~~ json
        _curRating = Artwork.JSON_CUR_RATING <~~ json
    
    }
    
}

