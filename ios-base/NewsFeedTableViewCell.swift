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
    @IBOutlet var profPicButton: UIButton?
    
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
        
        let userImage = self.user!["profPic"] as! PFObject
        
        do {
            try userImage.fetchIfNeeded()
        } catch let error as NSError {
            print("Fetch failed: \(error.localizedDescription)")
        }
        
        let userImageFile = userImage["imageFile"] as! PFFile
        userImageFile.getDataInBackground {
            (imageData, error) -> Void in
            if error == nil {
                if let imageData = imageData {
                    let image = UIImage(data:imageData)
                    self.profPicButton!.setImage(image, for: UIControlState.normal)
                }
            }
        }
    }
    
    @IBAction func viewProfileButtonPressed(_ sender: UIButton) {
        self.parent?.viewProfile(user: self.user!)
    }
    
    @IBAction func profPicButtonPressed(_ sender: UIButton) {
        self.parent?.viewProfile(user: self.user!)
    }
    
}
