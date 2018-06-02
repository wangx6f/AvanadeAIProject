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
    static public let JSON_FIRST_NAME = "first_name"
    
    private var _lName: String?
    static public let JSON_LAST_NAME = "last_name"
    
    private var _title: String?
    static public let JSON_TITLE = "title"
    
    private var _company: String?
    static public let JSON_COMPANY = "company"
    
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
    
    required init?(json: JSON) {
        _email = User.JSON_EMAIL <~~ json
        _fName = User.JSON_FIRST_NAME <~~ json
        _lName = User.JSON_LAST_NAME <~~ json
        _title = User.JSON_TITLE <~~ json
        _company = User.JSON_COMPANY <~~ json
    }
    
    public init(email: String, fName: String, lName: String, title: String, company: String) {
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
                        User.JSON_COMPANY~~>_company
                        ])
    }
    
    
    

}
