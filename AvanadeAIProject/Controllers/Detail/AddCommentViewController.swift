//
//  AddCommentViewController.swift
//  AvanadeAIProject
//
//  Created by Xinyuan Wang on 1/23/18.
//  Copyright © 2018 Avanade. All rights reserved.
//

import UIKit

class AddCommentViewController: UIViewController {

    var artwork : Artwork?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        propagateData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func propagateData(){
        if let detailViewController = self.childViewControllers.first?.childViewControllers.first as? DetailViewController  {
            detailViewController.artwork = artwork
        }
    }

}
