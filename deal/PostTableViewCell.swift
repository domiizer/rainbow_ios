//
//  PostTableViewCell.swift
//  deal
//
//  Created by DEV on 11/28/19.
//  Copyright © 2019 DEV. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

 
    @IBOutlet weak var postView: UIView!
    @IBOutlet weak var topicLabel: UILabel!
    @IBOutlet weak var typeImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var hostLabel: UILabel!
    @IBOutlet weak var typeView: UIView!
    
    @IBOutlet weak var date2Label: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        typeView.layer.cornerRadius = 5
//        typeImage.layer.cornerRadius = typeImage.frame.height / 2
//        typeImage.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func set(post:Post){
        topicLabel.text = post.topic
        dateLabel.text = post.due_date
        date2Label.text = post.due_date
        timeLabel.text = post.due_at
        hostLabel.text = post.host
        
    }
}
