//
//  HomePostCellDelegate.swift
//  InstagramCloneFirebase
//
//  Created by Kno Harutyunyan on 03.08.23.
//

import UIKit

protocol HomePostCellDelegate: AnyObject {
    func didTapComment(post: UserPostModel)
}
