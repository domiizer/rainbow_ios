//
//  RegisterViewController.swift
//  deal
//
//  Created by DEV on 12/11/19.
//  Copyright © 2019 DEV. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
class RegisterViewController: UIViewController {

    
    var ref: DatabaseReference!
    @IBOutlet weak var FirstName: UITextField!
    @IBOutlet weak var LastName: UITextField!
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var PassWord: UITextField!
    @IBOutlet weak var RePassWord: UITextField!
    
    @IBOutlet weak var subMitMask: UIButton!
    
    @IBAction func subMit(_ sender: Any) {
        print("taped")
        signInUser(email: Email.text!, password: PassWord.text!)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subMitMask.layer.cornerRadius = subMitMask.layer.frame.height / 2
        // Do any additional setup after loading the view.
    }
//            submit.layer.cornerRadius = submit.layer.frame.height / 2

    
    func createUser(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) {(authResult, error) in
            if let user = authResult?.user {
                print("Created")
                self.signInUser(email: email, password: password)
            } else {
                print("Error")
            }
        }
    }
    func signInUser(email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password){
            (user,error) in
            if error == nil{
                let userID = Auth.auth().currentUser!.uid
                self.ref = Database.database().reference().child("User").child(userID)
                let randomed = self.randomString(length: 10)
                self.ref.child("add_friend_code").setValue(randomed)
                self.ref.child("first_name").setValue(self.FirstName.text)
                self.ref.child("guest_count").setValue("0")
                self.ref.child("guest_rating").setValue("0")
                self.ref.child("host_count").setValue("0")
                self.ref.child("host_rating").setValue("0")
                self.ref.child("img_profile").setValue("https://firebasestorage.googleapis.com/v0/b/ltr-iou.appspot.com/o/User_Pic%2F1574848493180.jpg?alt=media&token=2b158ba0-bd02-48e2-95da-44fe933718fc")
                self.ref.child("last_name").setValue(self.LastName.text)
                print("userSignIn",userID)
                self.ref = Database.database().reference().child("Add_Friend_Code")
                self.ref.child(randomed).setValue(userID)
            self.performSegue(withIdentifier: "goHome", sender: self)
            }else if(error?._code == AuthErrorCode.userNotFound.rawValue){
                self.createUser(email: email, password: password)
            }else {
                print("Else")
            }
            
        }
    }

    public func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }

}
