//
//  FirstViewController.swift
//  AvanadeAIProject
//
//  Created by Xinyuan Wang on 1/6/18.
//  Copyright © 2018 Avanade. All rights reserved.
//

import UIKit
import CHTCollectionViewWaterfallLayout

class GalleryViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        collectionViewConfig()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    // MARK: configuration
    private func collectionViewConfig() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "ImageCell", bundle: nil), forCellWithReuseIdentifier: "imageCell")
    
    }

    
}

// Extension for managing actions on items in collection view
extension GalleryViewController : UICollectionViewDelegate {
    
    
}

// Extension for managing the layout of collection view
extension GalleryViewController : CHTCollectionViewDelegateWaterfallLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // TODO: calculate the size of the cell base on ratio of the image and screen size
        return CGSize(width: CGFloat(150), height: CGFloat(100*(indexPath.row+1)))
    }
}

// Extension for managing the data source of collection view
extension GalleryViewController : UICollectionViewDataSource {
  

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // TODO: get the total number of collection cells from database
        return 3
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // TODO: load each individual image with its data to a cell
        return collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath)
    }
}

