//
//  User.swift
//  InstagramCloneFirebase
//
//  Created by Kno Harutyunyan on 28.07.23.
//

import UIKit

struct UserModel {
    let uid: String
    let username: String
    let profileImageUrl: String
    
    
    init(uid: String, dictionary: [String: Any]) {
        self.uid = uid
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
    }
}
