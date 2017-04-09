//
//  NewsFeedTableViewCell.swift
//  ios-base
//

import UIKit
import Parse

class NewsFeedTableViewCell: UITableViewCell {

    @IBOutlet var postNameLabel: UILabel?
    @IBOutlet var viewProfileButton: UIButton?
    @IBOutlet var usernameLabel: UILabel?
    @IBOutlet var postContentLabel: UILabel?
    @IBOutlet var timestampLabel: UILabel?
    var parent: NewsFeedViewController?
    var user: PFUser?
    
    func loadData(post: Post, user: PFUser?, parent: NewsFeedViewController) {
        self.parent = parent
        self.user = user
        
        postNameLabel?.text = post.pfObject["postName"] as? String
        usernameLabel?.text = post.pfObject["username"] as? String
        postContentLabel?.text = post.pfObject["content"] as? String
        timestampLabel?.text = post.pfObject["timeStamp"] as? String
    }
    
    @IBAction func viewProfileButtonPressed(_ sender: UIButton) {
        if let user = self.user {
            self.parent?.viewProfile(user: user)
        }
    }
}
