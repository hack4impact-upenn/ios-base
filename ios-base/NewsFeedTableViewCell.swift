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
    
    var post: Post?
    var parent: NewsFeedViewController?
    
    @IBAction func viewProfileButtonPressed(_ sender: UIButton) {
        if let username = post?.pfObject.object(forKey: "username") as? String {
            self.parent?.viewProfilePressed(profileUsername: username)
        }
    }
    
}
