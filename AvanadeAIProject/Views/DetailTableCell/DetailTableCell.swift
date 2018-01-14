//
//  DetailTableCell.swift
//  AvanadeAIProject
//
//  Created by Xinyuan Wang on 1/11/18.
//  Copyright © 2018 Avanade. All rights reserved.
//

import UIKit

class DetailTableCell: UITableViewCell {


    @IBOutlet var artworkImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
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

}
