//
//  Filter.swift
//  AvanadeAIProject
//
//  Created by Xinyuan Wang on 1/18/18.
//  Copyright © 2018 Avanade. All rights reserved.
//

import Foundation

struct GalleryFilter {
    
    static public let sortOptions = ["hottest","most-recent","most-rated","best-rated"]
    // make sure the "all" tag is in the index 0
    static public let genreOptions = ["all","landscape","abstract","portrait","still-life"]
    public var curSortOptionIndex : Int = 0
    public private(set) var curGenreOptionIndexs : [Int] = [0]
    
    public mutating func genreChange(_ index:Int) {
        
        // if "all" is being (un)selected => select "all" as default
        if index == 0 {
            curGenreOptionIndexs = [0]
            return
        }
        
        if curGenreOptionIndexs.contains(index) {
            curGenreOptionIndexs.remove(at: curGenreOptionIndexs.index(of: index)!)
        } else {
            curGenreOptionIndexs.append(index)
        }
        
        
        // further process the result
        if curGenreOptionIndexs.count==0 || curGenreOptionIndexs.count==GalleryFilter.genreOptions.count-1 {
            curGenreOptionIndexs = [0]  // no genre is selected or all genere are selected => select "all" as default
        } else if curGenreOptionIndexs.contains(0) {
            curGenreOptionIndexs.remove(at: curGenreOptionIndexs.index(of:0)!)  // "all" and other option(s) are selected at the same time => unselect "all"
        }
    }
}


extension GalleryFilter : CustomStringConvertible {
    
    var description: String {
        var description = "Sorted by: " + GalleryFilter.sortOptions[curSortOptionIndex] + "\nSelected genre: "
        for index in curGenreOptionIndexs {
            description += GalleryFilter.genreOptions[index] + " "
        }
        return description
    }
}
