//
//  FriendListViewController.swift
//  deal
//
//  Created by DEV on 12/3/19.
//  Copyright © 2019 DEV. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
class FriendListViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate {
    
    var ref: DatabaseReference!
    var data = Datas()
    @IBOutlet weak var tableview: UITableView!
    
    //ข้อมูลที่ต้องการแสดงบน Cell
    var datatitle:[String] = []
    var datapic:[UIImage] = []
    var dataUserID:[String] = []
    var dataSelected:[String] = []
    var imageSelected:[UIImage] = []
    var asdfasdf:[String] = ["asdfsdf","bbxcz"]
    
    
    var sss = ObjSendData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.delegate = self
        // Do any additional setup after loading the view.
        if constan.friendlist.count > 0{
            datatitle = constan.friendlistName
            datapic = constan.friendimagelist
            dataUserID = constan.friendlist
        }else{
            loadData()
        }
    }

    //จำนวนของ Cell ที่ต้องการให้ปรากฏ
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datatitle.count
    }
    //cell ที่จะแสดงบนหน้าแอป
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let mycell = tableView.dequeueReusableCell(withIdentifier: "cell") as! SelectFriendViewCell
        mycell.imageFriend.image = datapic[indexPath.row]
        mycell.nameFriend.text = datatitle[indexPath.row]
        mycell.UserID = dataUserID[indexPath.row]
        
        return mycell
    }
    //OnTouch
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // your code
        let indexPath = tableView.indexPathForSelectedRow
        let currentCell = tableView.cellForRow(at: indexPath!)! as! SelectFriendViewCell
        let currentItem = currentCell.UserID
        let currentImage = currentCell.imageFriend.image
        print(dataSelected.contains(currentItem))
        if(!dataSelected.contains(currentItem)){
        dataSelected.append(currentItem)
        imageSelected.append(currentImage!)
            currentCell.imCheck.image = UIImage(named: "add_friendx.png")
        }else{
            dataSelected = dataSelected.filter(){$0 != currentItem}
            imageSelected = imageSelected.filter(){$0 != (currentImage)}
            currentCell.imCheck.image = UIImage(named: "add_friendplus.png")
        }
        print("wheein",imageSelected)
        data.userid = dataSelected
        data.friendimage = imageSelected

        
    }
    
    
    func loadData(){
        let userID = Auth.auth().currentUser!.uid
        // Do any additional setup after loading the view.
        ref = Database.database().reference().child("Friend_Relations").child(userID)
        print("hgfdsddf",userID)
        ref.observe(.value) { snapshot in
            for child in snapshot.children{
                if let childSnapshot = child as? DataSnapshot,
                    let dict = childSnapshot.value as? [String:Any],
                    let firstName = dict["firstName"] as? String,
                    let imageProUrl = dict["imgProfileUrl"] as? String,
                    let friendID = dict["UserID"] as? String{
                    self.datatitle.append(firstName)
                    self.dataUserID.append(friendID)
                    if let url = URL(string: imageProUrl){
                        
                        do {
                            let data = try Data(contentsOf: url)
                            self.datapic.append(UIImage(data: data)!)
                            
                        }catch let err {
                            print(" Error : \(err.localizedDescription)")
                        }
                        
                        
                    }
                    print("hgfdsddf",firstName)
                    print("hgfdsddf",friendID)
                    
                    
                }
            }
            self.tableview.reloadData()
        }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "data" {
//            let destination = segue.destination as! FViewController
//            destination.data.array = data.array
//        }
//    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if (segue.identifier == "data") {
//            let vc = segue.destination as! FViewController
//            vc.verificationId = ["Your Data","nil","Your Data2"]
//            vc.sss.descriptions = sss.descriptions
//            vc.sss.topic = sss.topic
//            vc.sss.due_at = sss.due_at
//            vc.sss.due_date = sss.due_date
            

//        }
//    }

}

extension Array where Element: UIImage {
    func unique() -> [UIImage] {
        var unique = [UIImage]()
        for image in self {
            if !unique.contains(image) {
                unique.append(image)
            }
        }
        return unique
    }
}
