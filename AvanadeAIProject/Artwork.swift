//
//  Artwork.swift
//  AvanadeAIProject
//
//  Created by Timothy DenOuden on 1/9/18.
//  Copyright © 2018 Avanade. All rights reserved.
//

import Foundation
import UIKit

class Artwork {
    private var _id: Int
    private var _title: String
    private var _beforeImageURL: String
    private var _afterImageURL: String
    private var _beforeImage: UIImage?
    private var _afterImage: UIImage?
    private var _author: String
    private var _description: String
    private var _voteCount: Int
    private var _isSaved: Bool
    private var _rating: Double
    
    var id: Int {
        get { return _id }
    }
    var title: String {
        get { return _title }
    }
    var beforeImage: UIImage {
        get { return DataManager.sharedInstance.imageFrom(url: _beforeImageURL) }
    }
    var afterImage: UIImage {
        get { return DataManager.sharedInstance.imageFrom(url: _afterImageURL) }
    }
    var author: String {
        get { return _author }
    }
    var description: String {
        get { return _description }
    }
    var voteCount: Int {
        get { return _voteCount }
    }
    var isSaved: Bool {
        get { return _isSaved }
    }
    var rating: Double {
        get { return _rating }
    }
    
    public init(id: Int, title: String, beforeImageURL: String, afterImageURL: String, author: String, description: String, voteCount: Int, isSaved: Bool, rating: Double) {
        _id = id
        _title = title
        _beforeImageURL = beforeImageURL
        _afterImageURL = afterImageURL
        _author = author
        _description = description
        _voteCount = voteCount
        _isSaved = isSaved
        _rating = rating
    }
    
    public func dispose() {
        _beforeImage = nil
        _afterImage = nil
    }
}
