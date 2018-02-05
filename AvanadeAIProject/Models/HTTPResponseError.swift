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
    
    init(_ statusCode : Int){
        self.statusCode = statusCode
    }

}
