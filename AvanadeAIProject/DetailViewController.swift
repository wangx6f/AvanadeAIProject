//
//  DetailViewController.swift
//  AvanadeAIProject
//
//  Created by Xinyuan Wang on 1/7/18.
//  Copyright © 2018 Avanade. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var artwork: Artwork!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        artwork = DataManager.sharedInstance.artworkWith(id: 1)
        updateUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.

    }

    @IBAction func back(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    private func updateUI() {
        self.title = artwork.title
        imageView.image = artwork.afterImage
        // etc for all the UI components on the page
    }
}


