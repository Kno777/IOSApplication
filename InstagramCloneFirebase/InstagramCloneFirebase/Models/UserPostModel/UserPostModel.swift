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
    let creationDate: Date
    
    init(user: User, dictonary: [String: Any]) {
        self.imageUrl = dictonary["imageUrl"] as? String ?? ""
        self.caption = dictonary["postText"] as? String ?? ""
        self.user = user
        
        let secondsFrom1970 = dictonary["creationDate"] as? Double ?? 0
        self.creationDate = Date(timeIntervalSince1970: secondsFrom1970)
    }
}
