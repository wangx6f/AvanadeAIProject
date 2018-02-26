//
//  FirstViewController.swift
//  AvanadeAIProject
//
//  Created by Xinyuan Wang on 1/6/18.
//  Copyright © 2018 Avanade. All rights reserved.
//

import UIKit
import CHTCollectionViewWaterfallLayout
import Kingfisher

class GalleryViewController: UICollectionViewController {

    

    // MARK: constants
    private let detailSegueIdentifier = "goToDetail"
    private let filterSegueIdentifier = "goToFilter"
    private let collectionViewSectionInset = UIEdgeInsets(top: CGFloat(10), left: CGFloat(10), bottom: CGFloat(10), right: CGFloat(10))
    private var filter = GalleryFilter()
    
    private var artworkList = [Artwork]()
    
    // MARK: override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configCollectionView()
        DataManager.sharedInstance.galleryDelegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DataManager.sharedInstance.updateArtworkList(filter: filter)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == filterSegueIdentifier {
            let filterViewController : FilterViewController = (segue.destination as! UINavigationController).topViewController as! FilterViewController
            filterViewController.filterDelegate = self
            filterViewController.filter = filter
        }
    }
    
    @IBAction func onRefreshPressed(_ sender: UIBarButtonItem) {
        DataManager.sharedInstance.updateArtworkList(filter: filter)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        DataManager.sharedInstance.selectedArtwork = artworkList[indexPath.row] 
        performSegue(withIdentifier: detailSegueIdentifier, sender: self)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // TODO: get the total number of collection cells from database
        return artworkList.count
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // TODO: load each individual image with its data to a cell
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
extension GalleryViewController : CHTCollectionViewDelegateWaterfallLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // TODO: calculate the size of the cell base on ratio of the image
        let artwork = artworkList[indexPath.row]
        return CGSize(width: CGFloat(artwork.width!), height: CGFloat(artwork.height!))
    }
}

//MARK: - Extenstion for FilterDelegate in the purpose of being notified changes on filter
extension GalleryViewController : FilterDelegate {
    
    func filterUpdated(newFilter: GalleryFilter) {
        filter = newFilter
        print(filter)
    }
}

extension GalleryViewController : GalleryDelegate {
    func artworkListDidReady(artworkList: [Artwork]) {
        endWaitactivity()
        self.artworkList = artworkList
        self.collectionView?.reloadData()
    }
    
    func artworkListWillReady() {
        startWaitActivity()
    }
    
    func errorDidOccur(_ error: Error) {
        endWaitactivity()
        _ = self.handleError(error)
    }

    
    
}



