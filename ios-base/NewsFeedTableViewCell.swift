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
    var post: Post?
    var parent: NewsFeedViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func viewProfileButtonPressed(_ sender: UIButton) {
        if let username = post?.pfObject.object(forKey: "username") as? String {
            self.parent?.viewProfilePressed(profileUsername: username)
        }
    }
    
    func updateInfo() {
        
        guard let post = self.post, let postName = post.pfObject.object(forKey: "postName") as? String,
            let username = post.pfObject.object(forKey: "username") as? String,
            let content = post.pfObject.object(forKey: "content") as? String,
            let timeStamp = post.pfObject.object(forKey: "timeStamp") as? String
            
            else {
                
                postNameLabel?.text = "Post Title"
                usernameLabel?.text = "koushan"
                postContentLabel?.text = "Nunc sem eros, pellentesque eu libero in, lobortis fermentum velit."
                timestampLabel?.text = "28 Feb"
                return
        }
        
        postNameLabel?.text = postName
        usernameLabel?.text = username
        postContentLabel?.text = content
        timestampLabel?.text = timeStamp
    }
    
}
