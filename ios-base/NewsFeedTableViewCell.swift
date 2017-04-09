//
//  NewsFeedTableViewCell.swift
//  ios-base
//
//  Created by Kasra Koushan on 2017-02-28.
//  Copyright © 2017 Kyle Rosenbluth. All rights reserved.
//

import UIKit
import Parse

class NewsFeedTableViewCell: UITableViewCell {

    @IBOutlet var postNameLabel: UILabel?
    @IBOutlet var viewProfileButton: UIButton?
    @IBOutlet var usernameLabel: UILabel?
    @IBOutlet var postContentLabel: UILabel?
    @IBOutlet var timestampLabel: UILabel?
    var post: Post
    var user: PFUser
    var parent: NewsFeedViewController
    
    init(post: Post, user: PFUser, parent: NewsFeedViewController) {
        self.post = post
        self.user = user
        self.parent = parent
        super.init(style: .default, reuseIdentifier: "newsFeedCell")
    }
    
    required init?(coder aDecoder: NSCoder) {
        // setup dummy values
        // should never be initialized this way
        self.post = Post(postName: "null", username: "null", content: "null", timeStamp: "null")
        self.user = PFUser()
        self.parent = NewsFeedViewController()
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        postNameLabel?.text = post.pfObject.object(forKey: "postName") as? String
        usernameLabel?.text = post.pfObject.object(forKey: "username") as? String
        postContentLabel?.text = post.pfObject.object(forKey: "content") as? String
        timestampLabel?.text = post.pfObject.object(forKey: "timeStamp") as? String
    }
    
    @IBAction func viewProfileButtonPressed(_ sender: UIButton) {
        self.parent.viewProfile(user: self.user)
    }
    
}
