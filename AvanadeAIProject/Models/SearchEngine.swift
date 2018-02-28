//
//  SearchEngine.swift
//  AvanadeAIProject
//
//  Created by Xinyuan Wang on 2/24/18.
//  Copyright © 2018 Avanade. All rights reserved.
//

import Foundation
import JWTDecode

class SearchEngine {
    
    private let userId : String
    
    private var artworkTable : [String:Artwork]?
    
    private var searchHistory : Set<String>?
    

    
    init?(token:String?,artworkList:[Artwork]?){
        do {
            userId = try decode(jwt: token!).claim(name: "id").string!
            updateArtworkTable(artworkList: artworkList!)
            if let historyList = UserDefaults.standard.array(forKey: userId) as! [String]? {
                searchHistory = Set(historyList)
            }
        } catch {
            return nil
        }
    }
    
    public func updateArtworkTable(artworkList:[Artwork]) {
        artworkTable = [String:Artwork]()
        for artwork in artworkList {
            artworkTable![artwork.id!] = artwork
        }
    }
    
    public func addHistory(artwork:Artwork) {
        if searchHistory == nil {
            searchHistory = Set()
        }
        searchHistory?.insert(artwork.id!)
        UserDefaults.standard.set(Array(searchHistory!),forKey:userId)
    }
    
    public func getHistory() -> [Artwork] {
        var result = [Artwork]()
        if searchHistory != nil {
            for id in searchHistory! {
                result.append(artworkTable![id]!)
            }
        }
        return result
    }
    
    public func clearHistory() {
        if searchHistory != nil {
            searchHistory?.removeAll()
            UserDefaults.standard.set(Array(searchHistory!),forKey:userId)
        }
    }
    
    public func search(keyword:String) -> [Artwork] {
        var result = [Artwork]()
        let key = keyword.lowercased()
        if let artworkTable = artworkTable {
            for (_,artwork) in artworkTable {
                if (artwork.title?.lowercased().contains(key))! || (artwork.author?.lowercased().contains(key))! {
                    result.append(artwork)
                }
            }
        }
        return result
    }
    
}
