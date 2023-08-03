//
//  CommentModel.swift
//  InstagramCloneFirebase
//
//  Created by Kno Harutyunyan on 03.08.23.
//

import UIKit

struct CommentModel {
    let user: UserModel
    let text: String
    let uid: String
    
    init(user: UserModel ,dictionary: [String: Any]) {
        self.user = user
        self.text = dictionary["text"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
    }
}
