//
//  ViewController.swift
//  deal
//
//  Created by DEV on 11/15/19.
//  Copyright © 2019 DEV. All rights reserved.
//

import UIKit
import Firebase

import GoogleSignIn
import FirebaseAuth
class ViewController: UIViewController,GIDSignInDelegate {
    var text:String = ""
    var ref: DatabaseReference!
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        print("genius sign")
        // ...
        var objprofile = ObjProfile()
        if let error = error {
            // ...
            print("genius error",error)
            
            return
        }
        guard let authentication = user.authentication else { return }
        print("genius auth")
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        Auth.auth().signIn(with: credential) { (authResult, error) in
            
            // User is signed in
            // ...
            let fullName = user.profile.name
            let pic = user.profile.imageURL(withDimension: 200)?.absoluteString
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let vc = ViewController()
            vc.text = fullName!
            let userID = Auth.auth().currentUser!.uid
            //            self.ref = Database.database().reference().child("User").child(userID)
            self.ref = Database.database().reference().child("User").child(userID)
            
            
            let test = self.ref.child("add_friend_code")
            print("genius fullName",fullName)
            //            self.ref.child("add_friend_code").setValue(self.randomString(length: 10))
            self.ref.child("first_name").setValue(givenName)
            self.ref.child("guest_count").setValue("0")
            self.ref.child("guest_rating").setValue("0")
            self.ref.child("host_count").setValue("0")
            self.ref.child("host_rating").setValue("0")
            self.ref.child("img_profile").setValue(pic)
            self.ref.child("last_name").setValue(familyName)
            self.performSegue(withIdentifier: "goHome", sender: self)
            objprofile.profileName = givenName!
            objprofile.profileLastname = familyName!
            objprofile.profileImageUrl = pic!
            print(objprofile.profileName)
        }
    }
    @IBAction func GSignIn(_ sender: UIButton) {
        GIDSignIn.sharedInstance()?.presentingViewController = self
        
        GIDSignIn.sharedInstance().signIn()
        //        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        print("genius Gsign")
        
    }
    
    
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var username: UITextField!
    
    
    
    
    @IBOutlet weak var signin: UIButton!
    
    @IBAction func signinAction(_ sender: Any) {
        let email = username.text!
        let pass = password.text!
        
        Auth.auth().signIn(withEmail: email, password: pass) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            if error != nil{
                print(error)
            }else{
                let userID = Auth.auth().currentUser!.uid
                print("checkaa",Auth.auth().currentUser!.uid)
                self!.ref = Database.database().reference().child("User").child(userID)
                self!.ref.observeSingleEvent(of: .value, with: { (snapshort) in
                    let dict = snapshort.value as? NSDictionary
                    constan.profileName = dict?["first_name"] as? String ?? ""
                    constan.profileLastname = dict?["last_name"] as? String ?? ""
                    constan.profileImageUrl = dict?["img_profile"] as? String ?? ""
                    constan.profileToken = userID
                    constan.rating = dict?["host_rating"] as? String ?? ""
                    constan.guest_count = dict?["guest_count"] as? String ?? ""
                    constan.host_count = dict?["host_count"] as? String ?? ""
                    print("constantView1",constan.profileName)
                    print("constantView1",constan.profileLastname)
                    print("constantView1",constan.profileImageUrl)
                    print("constantView1",constan.rating)
                    DispatchQueue.main.async(){
                        self!.performSegue(withIdentifier: "goHome", sender: self)
                    }
                    
                })

                print("not error")
            }
            
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        GIDSignIn.sharedInstance().presentingViewController = self
        
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
        
        username.layer.cornerRadius = username.frame.height / 2
        username.clipsToBounds = true
        signin.layer.cornerRadius = signin.frame.height / 2
        @available(iOS 9.0, *)
        func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any])
            -> Bool {
                return GIDSignIn.sharedInstance().handle(url)
        }
        if (GIDSignIn.sharedInstance()?.hasPreviousSignIn())! && Auth.auth().currentUser != nil {
            /* Code to show your tab bar controller */
            GIDSignIn.sharedInstance()?.restorePreviousSignIn()
            print("checkaa a googleSign")
        }else if Auth.auth().currentUser != nil {
            // User is signed in.
            let userID = Auth.auth().currentUser!.uid
            print("checkaa",Auth.auth().currentUser!.uid)
            self.ref = Database.database().reference().child("User").child(userID)
            self.ref.observeSingleEvent(of: .value, with: { (snapshort) in
                let dict = snapshort.value as? NSDictionary
                constan.profileName = dict?["first_name"] as? String ?? ""
                constan.profileLastname = dict?["last_name"] as? String ?? ""
                constan.profileImageUrl = dict?["img_profile"] as? String ?? ""
                constan.profileToken = userID
                constan.rating = dict?["host_rating"] as? String ?? ""
                constan.guest_count = dict?["guest_count"] as? String ?? ""
                constan.host_count = dict?["host_count"] as? String ?? ""
                
                if let url = URL(string: constan.profileImageUrl){
                    do {
                        let data = try Data(contentsOf: url)
                        constan.profileImage = UIImage(data: data)!
                    }catch let err {
                        print(" Error : \(err.localizedDescription)")
                    }
                    
                    
                }
                
                print("constantView1",constan.profileName)
                print("constantView1",constan.profileLastname)
                print("constantView1",constan.profileImageUrl)
                print("constantView1",constan.rating)
                DispatchQueue.main.async(){
                    print("mamamammoooo",constan.profileName)
                    self.performSegue(withIdentifier: "goHome", sender: self)
                }
                
            })
            //            self.performSegue(withIdentifier: "goHome", sender: self)
            
            
        } else {
            // No user is signed in.
            print("checkaa not signed in")
        }
    }
    
    
    
    public func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
}
