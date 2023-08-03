//
//  CommentModel.swift
//  InstagramCloneFirebase
//
//  Created by Kno Harutyunyan on 03.08.23.
//

import UIKit

struct CommentModel {
    let text: String
    let uid: String
    
    init(dictionary: [String: Any]) {
        self.text = dictionary["text"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
    }
}
