//
//  Database+Extension.swift
//  InstagramCloneFirebase
//
//  Created by Kno Harutyunyan on 31.07.23.
//

import Firebase
import UIKit

extension Database {
    static func fetchUserWithUID(uid: String, completion: @escaping (User) -> ()) {
        print("Fetching user with uid: ", uid)
        
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value) { snapshot in
            
            guard let userDict = snapshot.value as? [String: Any] else { return }
            
            let user = User(uid: uid, dictionary: userDict)
            
            completion(user)
            
        } withCancel: { err in
            print("Failed to fetch user from DB.", err)
            return
        }
    }
}
