//
//  CommentTableCell.swift
//  AvanadeAIProject
//
//  Created by Xinyuan Wang on 1/11/18.
//  Copyright © 2018 Avanade. All rights reserved.
//

import UIKit

class CommentTableCell: UITableViewCell {

    @IBOutlet var name: UILabel!
    
    @IBOutlet var content: UITextView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        content.textContainer.maximumNumberOfLines = 2
        content.textContainer.lineBreakMode = .byTruncatingTail
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
