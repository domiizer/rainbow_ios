//
//  MakeSureViewController.swift
//  deal
//
//  Created by DEV on 1/15/20.
//  Copyright © 2020 DEV. All rights reserved.
//

import UIKit

class MakeSureViewController: UIViewController,UINavigationControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.userid.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let mycell = collectionView.dequeueReusableCell(withReuseIdentifier: "collcell", for: indexPath) as! CollectionFriend
        mycell.FriendImage.image = data.friendimage[indexPath.row]
        return mycell
    }
    

    
    @IBOutlet weak var dealtopic: UILabel!
    
    @IBOutlet weak var hostProfileImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var lastname: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var detail: UITextView!
    @IBOutlet weak var collectFriend: UICollectionView!
    @IBOutlet weak var dealbutton: UIButton!
    
    var sTopic: String = ""
    var sDate: String = ""
    var sTime: String = ""
    var sDetail: String = ""
    var data = Datas()
    override func viewDidLoad() {
        super.viewDidLoad()
        hostProfileImage.image = constan.profileImage
        hostProfileImage.layer.cornerRadius = hostProfileImage.frame.width / 2
        name.text = constan.profileName
        lastname.text = constan.profileLastname
        dealtopic.text = sTopic
        print("saasdfax",sTopic)
        date.text = sDate
        time.text = sTime
        detail.text = sDetail
        
        collectFriend.reloadData()
        print(data.userid.count)
        dealbutton.layer.cornerRadius = dealbutton.frame.height / 2
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("asdklfjl")
        collectFriend.reloadData()
        
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
