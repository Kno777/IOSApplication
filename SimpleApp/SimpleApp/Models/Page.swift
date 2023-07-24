//
//  Page.swift
//  SimpleApp
//
//  Created by Kno Harutyunyan on 14.07.23.
//

import Foundation

struct Page {
    let imageName: String
    let headerText: String
    let bodyText: String
}

enum PageDummyData {
    static let pages: [Page] = [
        Page(imageName: "bear_first", headerText: "Join us today in out fun and games!", bodyText: "Are you ready for loads and loads of fun? Don't wait any longer! We hope to see you in our stores soon."),
        Page(imageName: "heart_second", headerText: "Subscribe and get coupons on aour daily events", bodyText: "Get notified of the savings immendiately when we announce them on our website. Make sure to also give us any feedback you have!"),
        Page(imageName: "leaf_third", headerText: "VIP mambers special services", bodyText: "What are you waiting for? Join us today!"),
        Page(imageName: "bear_first", headerText: "Join us today in out fun and games!", bodyText: "Are you ready for loads and loads of fun? Don't wait any longer! We hope to see you in our stores soon."),
    ]
}
