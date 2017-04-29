//
//  NewsFeedViewController.swift
//  ios-base
//

import UIKit
import Parse

class NewsFeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView?
    var posts = [PFObject]()
    private let drawingOptions: NSStringDrawingOptions = [.truncatesLastVisibleLine, .usesLineFragmentOrigin, .usesFontLeading]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.setHidesBackButton(true, animated:true);
        self.title = "News Feed"
        
        let query = PFQuery(className:"Post")
        // want the posts in reverse order
        query.order(byDescending: "createdAt")
        query.findObjectsInBackground {
            (objects, error) -> Void in
            if error == nil {
                // The find succeeded.
                // sets the objects to a global variable
                self.posts = objects!
                // refreshes the posts in the tableview
                self.tableView?.reloadData()
            } else {
                // Log details of the failure
                print(error!.localizedDescription)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.register(UINib(nibName: "NewsFeedTableViewCell", bundle: nil), forCellReuseIdentifier: "newsFeedCell")
        
        let rightButtonItem = UIBarButtonItem.init(
            title: "New Post",
            style: .done,
            target: self,
            action: #selector(NewsFeedViewController.addNewPost)
        )
        self.navigationItem.rightBarButtonItem = rightButtonItem
        
        let leftButtonItem = UIBarButtonItem.init(
            title: "View Profile",
            style: .done,
            target: self,
            action: #selector(NewsFeedViewController.viewOwnProfile)
        )
        self.navigationItem.leftBarButtonItem = leftButtonItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let pfObject = self.posts[indexPath.row]
        let attString = NSMutableAttributedString(string: pfObject["content"] as! String, attributes: [:])
        return 80 + attString.boundingRect(with: CGSize(width: self.view.frame.size.width, height: 120), options: drawingOptions, context: nil).size.height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let pfObject = self.posts[indexPath.row]
        let post = Post(postName: pfObject["postName"] as! String,
                        username: pfObject["username"] as! String,
                        content: pfObject["content"] as! String,
                        timeStamp: pfObject["timeStamp"] as! String)
        
        if let cell = self.tableView?.dequeueReusableCell(withIdentifier: "newsFeedCell") as? NewsFeedTableViewCell {
            cell.loadData(post: post, parent: self)
            return cell
        }
        let cell =  NewsFeedTableViewCell(style: .default, reuseIdentifier: "newsFeedCell")
        cell.loadData(post: post, parent: self)
        return cell
    }
    
    func viewOwnProfile() {
        let profileViewController = ProfileViewController(inputUser: nil)
        self.navigationController?.pushViewController(profileViewController, animated: true)
    }
    
    func viewProfile(user: PFUser) {
        let profileViewController = ProfileViewController(inputUser: user)
        self.navigationController?.pushViewController(profileViewController, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    func addNewPost() {
        let newPostVC = NewPostViewController()
        self.navigationController?.pushViewController(newPostVC, animated: true)
    }
    
}
