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
    func didPressImage(viewController:UIViewController);
}

class DetailTableCell: UITableViewCell {

    public var delegate : DetailTableCellDelegate!
    
    @IBOutlet var artworkImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configImageTapGestureRecognizer()
        setImageRatio(CGFloat(1))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func setImageRatio(_ ratio:CGFloat) {
        let ratioConstraint = NSLayoutConstraint(item: artworkImageView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: artworkImageView, attribute: NSLayoutAttribute.width, multiplier: ratio, constant: CGFloat(0))
        artworkImageView.addConstraint(ratioConstraint)
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
}


