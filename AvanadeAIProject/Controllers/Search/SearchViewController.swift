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
    
    var artworkList = [Artwork]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSearchBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateList(searchText: searchBar.text!)
    }
    
    private func setUpSearchBar() {
        searchBar.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artworkList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DataManager.sharedInstance.selectedArtwork = artworkList[indexPath.row]
        DataManager.sharedInstance.addSearchHistory(artwork: artworkList[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: detailSegueIdentifier, sender: self)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let artwork = artworkList[indexPath.row]
        guard let cell: SearchViewTableCell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? SearchViewTableCell
            else {
            return UITableViewCell()
            }
        cell.nameLabel.text = artwork.title == nil ? "" : String(describing:artwork.title!)
        cell.imagesView?.kf.indicatorType = .activity
        cell.imagesView?.kf.setImage(with:URL(string:artwork.afterImageURL!))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        updateList(searchText: searchText)
    }
    
    private func updateList(searchText: String) {
        if !searchText.isEmpty {
            DataManager.sharedInstance.search(keyword: searchText, completion: { (artworkList, error) in
                if (!self.handleError(error)) {
                    self.artworkList = artworkList!
                    self.table.reloadData()
                }
            })
        } else {
            displaySearchHistory()
        }
    }
    
    
    private func displaySearchHistory() {
        DataManager.sharedInstance.getSearchHistory { (artworkList, error) in
            if !self.handleError(error) {
                self.artworkList = artworkList!
                self.table.reloadData()
            }
        }
    }
    
}

