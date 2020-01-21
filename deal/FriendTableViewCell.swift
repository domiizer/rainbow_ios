//
//  FriendTableViewCell.swift
//  deal
//
//  Created by DEV on 1/3/20.
//  Copyright © 2020 DEV. All rights reserved.
//

import UIKit

class FriendTableViewCell: UITableViewCell {
    @IBOutlet weak var imageFriend: UIImageView! {
        didSet {
            imageFriend.layer.cornerRadius = imageFriend.frame.width / 2
            imageFriend.layer.masksToBounds = true
        }
    }
    
    @IBOutlet weak var nameFriend: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
