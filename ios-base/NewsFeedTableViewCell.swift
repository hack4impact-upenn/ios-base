//
//  NewsFeedTableViewCell.swift
//  ios-base
//

import UIKit
import Parse

class NewsFeedTableViewCell: UITableViewCell {

    @IBOutlet var postNameLabel: UILabel?
    @IBOutlet var usernameButton: UIButton?
    @IBOutlet var postContentLabel: UILabel?
    @IBOutlet var timestampLabel: UILabel?
    var parent: NewsFeedViewController?
    var user: PFUser?
    
    func loadData(post: Post, parent: NewsFeedViewController) {
        self.parent = parent
        self.user = post.pfObject["user"] as? PFUser
        
        do {
            try self.user!.fetchIfNeeded()
        } catch let error as NSError {
            print("Fetch failed: \(error.localizedDescription)")
        }
        
        postNameLabel?.text = post.pfObject["postName"] as? String
        usernameButton?.setTitle(self.user!.username, for: UIControlState.normal)
        postContentLabel?.text = post.pfObject["content"] as? String
        timestampLabel?.text = post.pfObject["timeStamp"] as? String
        
        self.selectionStyle = UITableViewCellSelectionStyle.none
    }
    
    @IBAction func viewProfileButtonPressed(_ sender: UIButton) {
        self.parent?.viewProfile(user: self.user!)
    }
}
