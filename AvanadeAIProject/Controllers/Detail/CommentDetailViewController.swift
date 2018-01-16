//
//  CommentDetailViewController.swift
//  AvanadeAIProject
//
//  Created by Xinyuan Wang on 1/14/18.
//  Copyright © 2018 Avanade. All rights reserved.
//

import UIKit

class CommentDetailViewController: UIViewController {

<<<<<<< HEAD:AvanadeAIProject/Controllers/Detail/CommentDetailViewController.swift
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
=======
    @IBOutlet weak var imageView: UIImageView!
    
    var artwork: Artwork!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        artwork = DataManager.sharedInstance.artworkWith(id: 1)
        updateUI()
>>>>>>> model:AvanadeAIProject/DetailViewController.swift
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onBackPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    private func updateUI() {
        self.title = artwork.title
        imageView.image = artwork.afterImage
        // etc for all the UI components on the page
    }
}
