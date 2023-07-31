//
//  UserPostModel.swift
//  InstagramCloneFirebase
//
//  Created by Kno Harutyunyan on 31.07.23.
//

import UIKit

struct UserPostModel {
    let imageUrl: String
    
    init(dictonary: [String: Any]) {
        self.imageUrl = dictonary["imageUrl"] as? String ?? ""
    }
}
