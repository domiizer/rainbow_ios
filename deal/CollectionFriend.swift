//
//  CollectionFriend.swift
//  deal
//
//  Created by DEV on 1/7/20.
//  Copyright © 2020 DEV. All rights reserved.
//

import UIKit

class CollectionFriend: UICollectionViewCell {
    
    @IBOutlet weak var FriendImage: UIImageView!{
        didSet{
            FriendImage.layer.cornerRadius = FriendImage.frame.width / 2
            FriendImage.layer.masksToBounds = true
        }
    }
}
