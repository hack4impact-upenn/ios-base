//
//  NewsFeedViewController.swift
//  ios-base
//

import UIKit
import Parse

class NewsFeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView?
    var posts = [PFObject]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.setHidesBackButton(true, animated:true);
        self.title = "News Feed"
        
        let query = PFQuery(className:"Post")
        
        query.findObjectsInBackground {
            (objects, error) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) Posts.")
                self.posts = objects!
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
            title: "Sign Out",
            style: .done,
            target: self,
            action: #selector(NewsFeedViewController.signout)
        )
        
        self.navigationItem.leftBarButtonItem = leftButtonItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "newsFeedCell") as? NewsFeedTableViewCell {
            let pfObject = self.posts[indexPath.row]
            
            cell.postNameLabel!.text = pfObject["postName"] as? String
            cell.postContentLabel!.text = pfObject["content"] as? String
            cell.usernameLabel!.text = pfObject["username"] as? String
            cell.timestampLabel!.text = pfObject["timeStamp"] as? String
            
            cell.parent = self
            return cell
        }
        return NewsFeedTableViewCell(style: .default, reuseIdentifier: "newsFeedCell")
    }
    
    func viewProfilePressed(profileUsername: String) {
        let profileViewController = ProfileViewController()
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
    
    func signout() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
}
