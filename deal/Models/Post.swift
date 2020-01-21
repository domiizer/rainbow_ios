//
//  Post.swift
//  deal
//
//  Created by DEV on 11/29/19.
//  Copyright © 2019 DEV. All rights reserved.
//

import Foundation

class Post{
//    var create_at:String
//    var description:String
    var due_at:String
    var due_date:String
//    var guest:[String]
    var host:String
//    var status:String
    var topic:String
    init(due_at:String, due_date:String, host:String, topic:String) {
        self.due_at = due_at
        self.due_date = due_date
        self.host = host
        self.topic = topic
        
    }
}
