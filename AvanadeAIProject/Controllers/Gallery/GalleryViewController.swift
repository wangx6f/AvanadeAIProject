//
//  FirstViewController.swift
//  AvanadeAIProject
//
//  Created by Xinyuan Wang on 1/6/18.
//  Copyright © 2018 Avanade. All rights reserved.
//

import UIKit
import CHTCollectionViewWaterfallLayout

class GalleryViewController: UICollectionViewController {

    
    
    // MARK: constants

    private let detailSegueIdentifier = "goToDetail"
    private let collectionViewSectionInset = UIEdgeInsets(top: CGFloat(10), left: CGFloat(10), bottom: CGFloat(10), right: CGFloat(10))
    
    // MARK: override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configCollectionView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: detailSegueIdentifier, sender: self)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // TODO: get the total number of collection cells from database
        return 10
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // TODO: load each individual image with its data to a cell
        let cell : ImageCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.collectionCellReuseIdentifier, for: indexPath) as! ImageCollectionCell
        cell.numOfCommentLabel.text = "\(indexPath.row*100)"
        cell.numOfViewLabel.text = "\(indexPath.row*10)"
        cell.ratingView.rating = Double(indexPath.row)/5.0
        return cell
    }
    
    // MARK: private methods
    private func configCollectionView() {
        // register the image collection cell
        collectionView?.register(UINib(nibName: Constants.collectionCellNIBName, bundle: nil), forCellWithReuseIdentifier: Constants.collectionCellReuseIdentifier)
        // config the layout
        let layout : CHTCollectionViewWaterfallLayout =  collectionView!.collectionViewLayout as! CHTCollectionViewWaterfallLayout
        layout.sectionInset = collectionViewSectionInset
    }
    
    

    
}

//MARK: - Extension for UICollectionViewDelegate
extension GalleryViewController : CHTCollectionViewDelegateWaterfallLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // TODO: calculate the size of the cell base on ratio of the image
        return CGSize(width: CGFloat(500), height: CGFloat(100*(indexPath.row+1)))
    }
}


