//
//  User.swift
//  InstagramCloneFirebase
//
//  Created by Kno Harutyunyan on 28.07.23.
//

import UIKit

struct User {
    let username: String
    let profileImageUrl: String
    
    init(dictionary: [String: Any]) {
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
    }
}
