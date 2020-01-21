//
//  TabFriendViewController.swift
//  deal
//
//  Created by DEV on 12/20/19.
//  Copyright © 2019 DEV. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class TabFriendViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var ref: DatabaseReference!
    
    @IBOutlet weak var tableView: UITableView!
    var datatitle:[String] = []
    var datapic:[UIImage] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datatitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let mycell = tableView.dequeueReusableCell(withIdentifier: "cell") as! FriendTableViewCell
        mycell.imageFriend.image = datapic[indexPath.row]
        mycell.nameFriend.text = datatitle[indexPath.row]
        
//        mycell.textLabel?.text = datatitle[indexPath.row]
        
        return mycell
        
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        if constan.friendlist.count > 0{
            datatitle = constan.friendlistName
            datapic = constan.friendimagelist
            print("frienlistzdataTitle",datatitle)
        }else{
            loadData()
            print("frienlistelse",datatitle)
        }
        
        print("frienlist",constan.friendlist.count)
    }
    
    func loadData(){
        let userID = Auth.auth().currentUser!.uid
        // Do any additional setup after loading the view.
        ref = Database.database().reference().child("Friend_Relations").child(userID)
        ref.observe(.value) { snapshot in
            for child in snapshot.children{
                if let childSnapshot = child as? DataSnapshot,
                    let dict = childSnapshot.value as? [String:Any],
                    let firstName = dict["firstName"] as? String,
                    let imageProUrl = dict["imgProfileUrl"] as? String{
                    
                    
                    if let url = URL(string: imageProUrl){
                        
                        do {
                            let data = try Data(contentsOf: url)
                            self.datapic.append(UIImage(data: data)!)
                        constan.friendimagelist.append(UIImage(data: data)!)
                        }catch let err {
                            print(" Error : \(err.localizedDescription)")
                        }
                        
                        
                    }
                    print("frienlistloa",firstName)
//                    print("hgfdsddf",imageProUrl)
                    if !constan.friendlist.contains(childSnapshot.key){
                        constan.friendlist.append(childSnapshot.key)
                        constan.friendlistName.append(firstName)
                        self.datatitle.append(firstName)
                    }
                    print("frienlistloa",self.datatitle)
                }
                self.tableView.reloadData()
            }
            
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
