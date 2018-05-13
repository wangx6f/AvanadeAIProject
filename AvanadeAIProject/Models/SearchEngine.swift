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
    
    private var userId : String?
    
    private var artworkTable : [String:Artwork]?
    
    private var searchHistory : Set<String>?
    

    
    init?(token:String?,artworkList:[Artwork]?){
        if token != nil {
            do {
                let jwt = try decode(jwt: token!)
                if let id = jwt.claim(name: "id").string {
                    userId = id
                    if let historyList = UserDefaults.standard.array(forKey: userId!) as! [String]? {
                        searchHistory = Set(historyList)
                    }
                }
            } catch {
                return nil
            }
        }
        self.updateArtworkTable(artworkList: artworkList!)
    }
    
    public func updateArtworkTable(artworkList:[Artwork]) {
        artworkTable = [String:Artwork]()
        for artwork in artworkList {
            artworkTable![artwork.id!] = artwork
        }
    }
    
    public func addHistory(artwork:Artwork) {
        if(userId != nil) {
            if searchHistory == nil {
                searchHistory = Set()
            }
            searchHistory?.insert(artwork.id!)
            UserDefaults.standard.set(Array(searchHistory!),forKey:userId!)
        }
    }
    
    public func getHistory() -> [Artwork] {
        var result = [Artwork]()
        if searchHistory != nil {
            for id in searchHistory! {
                if let artworkName = artworkTable![id] {
                    result.append(artworkName)
                }
            }
        }
        return result
    }
    
    public func clearHistory() {
        if (userId != nil && searchHistory != nil) {
            searchHistory?.removeAll()
            UserDefaults.standard.set(Array(searchHistory!), forKey: userId!)
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
