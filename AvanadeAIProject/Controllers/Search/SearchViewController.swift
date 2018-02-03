//
//  SecondViewController.swift
//  AvanadeAIProject
//
//  Created by Xinyuan Wang on 1/6/18.
//  Copyright © 2018 Avanade. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var table: UITableView!
    
    private let detailSegueIdentifier = "goToDetail"
    var imagesArray = [Images]()
    var currentImageArray = [Images]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpImages()
        setUpSearchBar()
    }
    
    private func setUpImages() {
        imagesArray.append(Images(name: "The Great Wave", image:"1"))
        imagesArray.append(Images(name: "Hollywood", image:"2"))
        imagesArray.append(Images(name: "Starry Night", image:"3"))
        
        currentImageArray = imagesArray
    }
    
    private func setUpSearchBar() {
        searchBar.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentImageArray.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: detailSegueIdentifier, sender: self)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? SearchViewTableCell
            else {
            return UITableViewCell()
        }
        
        cell.nameLabel.text = currentImageArray[indexPath.row].name
        cell.imagesView.image = UIImage(named: currentImageArray[indexPath.row].image)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            currentImageArray = imagesArray
            table.reloadData()
            return
            
        }
        
        currentImageArray = imagesArray.filter({ images -> Bool in
            images.name.lowercased().contains(searchText.lowercased())})
        table.reloadData()
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

