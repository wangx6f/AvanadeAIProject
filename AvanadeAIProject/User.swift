//
//  User.swift
//  AvanadeAIProject
//
//  Created by Timothy DenOuden on 1/10/18.
//  Copyright © 2018 Avanade. All rights reserved.
//

import Foundation

class User {
    enum Gender {
        case Male
        case Female
        case Other
    }
    
    private var _id: Int!
    private var _email: String!
    private var _fName: String?
    private var _lName: String?
    private var _major: String?
    private var _gender: Gender?
    
    var id: Int {
        get { return _id }
    }
    var email: String {
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
    var gender: Gender? {
        get { return _gender }
    }
    
    public init(id: Int, email: String, fName: String?, lName: String?, major: String?, gender: Gender?) {
        _id = id
        _email = email
        _fName = fName
        _lName = lName
        _major = major
        _gender = gender
    }
}
