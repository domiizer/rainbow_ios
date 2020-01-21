//
//  TabHomeViewController.swift
//  deal
//
//  Created by DEV on 11/22/19.
//  Copyright © 2019 DEV. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth
class TabHomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var tableView:UITableView!
    var posts = [Post]()
    var ref: DatabaseReference!
    var refHandle: DatabaseHandle!
    var postData = [String]()
    var testpostdata = ["eji","aeu","iu","eji","aeu","iu","eji","aeu","iu","eji","aeu","iu","eji","aeu","iu","eji","aeu","iu","eji","aeu","iu"]
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView = UITableView(frame: view.bounds, style: .plain)
        
        let cellNip = UINib(nibName: "PostTableViewCell", bundle: nil)
        tableView.register(cellNip, forCellReuseIdentifier: "postCell")
        view.addSubview(tableView)

//        print(userID)
        var layoutGuide:UILayoutGuide!
        
        if #available(iOS 11.0, *){
            layoutGuide = view.safeAreaLayoutGuide
        }else{
            layoutGuide = view.layoutMarginsGuide
        }
        tableView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: layoutGuide.topAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor).isActive = true
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.reloadData()
        
//        ref = Database.database().reference()
//        refHandle = ref?.child("test").observe(.value, with: { (snapshot) in
////            let post = snapshot.value as? String
//
//            for child in snapshot.children{
////                print("naaaaa",child)
////                if let childSnapshot = child as? DataSnapshot,
////                let dict = childSnapshot.value as? [String:Any]
////                    let topic = dict["topic"] as? String,
////                    let date =
//
//
//            }
//
//
//        })

observePosts()
        
    }
    func observePosts(){
            let userID = Auth.auth().currentUser!.uid
//        let userID = "0oD0bgx7FDhANrrGexibGwvxrmS2"
        let postsRef = Database.database().reference().child("Contracts").child(userID)
        
        postsRef.observe(.value, with: {snapshot in
            var tempPosts = [Post]()
            
            for child in snapshot.children{
                if let childSnapshot = child as? DataSnapshot,
                    let dict = childSnapshot.value as? [String:Any],
                    let topic = dict["topic"] as? String,
                    let date = dict["due_date"] as? String,
                    let time = dict["due_at"] as? String,
                    let host = dict["host"] as? String{
                    
                    let post = Post(due_at: time, due_date: date, host: host, topic: topic)
                    tempPosts.append(post)
                }
            }
            self.posts = tempPosts
            self.tableView.reloadData()
            
        })
        
        ref = Database.database().reference()
        let query = userID
        ref.child("Add_Friend_Code").queryOrderedByValue().queryEqual(toValue: query).observeSingleEvent(of: .value) { (querySnapshot) in
            for result in querySnapshot.children {
                let resultSnapshot = result as! DataSnapshot
                    print ("theEve",resultSnapshot.key)
            }
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostTableViewCell
        cell.set(post: posts[indexPath.row]
)
        return cell
    }

}
