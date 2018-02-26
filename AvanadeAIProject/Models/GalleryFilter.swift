//
//  Filter.swift
//  AvanadeAIProject
//
//  Created by Xinyuan Wang on 1/18/18.
//  Copyright © 2018 Avanade. All rights reserved.
//

import Foundation

enum SortOptions : String {
    case hottest,most_recent,most_rated,best_rated
    init?(tag: Int) {
        switch tag {
        case 1: self = .hottest
        case 2: self = .most_recent
        case 3: self = .most_rated
        case 4: self = .best_rated
        default: return nil
        }
    }
    
    static let count = 4
}

//enum GenreOptions : String {
//    case all,landscape,abstract,portrait,still_life
//    init?(tag: Int) {
//        switch tag {
//        case 1: self = .all
//        case 2: self = .landscape
//        case 3: self = .abstract
//        case 4: self = .portrait
//        case 5: self = .still_life
//        default: return nil
//        }
//    }
//
//    static let count = 5
//}


struct GalleryFilter {
    
    public var selectedSortTag : Int = 1

    
    public func getSelectedSortOption()->SortOptions {
        return SortOptions(tag: selectedSortTag)!
    }
    
//    public var selectedGenreTag : Int = 1
//    public func getSelectedGenreOption() -> GenreOptions {
//        return GenreOptions(tag: selectedGenreTag)!
//    }
}


