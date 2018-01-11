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

    // MARK: UI reference
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    // MARK: constant
    private let collectionCellReuseIdentifier = "imageCollectionCell"
    private let collectionCellNIBName = "ImageCollectionCell"
    
    // MARK: override method
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewConfig()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // MARK: private method
    private func collectionViewConfig() {
        // set self as data source and delegate
        collectionView.delegate = self
        collectionView.dataSource = self
        // register the image collection cell
        collectionView.register(UINib(nibName: collectionCellNIBName, bundle: nil), forCellWithReuseIdentifier: collectionCellReuseIdentifier)
    
    }

    
}

//MARK: - Extension for UICollectionViewDelegate
extension GalleryViewController : CHTCollectionViewDelegateWaterfallLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // TODO: calculate the size of the cell base on ratio of the image and screen size
        return CGSize(width: CGFloat(150), height: CGFloat(100*(indexPath.row+1)))
    }
}

//MARK: - Extension for UICollectionViewDataSource
extension GalleryViewController : UICollectionViewDataSource {
  

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // TODO: get the total number of collection cells from database
        return 3
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // TODO: load each individual image with its data to a cell
        return collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellReuseIdentifier, for: indexPath)
    }
}

