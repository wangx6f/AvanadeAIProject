//
//  DetailViewController.swift
//  AvanadeAIProject
//
//  Created by Xinyuan Wang on 1/7/18.
//  Copyright © 2018 Avanade. All rights reserved.
//

import UIKit

protocol CommentListDelegate : NSObjectProtocol {
    func refreshCommentList(commentList:[Comment]?)
    func errorDidOccur(_ error:Error)
}

class DetailViewController: UITableViewController {
    
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var noCommentLabel: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    // MARK: constants
    private let viewCommentTableCellReuseIdentifier = "viewCommentTableCell"
    private let commentDetailSegueIdentifier = "goToCommentDetail"
    private let allCommentsSegueIdentifier = "goToAllComments"
    private let maxCommentNum = 6
    
    weak private var commentListDelegate : CommentListDelegate?
    private var commentList : [Comment]?
    
    // MARK: override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        DataManager.sharedInstance.detailDelegate = self
        navigationItem.title = DataManager.sharedInstance.selectedArtwork?.title
        DataManager.sharedInstance.updateCommentList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let detailCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? DetailTableCell {
            detailCell.resume()
        }
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case allCommentsSegueIdentifier?:
            let commentListView : CommentListDelegate = segue.destination as! CommentListDelegate
            self.commentListDelegate = commentListView
            commentListView.refreshCommentList(commentList: commentList)
            break
        case commentDetailSegueIdentifier?:
            let commentDetailView : CommentDetailViewController = segue.destination as! CommentDetailViewController
            commentDetailView.comment = sender as? Comment
            break
        default:
            break
        }
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
        if indexPath.section == 0 {
            return constructDetailCell()
        }
        
        // render the additional cell for routing to all comments view
        if commentList!.count > maxCommentNum && indexPath.row == maxCommentNum {
            return constructViewCommentCell(commentList!.count)
        }
        // regular comment cell
        return constructCommentCell(commentList![indexPath.row])
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        if let commentList = commentList {
            // # of comment exceed maximum, which required an additional cell for routing to all comments view
            if commentList.count > maxCommentNum {
                return maxCommentNum + 1
            }
            return commentList.count
        }
        // comment list has not been loaded yet or comment list is empty
        return 0
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
            performSegue(withIdentifier: commentDetailSegueIdentifier, sender: commentList?[indexPath.row])
        }
        tableView.deselectRow(at: indexPath, animated: true)
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
    
    
    private func constructDetailCell() -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.detailTableCellReuseIdentifier) as! DetailTableCell
        cell.delegate = self
        cell.loadArtwork(DataManager.sharedInstance.selectedArtwork)
        return cell
    }
    
    private func constructCommentCell(_ comment:Comment) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.commentTableCellReuseIdentifier) as! CommentTableCell
        cell.content.text = comment.content
        cell.name.text = comment.reviewer
        return cell
    }
    
    
    private func constructViewCommentCell(_ number:Int) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: viewCommentTableCellReuseIdentifier)
        cell?.textLabel?.text = "View all \(number) of comments"
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
            DataManager.sharedInstance.updateRating(newRating: score)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        present(alert, animated: true, completion: nil)
        
    }
    
    func didPressImage(viewController: UIViewController) {
        present(viewController, animated: true, completion: nil)
    }
    
    func didPressBookmark(updateButtonState: (Bool) -> Void) {
        DataManager.sharedInstance.toggleBookmark()
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
    func refreshArtwork() {
        if let detailCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? DetailTableCell {
            detailCell.refreshArtwork(DataManager.sharedInstance.selectedArtwork)
        }
    }
    
    func commentListDidReady(commentList: [Comment]) {
        self.commentList = commentList
        if commentList.count == 0 {
            footerViewUpdate(loading: false, noComment: true)
        } else {
            footerViewUpdate(loading: false, noComment: false)
        }
        tableView.reloadSections([1], with: UITableViewRowAnimation.automatic)
        
        // propagate data if necessary
        if let delegate = commentListDelegate {
            delegate.refreshCommentList(commentList: commentList)
        }
    }
    
    func commentListWillReady() {
        commentList = nil
        footerViewUpdate(loading: true, noComment: false)
        tableView.reloadSections([1], with: UITableViewRowAnimation.automatic)
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

