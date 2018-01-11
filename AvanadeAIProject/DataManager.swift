//
//  DataManager.swift
//  AvanadeAIProject
//
//  Created by Timothy DenOuden on 1/10/18.
//  Copyright © 2018 Avanade. All rights reserved.
//

import Foundation
import UIKit

final class DataManager {
    static let sharedInstance = DataManager()
    
    private let dataProvider: DataProviderProtocol
    
    private init() {
        dataProvider = DummyDataProvider()
    }
    
    func imageFrom(url: String) -> UIImage {
        return dataProvider.imageFrom(url: url)
    }
    
    func userWith(id: Int) -> User {
        return dataProvider.userWith(id: id)
    }
    
    func artworkWith(id: Int) -> Artwork {
        return dataProvider.artworkWith(id: id)
    }
}
