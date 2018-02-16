//
//  DetailViewController.swift
//  AvanadeAIProject
//
//  Created by Xinyuan Wang on 1/7/18.
//  Copyright © 2018 Avanade. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {
    
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var noCommentLabel: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    // MARK: constants
    private let viewCommentTableCellReuseIdentifier = "viewCommentTableCell"
    private let commentDetailSegueIdentifier = "goToCommentDetail"
    private let maxCommentNum = 2
    
    
    private var commentList : [Comment]?
    
    // MARK: override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        loadArtwork()
        configTableView()
        
        // Debug purpose
        artworkDidReady(commentList: [Comment(json: [:])!,Comment(json: [:])!,Comment(json: [:])!])
    }
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: flag, completion: completion)
        DataManager.sharedInstance.selectedArtwork = nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // construct cell for each row
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            return constructDetailCell()
        }
        
        // render the additional cell for routing to all comments view
        if commentList!.count > maxCommentNum && indexPath.row == maxCommentNum + 1 {
            return constructViewCommentCell(commentList!.count)
        }
        // regular comment cell
        return constructCommentCell(commentList![indexPath.row - 1])
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let commentList = commentList {
            // # of comment exceed maximum, which required an additional cell for routing to all comments view
            if commentList.count > maxCommentNum {
                return maxCommentNum + 2
            }
            return commentList.count + 1
        }
        // comment list has not been loaded yet or comment list is empty
        return 1
    }
 
    // disable bounce on top edge
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y <= 0 {
            scrollView.contentOffset = CGPoint.zero
        }
    }
    
    // handle the transition to comment detail view
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath)?.reuseIdentifier == Constants.commentTableCellReuseIdentifier {
            performSegue(withIdentifier: commentDetailSegueIdentifier, sender: self)
        }
    }
    
    // MARK: UI methods
    @IBAction func onBackPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onSharePressed(_ sender: UIBarButtonItem) {
        showActivityVC()
    }
    
    // MARK: private methods
    private func configTableView() {
        // register cells
        tableView.register(UINib(nibName: Constants.detailTableCellNIBName, bundle: nil), forCellReuseIdentifier: Constants.detailTableCellReuseIdentifier)
        tableView.register(UINib(nibName: Constants.commentTableCellNIBName, bundle: nil), forCellReuseIdentifier: Constants.commentTableCellReuseIdentifier)
        // make the height of cell fit its content
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    private func loadArtwork() {
        let artwork = DataManager.sharedInstance.selectedArtwork
        navigationItem.title = artwork?.title
        
    }
    
    
    private func constructDetailCell() -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.detailTableCellReuseIdentifier) as! DetailTableCell
        cell.delegate = self
        cell.loadArtwork(DataManager.sharedInstance.selectedArtwork)
        return cell
    }
    
    private func constructCommentCell(_ comment:Comment) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.commentTableCellReuseIdentifier) as! CommentTableCell
        return cell
    }
    
    
    private func constructViewCommentCell(_ number:Int) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: viewCommentTableCellReuseIdentifier)
        return cell!
    }
    
    private func showActivityVC(){
        if let artwork = DataManager.sharedInstance.selectedArtwork {
            let shareViewController : UIActivityViewController = UIActivityViewController(activityItems: [ShareActivityItemProvider(url: (artwork.afterImageURL)!)], applicationActivities: nil)
            present(shareViewController, animated: true, completion:nil)
        }

    }
}

extension DetailViewController : DetailTableCellDelegate {
    
    func didPressRatingStarButton(score: Int, updateButtonsState: @escaping (Int) -> Void) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.alert)
        let attributedString = NSAttributedString(string: getRateAlertMessage(score), attributes: [
            NSAttributedStringKey.font : UIFont(name: "Helvetica Neue", size: CGFloat(18))!
            ])
    
        alert.setValue(attributedString, forKey: "attributedTitle")
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
            updateButtonsState(score)
            //TODO: update database
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        present(alert, animated: true, completion: nil)
        
    }
    
    func didPressImage(viewController: UIViewController) {
        present(viewController, animated: true, completion: nil)
    }
    
    func didPressBookmark(updateButtonState: (Bool) -> Void) {
        //TODO: update database for bookmark
        updateButtonState(true)
    }
    
    private func getRateAlertMessage(_ score:Int) -> String {
        var stars = ""
        for index in 1...5 {
            if index <= score {
                stars.append("★")
            } else {
                stars.append("☆")
            }
        }

        return "Rate \"" + navigationItem.title! + "\" with " + stars
    }
}


extension DetailViewController : DetailDelegate {
    
    func artworkDidReady(commentList: [Comment]) {
        loadArtwork()
        self.commentList = commentList
        if commentList.count == 0 {
            footerViewUpdate(loading: false, noComment: true)
        } else {
            footerViewUpdate(loading: false, noComment: false)
        }
        tableView.reloadData()
    }
    
    func artworkWillReady() {
        commentList = nil
        footerViewUpdate(loading: true, noComment: false)
        tableView.reloadData()
    }

    func errorDidOccur(_ error: Error) {
        _ = self.handleError(error)
    }

    
    private func footerViewUpdate(loading:Bool,noComment:Bool) {
        if loading {
            loadingIndicator.startAnimating()
        } else {
            loadingIndicator.stopAnimating()
        }
        noCommentLabel.isHidden = !noComment
    }

    
    
}

