//
//  DetailTableCell.swift
//  AvanadeAIProject
//
//  Created by Xinyuan Wang on 1/11/18.
//  Copyright © 2018 Avanade. All rights reserved.
//

import UIKit
import SimpleImageViewer
import Kingfisher
import Cosmos

protocol DetailTableCellDelegate {
    func didPressImage(viewController:UIViewController)
    func didPressBookmark(updateButtonState:(Bool)->Void)
    func didPressRatingStarButton(score:Int,updateButtonsState: @escaping (Int)->Void)
}

class DetailTableCell: UITableViewCell {

    public var delegate : DetailTableCellDelegate!
    
    @IBOutlet var artworkImageView: DetailImageView!
    
    @IBOutlet weak var bookmarkButton: UIButton!
    
    @IBOutlet var ratingStarButtons: [UIButton]!
    
    @IBOutlet weak var authorLabel: UILabel!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var rateCountLabel: UILabel!
    
    @IBOutlet weak var ratingStarView: CosmosView!
    override func awakeFromNib() {
        super.awakeFromNib()
        configImageTapGestureRecognizer()
    }
    
    public func loadArtwork(_ artwork:Artwork?) {
        if let artwork = artwork {
            
            setImageRatio(CGFloat(artwork.height!/artwork.width!))
            loadImageAsync(url: artwork.sourceImageURL!) { (image) in
                self.artworkImageView.loadImage(before: image)
            }
            loadImageAsync(url: artwork.afterImageURL!) { (image) in
                self.artworkImageView.loadImage(after: image)
            }
            refreshArtwork(artwork)
            
        }
    }
    
    public func resume() {
        artworkImageView.refresh()
    }
   
    public func refreshArtwork(_ artwork:Artwork?) {
        if let artwork = artwork {
            authorLabel.text = artwork.author
            descriptionTextView.text = artwork.description
            let rateLiteral = artwork.rateCount == nil || artwork.rateCount == 0 || artwork.rateCount == 1 ? "rate" : "rates"
            rateCountLabel.text = artwork.rateCount == nil ? "" : "\(artwork.rateCount!) \(rateLiteral)"
            ratingStarView.rating = Double(artwork.rating ?? 0)
            if let bookmarked = artwork.bookmarked {
                changeBookmarkState(bookmarked)
            }
            if let curRating = artwork.curRating {
                changeRatingStarButtonsState(curRating)
            }
        }
    }
    
    private func loadImageAsync(url:String,completion:@escaping (CGImage)->Void){
        ImageCache.default.retrieveImage(forKey: url, options: []) { (image, _) in
            if let image = image {
                completion(image.cgImage!)
            } else {
                ImageDownloader.default.downloadImage(with: URL(string: url)!, completionHandler: { (image, error, _, _) in
                    if error != nil {
                        // TODO: handle error
                        return
                    }
                    completion((image?.cgImage)!)
                    ImageCache.default.store(image!, forKey: url)
                })
            }
        }
    }
    
    private func setImageRatio(_ ratio:CGFloat) {
        let ratioConstraint = NSLayoutConstraint(item: artworkImageView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: artworkImageView, attribute: NSLayoutAttribute.width, multiplier: ratio, constant: CGFloat(0))
        artworkImageView.addConstraint(ratioConstraint)
    }
    
    @IBAction func bookmarkOnPressed(_ sender: UIButton) {
        delegate.didPressBookmark(updateButtonState: changeBookmarkState)
        
        
    }
    
    //override func prepareForSegue
    
    @IBAction func ratingStarButtonOnPressed(_ sender: UIButton) {
        delegate.didPressRatingStarButton(score: sender.tag, updateButtonsState: changeRatingStarButtonsState)
    }
    
    private func changeBookmarkState(_ isMarked:Bool){
        if !isMarked {
            bookmarkButton.setImage(#imageLiteral(resourceName: "BookmarkOutlineIcon"), for: UIControlState.normal)
        } else {
            bookmarkButton.setImage(#imageLiteral(resourceName: "BookmarkIcon"), for: UIControlState.normal)
        }
    }
    
    private func changeRatingStarButtonsState(_ score:Int){
        for ratingStarButton in ratingStarButtons {
            if ratingStarButton.tag <= score {
                ratingStarButton.setTitle("★", for: UIControlState.normal)
            } else {
                ratingStarButton.setTitle("☆", for: UIControlState.normal)
            }
        }
    }
    
    @objc private func imageOnPressed() {
        let configuration = ImageViewerConfiguration{config in config.imageView = artworkImageView}
        if (delegate != nil) {
            delegate.didPressImage(viewController: ImageViewerController(configuration: configuration))
        }
    }
    
    private func configImageTapGestureRecognizer() {
        let imageTapGestureRecognizer = UITapGestureRecognizer(target: self,action:#selector(imageOnPressed))
        artworkImageView.addGestureRecognizer(imageTapGestureRecognizer)
    }
    
    private func switchImageViewMode(mode:DisplayMode){

        artworkImageView.switchDisplay(mode: mode)
    }
    

    @IBAction func switchImage(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            switchImageViewMode(mode: DisplayMode.before)
        case 2:
            switchImageViewMode(mode: DisplayMode.compare)
        default:
            switchImageViewMode(mode: DisplayMode.after)
        }
        
    }
    
    
}


