//
//  SearchResultModel.swift
//  AppStoreJSONApi
//
//  Created by Kno Harutyunyan on 09.08.23.
//

import Foundation

struct SearchResultModel: Decodable {
    let resultCount: Int
    let results: [ResultModel]
}

struct ResultModel: Decodable {
    let trackName: String
    let primaryGenreName: String
    let averageUserRating: Float
}
