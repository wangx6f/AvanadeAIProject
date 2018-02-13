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
    
    private var _major: String?
    static public let JSON_MAJOR = "major"
    
    private var _gender: String?
    static public let JSON_GENDER = "gender"
    
    private var _age:Int?
    static public let JSON_AGE = "age"
    
    var email: String? {
        get { return _email }
    }
    var fName: String? {
        get { return _fName }
    }
    var lName: String? {
        get { return _lName }
    }
    var major: String? {
        get { return _major }
    }
    var gender: String? {
        get { return _gender }
    }
    var age:Int? {
        get {return _age}
    }
    
    required init?(json: JSON) {
        _email = User.JSON_EMAIL <~~ json
        _fName = User.JSON_FIRST_NAME <~~ json
        _lName = User.JSON_LAST_NAME <~~ json
        _age = User.JSON_AGE <~~ json
        _gender = User.JSON_GENDER <~~ json
        _major = User.JSON_MAJOR <~~ json
    }
    
    public init(email: String, fName: String, lName: String, major: String, gender: String, age:Int) {
        _email = email
        _fName = fName
        _lName = lName
        _major = major
        _gender = gender
        _age = age
    }
    
    
    func toJSON() -> JSON? {
        return jsonify([User.JSON_EMAIL~~>_email,
                        User.JSON_LAST_NAME~~>lName,
                        User.JSON_FIRST_NAME~~>fName,
                        User.JSON_AGE~~>_age,
                        User.JSON_GENDER~~>_gender,
                        User.JSON_MAJOR~~>_major
                        ])
    }
    
    
    

}
