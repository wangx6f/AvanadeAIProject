//
//  SecondViewController.swift
//  AvanadeAIProject
//
//  Created by Xinyuan Wang on 1/6/18.
//  Copyright © 2018 Avanade. All rights reserved.
//

import UIKit
import Kingfisher

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var table: UITableView!
    
    private let detailSegueIdentifier = "goToDetail"
    //var imagesArray = [Images]()
    //var currentImageArray = [Images]()
    
    var artworkList = [Artwork]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setUpImages()
        setUpSearchBar()
    }
    
    private func setUpImages(name: String, image: String) {
        //imagesArray.append(Images(name: "The Great Wave", image:"1"))
        //imagesArray.append(Images(name: "Hollywood", image:"2"))
        //imagesArray.append(Images(name: "Starry Night", image:"3"))
        
        //currentImageArray = imagesArray
        
        //artworkList.append(Images(name: artworkList[0].title! , image: artworkList[0].afterImageURL! ))
        
        
    }
    
    private func setUpSearchBar() {
        searchBar.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artworkList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DataManager.sharedInstance.selectedArtwork = artworkList[indexPath.row]
        
        DataManager.sharedInstance.addSearchHistory(artwork: artworkList[indexPath.row])

        performSegue(withIdentifier: detailSegueIdentifier, sender: self)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let artwork = artworkList[indexPath.row]

        guard let cell: SearchViewTableCell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? SearchViewTableCell
            else {
                //artworkList.append(Images(name: artwork.title , image: artwork.afterImageURL))
            return UITableViewCell()
            }
        
        
        cell.nameLabel.text = artwork.title == nil ? "" : String(describing:artwork.title!)
        cell.imagesView?.kf.indicatorType = .activity
        cell.imagesView?.kf.setImage(with:URL(string:artwork.afterImageURL!))
        //cell.imagesView.image = [UIImage, artwork.afterImageURL,:theURL];
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            //artworkList = artworkList
            DataManager.sharedInstance.search(keyword: searchText, completion: { (artworkList, error) in
                if (!self.handleError(error)) {
                self.artworkList = artworkList!
                
                self.table.reloadData()
                }
            })
            
            return
            
        }
        
        artworkList = artworkList.filter({ images -> Bool in
            (images.title?.lowercased().contains(searchText.lowercased()))!})
        table.reloadData()
    }
    
    func searchBarResultsListButtonClicked(_ searchBar: UISearchBar) {
        DataManager.sharedInstance.getSearchHistory { (artworkList, error) in
        self.handleError(error)
        }

    }
    
    
    
    
    class Images {
        let name: String
        let image: String
        init(name: String, image: String) {
            self.name = name;
            self.image = image;
        }
    }
    
}

