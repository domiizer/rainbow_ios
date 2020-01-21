//
//  FViewController.swift
//  deal
//
//  Created by DEV on 11/20/19.
//  Copyright © 2019 DEV. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
class FViewController: UIViewController,UINavigationBarDelegate,UICollectionViewDataSource,UICollectionViewDelegate {

    

    @IBOutlet weak var headtopic: UILabel!
    
    @IBOutlet weak var topic: UITextField!
    var sss = ObjSendData()
    var data = Datas()
    var comeFrom:String = ""
    @IBOutlet weak var CollectFriend: UICollectionView!
    
    @IBOutlet weak var addfriendbtn: UIButton!
    
    
    
    @IBAction func OnAccept(_ sender: UIButton) {
        let userID = Auth.auth().currentUser!.uid

                let postRef = Database.database().reference().child("Contracts").child(userID).childByAutoId()
        
                let posObject = [
                    "created_at" : ServerValue.timestamp(),
                    "description" : discrip.text,
                    "due_at" : time.text,
                    "due_date" : date.text,
                    "guest" : data.userid,
                    "host" : userID,
                    "status" : "0",
                    "topic" : topic.text,
                    "type_icon" : "food"
                ] as [String : Any]
        print("snap",data.userid)
        postRef.setValue(posObject)
        
    }
    
    @IBOutlet weak var discrip: UITextField!
    @IBOutlet weak var date: UITextField!
    @IBOutlet weak var time: UITextField!
    private var datePickerView: UIDatePicker?
    private var timePicker: UIDatePicker?
    @IBOutlet weak var badyView: UIView!
//    @IBOutlet weak var headView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        data.userid = []
        data.friendimage = []
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "BG_pattern_big")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        print("I'm From ",comeFrom)
        addfriendbtn.layer.cornerRadius = addfriendbtn.frame.height / 2
        
        badyView.layer.shadowColor = UIColor.black.cgColor
        badyView.layer.shadowOpacity = 1
        badyView.layer.shadowOffset = .zero
        badyView.layer.shadowRadius = 1
        badyView.layer.cornerRadius = 10
        switch comeFrom {
        case "food":
            headtopic.text = "Food"
            self.view.backgroundColor = #colorLiteral(red: 0.4431372549, green: 0.831372549, blue: 0.8901960784, alpha: 1)
        case "gift":
            headtopic.text = "Gift"
            self.view.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        case "money":
            headtopic.text = "Money"
            self.view.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        case "other":
            headtopic.text = "Other"
            self.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        case "party":
            headtopic.text = "Party"
            self.view.backgroundColor = #colorLiteral(red: 0.990018189, green: 0.8334332108, blue: 0, alpha: 1)
        default:
            break
        }
//        headtopic.text = comeFrom
//        headView.layer.shadowColor = UIColor.black.cgColor
//        headView.layer.shadowOpacity = 1
//        headView.layer.shadowOffset = .zero
//        headView.layer.shadowRadius = 1
//        headView.layer.cornerRadius = 10
        
        datePickerView = UIDatePicker()
        timePicker = UIDatePicker()
        datePickerView?.datePickerMode = .date
        timePicker?.datePickerMode = .time
        datePickerView?.addTarget(self,action: #selector(FViewController.dateChanged(datePickerView: )),for: .valueChanged)
        
        timePicker?.addTarget(self,action: #selector(FViewController.timeChanged(timePicker: )),for: .valueChanged)
        
        let tabGesture = UITapGestureRecognizer(target: self, action: #selector(FViewController.viewTapped(TapGestureRecognizer:)))
        
        view.addGestureRecognizer(tabGesture)
        
        date.inputView = datePickerView
        time.inputView = timePicker
        print(sss.topic)
        topic.text = sss.topic
      discrip.text = sss.descriptions
        time.text = sss.due_at
        date.text = sss.due_date
        
    }
    @objc func viewTapped(TapGestureRecognizer: UITapGestureRecognizer){
        view.endEditing(true)
    }
    @objc func dateChanged(datePickerView: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/mm/yyyy"
        date.text = dateFormatter.string(from: datePickerView.date)
        view.endEditing(true)
    }
    @objc func timeChanged(timePicker: UIDatePicker){
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        time.text = timeFormatter.string(from: timePicker.date)
        view.endEditing(true)
        
    }

    @IBAction func addfriendbtnA(_ sender: Any) {
         performSegue(withIdentifier: "exerciseSegue", sender: self)
    }
    @IBAction func NextToMakeSureA(_ sender: Any) {
        performSegue(withIdentifier: "toMakeSure", sender: self)

    }
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if (segue.identifier == "data") {
//            let vc = segue.destination as! FriendListViewController
//            vc.sss.descriptions = discrip.text!
//            vc.sss.topic = topic.text!
//            vc.sss.due_at = time.text!
//            vc.sss.due_date = date.text!
//
//
//        }
//
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "exerciseSegue" {
            let destination = segue.destination as! FriendListViewController
            destination.data = data
        }else if (segue.identifier == "toMakeSure"){
            let destination = segue.destination as! MakeSureViewController
            
            destination.sDate = date.text!
            destination.sTime = time.text!
            destination.sDetail = discrip.text!
            destination.sTopic = topic.text!
            destination.data = data
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("simslam",data.userid.count)
        return data.userid.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let mycell = collectionView.dequeueReusableCell(withReuseIdentifier: "collcell", for: indexPath) as! CollectionFriend
        mycell.FriendImage.image = data.friendimage[indexPath.row]
        return mycell
    }
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        print("reloaded")
//    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("helloww")
        CollectFriend.reloadData()
        if data.userid.count > 0{
            addfriendbtn.isHidden = true
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
