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
    
}
