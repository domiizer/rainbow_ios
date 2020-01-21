//
//  ShowAddFriendListViewController.swift
//  deal
//
//  Created by DEV on 12/23/19.
//  Copyright © 2019 DEV. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
class ShowAddFriendListViewController: UIViewController {

    var ref: DatabaseReference!
//    var ResultSearch: String?
    @IBOutlet weak var SearchFriendText: UITextField!
    
    @IBOutlet weak var ImProfile: UIImageView!
    
    @IBOutlet weak var ViewFriend: UIView!
    
    @IBOutlet weak var AddfriendBum: UIButton!
    
    @IBOutlet weak var SearchFriendBu: UIButton!
    
    @IBOutlet weak var SearchText: UITextField!
    
    @IBOutlet weak var NameLabel: UILabel!
    
    var uidfriend:String = ""
    
    var firstName:String = ""
    var imageUrl:String = ""
    var lastName:String = ""
    var imageui:UIImage = UIImage(named: "logo_hand.png")!
    @IBOutlet weak var alreadyFriend: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        AddfriendBum.layer.cornerRadius = AddfriendBum.frame.height / 2
        ImProfile.layer.cornerRadius = ImProfile.frame.height / 2
        ImProfile.layer.masksToBounds = true
        ViewFriend.isHidden = true
        SearchText.text = "WSCN8QJGKt"
        
    }
    
    @IBAction func AddfriendBua(_ sender: Any) {
        let userID = Auth.auth().currentUser!.uid
        print("testaddf",uidfriend)
        ref = Database.database().reference().child("Friend_Relations").child(userID).child(uidfriend)
//
        ref.child("firstName").setValue(firstName)
        ref.child("imgProfileUrl").setValue(imageUrl)
        ref.child("lastName").setValue(lastName)
        ref.child("UserID").setValue(uidfriend)
        constan.friendlist.append(uidfriend)
        constan.friendlistName.append(firstName)
        constan.friendimagelist.append(imageui)
        AddfriendBum.isHidden = true
        ref = Database.database().reference().child("Friend_Relations").child(uidfriend).child(userID)
        ref.child("firstName").setValue(constan.profileName)
        ref.child("imgProfileUrl").setValue(constan.profileImageUrl)
        ref.child("lastName").setValue(constan.profileLastname)
        
    }
    @IBAction func SearchFrienBua(_ sender: Any) {
        
        ref = Database.database().reference()
        ref.child("Add_Friend_Code").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            
            print("testSearch1",self.SearchText.text ?? "")
//            let firebaseSearchString = self.SearchText.text!.makeFirebaseString()
            let ResultSearch = value?[self.SearchText.text!] as? String ?? ""
            print("testSearch1",ResultSearch)
            self.uidfriend = ResultSearch
            print("testSearch11",self.uidfriend)
//            let user = User(username: username)
            self.findFriend(aaa: ResultSearch)
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
        
        
    }
    func findFriend(aaa: String){
        print("testSearch2",aaa)

        ref = Database.database().reference()
        ref.child("User").child(aaa).observeSingleEvent(of: .value, with: { (snapshot) in
                    // Get user value
                    let value = snapshot.value as? NSDictionary
                    let username = value?["first_name"] as? String ?? ""
                    let pic = value?["img_profile"] as? String ?? ""
                    let lastName = value?["last_name"] as? String ?? ""
                    print("testSearch2",username)
                    print("testSearch2",pic)
                    print("testSearch2",lastName)
                    self.firstName = username
                    self.imageUrl = pic
                    self.lastName = lastName
//                    let url = URL(string: pic)
//                    let data = try Data(contentsOf: url!)
//                    self.ImProfile.image = UIImage(data: data)
            if let url = URL(string: pic){
                
                do {
                    let data = try Data(contentsOf: url)
                    self.ImProfile.image = UIImage(data: data)
                    self.imageui = UIImage(data: data)!
                }catch let err {
                    print(" Error : \(err.localizedDescription)")
                }
                
                
            }
                    self.NameLabel.text = username
                    
                }) { (error) in
                    print(error.localizedDescription)
                }
        ViewFriend.isHidden = false
        
        if constan.friendlist.contains(aaa){
            AddfriendBum.isHidden = true
            alreadyFriend.isHidden = false
        }else{
            alreadyFriend.isHidden = true
        }
    }
    
}
