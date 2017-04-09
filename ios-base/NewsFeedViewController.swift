//
//  NewsFeedViewController.swift
//  ios-base
//

import UIKit

class NewsFeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet var tableView: UITableView?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.setHidesBackButton(true, animated:true);
        self.title = "News Feed"
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
            // create a sample news feed post
            let post = Post(postName: "Hello!", username: "kasra", content: "Sup fam! This is my post yo", timeStamp: "4 April 2017")
            cell.post = post
            cell.updateInfo()
            return cell
        }
        return NewsFeedTableViewCell(style: .default, reuseIdentifier: "newsFeedCell")
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func addNewPost() {
        let newPostVC = NewPostViewController()
        self.navigationController?.pushViewController(newPostVC, animated: true)
    }
    
    func signout() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
}
