//
//  ShareActivityItemSource.swift
//  AvanadeAIProject
//
//  Created by Xinyuan Wang on 1/23/18.
//  Copyright © 2018 Avanade. All rights reserved.
//

import UIKit

class ShareActivityItemProvider : UIActivityItemProvider {
    
    private var imageUrl : String = ""
    
    init(url:String){
        super.init(placeholderItem: UIImage())
        imageUrl = url
    }
    
    override var item: Any {
        let url = URL(string: imageUrl)
        let data = try? Data(contentsOf: url!)
        return UIImage(data: data!) as Any
    }
    

}
    

