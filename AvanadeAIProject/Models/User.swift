//
//  User.swift
//  AvanadeAIProject
//
//  Created by Timothy DenOuden on 1/10/18.
//  Copyright © 2018 Avanade. All rights reserved.
//

import Foundation
import Gloss

class User : JSONDecodable,Glossy{
    
    private var _email: String?
    static public let JSON_EMAIL = "email"
    
    private var _fName: String?
    static public let JSON_FIRST_NAME = "firstName"
    
    private var _lName: String?
    static public let JSON_LAST_NAME = "lastName"
    
    private var _title: String?
    static public let JSON_TITLE = "title"
    
    private var _company: String?
    static public let JSON_COMPANY = "company"
    
    private var _deviceType = "ios"
    static public let JSON_DEVICE_TYPE = "deviceType"
    
    private var _googleToken: String?
    static public let JSON_GOOGLE_TOKEN = "googleToken"
    
    private var _facebookToken: String?
    static public let JSON_FACEBOOK_TOKEN = "facebookToken"
    
    var email: String? {
        get { return _email }
    }
    var fName: String? {
        get { return _fName }
    }
    var lName: String? {
        get { return _lName }
    }
    var title: String? {
        get { return _title }
    }
    var company: String? {
        get { return _company }
    }
    var googleToken: String? {
        get {
            return _googleToken
        }
        set {
            self._googleToken = newValue
        }
    }
    var facebookToken: String? {
        get {
            return _facebookToken
        }
        set {
            self._facebookToken = newValue
        }
    }
    
    required init?(json: JSON) {
        _email = User.JSON_EMAIL <~~ json
        _fName = User.JSON_FIRST_NAME <~~ json
        _lName = User.JSON_LAST_NAME <~~ json
        _title = User.JSON_TITLE <~~ json
        _company = User.JSON_COMPANY <~~ json
        _googleToken = User.JSON_GOOGLE_TOKEN <~~ json
        _facebookToken = User.JSON_FACEBOOK_TOKEN <~~ json
    }
    
    public init(email: String, fName: String, lName: String, title: String?, company: String?) {
        _email = email
        _fName = fName
        _lName = lName
        _title = title
        _company = company
    }
    
    
    func toJSON() -> JSON? {
        return jsonify([User.JSON_EMAIL~~>_email,
                        User.JSON_LAST_NAME~~>lName,
                        User.JSON_FIRST_NAME~~>fName,
                        User.JSON_TITLE~~>_title,
                        User.JSON_COMPANY~~>_company,
                        User.JSON_DEVICE_TYPE~~>_deviceType,
                        User.JSON_GOOGLE_TOKEN~~>_googleToken,
                        User.JSON_FACEBOOK_TOKEN~~>_facebookToken
                        ])
    }
    
    
    

}
