//
//  DataProviderProtocol.swift
//  AvanadeAIProject
//
//  Created by Timothy DenOuden on 1/10/18.
//  Copyright © 2018 Avanade. All rights reserved.
//

import Foundation
import UIKit

protocol DataProviderProtocol {
    func imageFrom(url: String) -> UIImage
    func userWith(id: Int) -> User
    func artworkWith(id: Int) -> Artwork
}
