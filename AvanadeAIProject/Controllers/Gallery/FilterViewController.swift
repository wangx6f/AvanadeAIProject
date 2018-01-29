//
//  FilterViewController.swift
//  AvanadeAIProject
//
//  Created by Xinyuan Wang on 1/18/18.
//  Copyright © 2018 Avanade. All rights reserved.
//

import UIKit
import LGButton

protocol FilterDelegate {
    // notify that that the filter is being updated
    func filterUpdated(newFilter:GalleryFilter)
}

class FilterViewController: UIViewController {

    var filter: GalleryFilter = GalleryFilter()
    var filterDelegate : FilterDelegate?
    
    @IBOutlet weak var sortOptionContainer: UIView!
    @IBOutlet weak var genreOptionContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onCancelPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onDonePressed(_ sender: UIBarButtonItem) {
        filterDelegate?.filterUpdated(newFilter: filter)
        dismiss(animated: true, completion: nil)
        
    }
    
    // assuming the tag of the button map to the index + 1 of the options array
    @IBAction func onSortPressed(_ sender: LGButton) {
        filter.selectedSortTag = sender.tag
        updateUI()
    }
    
    @IBAction func onGenrePressed(_ sender: LGButton) {
        filter.selectedGenreTag = sender.tag
        updateUI()
    }
    
    private func updateUI() {
        updateButtonGroup(groupContainer: sortOptionContainer, curTag: filter.selectedSortTag, optionCount: SortOptions.count)
        updateButtonGroup(groupContainer: genreOptionContainer, curTag: filter.selectedGenreTag, optionCount: GenreOptions.count)
    }
    
    // assuming the tag of the button map to the index + 1 of the options array
    private func updateButtonGroup(groupContainer:UIView, curTag:Int, optionCount:Int) {
        for index in 1...optionCount {
            let curButton : LGButton = groupContainer.viewWithTag(index) as! LGButton
            if index == curTag {
                curButton.leftIconColor = Constants.lightBlue
                curButton.leftIconString = "checkmark-circled"
                curButton.leftIconFontSize = CGFloat(18.5)
            } else {
                
                curButton.leftIconColor = UIColor.lightGray
                curButton.leftIconString = "ios-circle-outline"
                curButton.leftIconFontSize = CGFloat(20)
               
            }
        }
    }
    
}
