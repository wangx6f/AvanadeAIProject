//
//  DetailTableCell.swift
//  AvanadeAIProject
//
//  Created by Xinyuan Wang on 1/11/18.
//  Copyright © 2018 Avanade. All rights reserved.
//

import UIKit
import SimpleImageViewer

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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configImageTapGestureRecognizer()
        
        //TODO: for testing purpose
        setImageRatio(CGFloat(1))
        changeBookmarkState(false)
        artworkImageView.loadImage(before: #imageLiteral(resourceName: "before").cgImage,after:#imageLiteral(resourceName: "after").cgImage)
    }
    
    public func setImageRatio(_ ratio:CGFloat) {
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


