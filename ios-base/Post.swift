//
//  Post.swift
//  ios-base
//
//  Created by Kasra Koushan on 2017-04-04.
//  Copyright © 2017 Kyle Rosenbluth. All rights reserved.
//

import Foundation
import Parse

class Post {
    
    var pfObject: PFObject
    
    init(postName: String, username: String, content: String, timeStamp: String) {
        self.pfObject = PFObject.init(className: "Post")
        self.pfObject.setObject(postName, forKey: "postName")
        self.pfObject.setObject(username, forKey: "username")
        self.pfObject.setObject(content, forKey: "content")
        self.pfObject.setObject(timeStamp, forKey: "timeStamp")
    }
}
