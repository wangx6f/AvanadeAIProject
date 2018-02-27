//
//  BookmarkViewController.swift
//  AvanadeAIProject
//
//  Created by Xinyuan Wang on 2/2/18.
//  Copyright © 2018 Avanade. All rights reserved.
//

import UIKit
import CHTCollectionViewWaterfallLayout
import Kingfisher

class BookmarkViewController: UICollectionViewController
{

    private let detailSegueIdentifier = "goToDetail"
    private let collectionViewSectionInset = UIEdgeInsets(top: CGFloat(10), left: CGFloat(10), bottom: CGFloat(10), right: CGFloat(10))
    private var artworkList = [Artwork]()
    
    // MARK: override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configCollectionView()
        DataManager.sharedInstance.bookmarkDelegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DataManager.sharedInstance.updateBookmarkList()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        DataManager.sharedInstance.selectedArtwork = artworkList[indexPath.row] 
        performSegue(withIdentifier: detailSegueIdentifier, sender: self)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return artworkList.count
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let artwork = artworkList[indexPath.row]
        let cell : ImageCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.collectionCellReuseIdentifier, for: indexPath) as! ImageCollectionCell
        cell.numOfCommentLabel.text = artwork.commentCount == nil ? "" : String(describing: artwork.commentCount!)
        if artwork.rating != nil && artwork.rating != 0 {
            cell.ratingView.isHidden = false
            cell.ratingView.rating = Double(artwork.rating!)
        } else {
            cell.ratingView.isHidden = true
        }
        cell.numOfViewLabel.text = artwork.viewCount == nil ? "" : String(describing:artwork.viewCount!)
        cell.imageView.kf.indicatorType = .activity
        cell.imageView.kf.setImage(with:URL(string:artwork.afterImageURL!))
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
extension BookmarkViewController : CHTCollectionViewDelegateWaterfallLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let artwork = artworkList[indexPath.row]
        return CGSize(width: CGFloat(artwork.width!), height: CGFloat(artwork.height!))
    }
}

extension BookmarkViewController : BookmarkDelegate {
    func bookmarkListDidReady(bookmarkList: [Artwork]) {
        endWaitactivity()
        self.artworkList = bookmarkList
        self.collectionView?.reloadData()
        
    }
    
    func bookmarkListWillReady() {
        startWaitActivity()
    }
    
    func errorDidOccur(_ error: Error) {
        endWaitactivity()
        _ = handleError(error)
    }
    
    
}
