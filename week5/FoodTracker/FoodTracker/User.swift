//
//  User.swift
//  FoodTracker
//
//  Created by atfelix on 2017-06-06.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

import Foundation

class User {
    var username: String?
    var password: String?
    var token: String?

    init(username: String?, password: String?, token: String?) {
        self.username = username
        self.password = password
        self.token = token
    }
}
