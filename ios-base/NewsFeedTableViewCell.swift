//
//  NewsFeedTableViewCell.swift
//  ios-base
//

import UIKit

class NewsFeedTableViewCell: UITableViewCell {

    @IBOutlet var postNameLabel: UILabel?
    @IBOutlet var viewProfileButton: UIButton?
    @IBOutlet var usernameLabel: UILabel?
    @IBOutlet var postContentLabel: UILabel?
    @IBOutlet var timestampLabel: UILabel?
    
    var postName = "Post Title"
    var username = "koushan"
    var postContent = "Nunc sem eros, pellentesque eu libero in, lobortis fermentum velit. Nam urna ante, dapibus vel faucibus a, sagittis laoreet ex. Ut luctus placerat enim, et ornare dui pellentesque non. Integer."
    var timestamp = "28 Feb"
    
    override func awakeFromNib() {
        super.awakeFromNib()

        postNameLabel?.text = postName
        usernameLabel?.text = username
        postContentLabel?.text = postContent
        timestampLabel?.text = timestamp
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func viewProfileButtonPressed(_ sender: UIButton) {
        print("view profile button pressed")
        
    }
    
}
