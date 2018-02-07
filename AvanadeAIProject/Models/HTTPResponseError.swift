//
//  HTTPResponseError.swift
//  AvanadeAIProject
//
//  Created by Xinyuan Wang on 2/4/18.
//  Copyright © 2018 Avanade. All rights reserved.
//

import Foundation

class HTTPResponseError : Error {
    
    public let statusCode : Int
    
    public let description : String
    
    init(_ statusCode : Int, description : String){
        self.statusCode = statusCode
        self.description = description
    }

}
