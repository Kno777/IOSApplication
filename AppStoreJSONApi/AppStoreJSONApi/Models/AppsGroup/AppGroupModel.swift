//
//  AppGroupModel.swift
//  AppStoreJSONApi
//
//  Created by Kno Harutyunyan on 10.08.23.
//

import Foundation


struct AppGroupModel: Decodable {
    let feed: FeedModel
}

struct FeedModel: Decodable {
    let title: String
    let results: [FeedResultModel]
}

struct FeedResultModel: Decodable {
    let artworkUrl100: String
    let name: String
    let artistName: String
}
