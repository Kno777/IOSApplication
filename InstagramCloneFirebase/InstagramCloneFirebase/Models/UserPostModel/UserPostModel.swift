//
//  UserPostModel.swift
//  InstagramCloneFirebase
//
//  Created by Kno Harutyunyan on 31.07.23.
//

import UIKit

struct UserPostModel {
    let imageUrl: String
    let user: User
    let caption: String
    
    init(user: User, dictonary: [String: Any]) {
        self.imageUrl = dictonary["imageUrl"] as? String ?? ""
        self.caption = dictonary["postText"] as? String ?? ""
        self.user = user
    }
}
