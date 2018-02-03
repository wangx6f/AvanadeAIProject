//
//  TableCell.swift
//  AvanadeAIProject
//
//  Created by Jason Kim on 1/14/18.
//  Copyright © 2018 Avanade. All rights reserved.
//

import UIKit

class SearchViewTableCell: UITableViewCell {

    @IBOutlet var imagesView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
