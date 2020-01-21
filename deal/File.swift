//
//  File.swift
//  deal
//
//  Created by DEV on 12/19/19.
//  Copyright © 2019 DEV. All rights reserved.
//

import Foundation
import UIKit

class ObjSendData: NSObject{
    var created_at: String = "rddd"
    var descriptions: String = ""
    var due_at: String = ""
    var due_date:String = ""
    var guest: [String] = [""]
    var host: String = ""
    var percent_status: String = ""
    var status: String = ""
    var topic: String = ""
    
}

extension String {
    func makeFirebaseString()->String{
        let arrCharacterToReplace = [".","#","$","[","]"]
        var finalString = self
        
        for character in arrCharacterToReplace{
            finalString = finalString.replacingOccurrences(of: character, with: " ")
        }
        
        return finalString
    }
    
}
class ObjProfile: NSObject{
    var profileName: String = ""
    var profileLastname: String = ""
    var profileImageUrl: String = ""
    var profileToken: String = ""
}
class objFriend: NSObject {
    var guest:[String] = []
}

public class Datas {
    
    var userid: [String] = []
    var friendimage: [UIImage] = []
}

struct constan{
    
    
    static var profileName: String = ""
    static var profileLastname: String = ""
    static var profileImageUrl: String = ""
    static var profileImage: UIImage = UIImage(named: "logo_hand.png")!
    static var profileToken: String = ""
    static var rating: String = "0.0"
    static var guest_count: String = "0"
    static var host_count: String = "0"
    
    static var friendlist: [String] = []
    static var friendlistName: [String] = []
    static var friendimagelist: [UIImage] = []
    

    
}

