//
//  User.swift
//  MovieSelector_iOS
//
//  Created by Sudeep Agarwal on 3/8/16.
//  Copyright © 2016 Sudeep Agarwal. All rights reserved.
//

import Foundation

class User: NSObject {
    
    var email: String!
    var password: String!
    var desc: String?
    var major: String?
    var uid: String?
    
    init(email: String, password: String, desc: String, major: String, uid: String) {
        self.email = email
        self.password = password
        self.desc = desc
        self.major = major
        self.uid = uid
    }
    
    override var description: String {
        return "User: \(uid), \(email), \(password), \(desc), \(major)"
    }
    
}