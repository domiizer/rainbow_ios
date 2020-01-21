//
//  HomeViewController.swift
//  deal
//
//  Created by DEV on 11/15/19.
//  Copyright © 2019 DEV. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import GoogleSignIn

class HomeViewController: UIViewController,GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            // ...
            return
        }
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        Auth.auth().signIn(with: credential) { (authResult, error) in
            print("lastworddddd")
        }
        
    }
    
    
    @IBOutlet weak var btnMenu: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var vwViewCenterX: NSLayoutConstraint!
    @IBOutlet weak var vwViewCenterY: NSLayoutConstraint!
    @IBOutlet weak var btnFab: UIButton!
    @IBOutlet weak var imageProfile: UIImageView!
    
    @IBOutlet weak var lastnameT: UILabel!
    @IBOutlet weak var firstnameT: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var hostCount: UILabel!
    @IBOutlet weak var guestCount: UILabel!
    
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!
    @IBOutlet weak var starAvgText: UILabel!
    
    var goTo:String = ""
    //    var ref: DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()
        //        let userID = Auth.auth().currentUser!.uid
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        print("constantView2",constan.profileName)
        print("constantView2",constan.profileLastname)
        print("constantView2",constan.profileImageUrl)
        print("constantView2",constan.rating)
        let yellow = hexStringToUIColor(hex: "#f0d60a")
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "BG_pattern_big")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.backgroundColor = yellow
        self.view.insertSubview(backgroundImage, at: 0)
        addButton.layer.cornerRadius = addButton.frame.width / 2
        profileView.layer.cornerRadius = profileView.frame.height / 2
        imageProfile.layer.cornerRadius = imageProfile.frame.height / 2
        imageProfile.layer.masksToBounds = true
        
        profileView.layer.shadowColor = yellow.cgColor
        profileView.layer.shadowOpacity = 255
        profileView.layer.shadowOffset = .zero
        profileView.layer.shadowRadius = 3
        profileView.layer.cornerRadius = profileView.frame.height / 2
        profileView.layer.masksToBounds = true
        
        searchView.layer.shadowColor = UIColor.lightGray.cgColor
        searchView.layer.shadowOpacity = 250
        searchView.layer.shadowOffset = .zero
        searchView.layer.cornerRadius = 2
        
        firstnameT.text = constan.profileName
        lastnameT.text = constan.profileLastname
        profileImage.image = constan.profileImage
        guestCount.text = constan.guest_count
        hostCount.text = constan.host_count
        
        let starNum = Float(constan.rating)!
        if (starNum >= 5.0){
            star1.image = UIImage(named: "starFull.png")
            star2.image = UIImage(named: "starFull.png")
            star3.image = UIImage(named: "starFull.png")
            star4.image = UIImage(named: "starFull.png")
            star5.image = UIImage(named: "starFull.png")
            print("starBoy",5)
        }else if(starNum>=4.0){
            star1.image = UIImage(named: "starFull.png")
            star2.image = UIImage(named: "starFull.png")
            star3.image = UIImage(named: "starFull.png")
            star4.image = UIImage(named: "starFull.png")
            if (starNum>=4.5){
                star5.image = UIImage(named: "starHalf.png")
            }
            print("starBoy",4)
        }else if(starNum>=3.0){
            star1.image = UIImage(named: "starFull.png")
            star2.image = UIImage(named: "starFull.png")
            star3.image = UIImage(named: "starFull.png")
            if (starNum>=3.5){
                star4.image = UIImage(named: "starHalf.png")
            }
            print("starBoy",3)
        }else if(starNum>=2.0){
            star1.image = UIImage(named: "starFull.png")
            star2.image = UIImage(named: "starFull.png")
            if (starNum>=2.5){
                star3.image = UIImage(named: "starHalf.png")
            }
            print("starBoy",2)
        }else if(starNum>=1.0){
            print("starBoy",1)
            star1.image = UIImage(named: "starFull.png")
            if (starNum>=1.5){
                star2.image = UIImage(named: "starHalf.png")
            }
            print("starBoy",1)
        }else if(starNum>0.0){
            if (starNum>=0.5){
                star1.image = UIImage(named: "starHalf.png")
            }
            print("starBoy",0)
        }
        
        starAvgText.text = "("+constan.rating+")"
        
        
        hideMenu()
        firebase()
    }
    
    func firebase(){
        let userID = constan.profileToken
        var ref = Database.database().reference().child("Contracts").child(userID)
        ref.observe(.childAdded) { snapshot in
            for child in snapshot.children{
                if let childSnapshot = child as? DataSnapshot,
                    let dict = childSnapshot.value as? [String:Any],
                    let host = dict["host"] as? String{
                    if host == userID{
                        let newValue = Int(constan.host_count)!+1
                        constan.host_count = String(newValue)
                        print("aaaa",newValue)
                    }else{
                        let newValue = Int(constan.guest_count)!+1
                        constan.guest_count = String(newValue)
                        print("aaaa",newValue)
                    }
                }
            }
        }
        
    }
    
    
    func hideMenu() -> Void
    {
        btnMenu.alpha = 0
        vwViewCenterX.constant = -800
        addButton.setImage(UIImage(named: "create_icon.png"), for: UIControl.State.normal)
    }
    func showMenu() -> Void
    {
        btnMenu.alpha = 0.8
        vwViewCenterX.constant = 0
        addButton.setImage(UIImage(named: "exit_button.png"), for: UIControl.State.normal)
    }
    //InView
    @IBAction func btnInView(_ sender: Any) {
        //        hideMenu()
        goTo = "gift"
        performSegue(withIdentifier: "goToMakeDeal", sender: self)
    }
    
    @IBAction func btnFood(_ sender: Any) {
        goTo = "food"
        performSegue(withIdentifier: "goToMakeDeal", sender: self)
    }
    
    @IBAction func InViewBackgroundPress(_ sender: Any) {
        hideMenu()
    }
    
    @IBAction func btnMoney(_ sender: Any) {
        goTo = "money"
    }
    
    //BigButton
    @IBAction func floating(_ sender: Any) {
        hideMenu()
        print("tapped0")
    }
    //ShowBigButtonTest
    
    //PencilButton
    @IBAction func btnFabPress(_ sender: Any) {
        if vwViewCenterX.constant == 0{
            hideMenu()
            
            
        }else{
            showMenu()
            

        }
        
    }
    
    @IBAction func testertestest(_ sender: Any) {
        goTo = "party"
        performSegue(withIdentifier: "goToMakeDeal", sender: self)
//        let firebaseAuth = Auth.auth()
//        do {
//            try firebaseAuth.signOut()
//        } catch let signOutError as NSError {
//            print ("Error signing out: %@", signOutError)
//        }
    }
    
    
    @IBAction func btnFabPOther(_ sender: AnyObject) {
        goTo = "other"
        performSegue(withIdentifier: "goToMakeDeal", sender: self)
    }
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToMakeDeal" {
            let nav = segue.destination as! UINavigationController
            let destination = nav.topViewController as! FViewController
            destination.comeFrom = goTo
            print("from",goTo)
        }
    }
    
}
