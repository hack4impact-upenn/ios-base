//
//  Post.swift
//  ios-base
//

import Foundation
import Parse

class Post {
    
    var pfObject: PFObject
    
    init(postName: String, user: PFUser, content: String, timeStamp: String) {
        self.pfObject = PFObject.init(className: "Post")
        self.pfObject.setObject(postName, forKey: "postName")
        self.pfObject.setObject(user, forKey: "user")
        self.pfObject.setObject(content, forKey: "content")
        self.pfObject.setObject(timeStamp, forKey: "timeStamp")
    }
}
