//
//  MovieModel.swift
//  NetworkingRESTAPI
//
//  Created by Kno Harutyunyan on 24.07.23.
//


struct MovieModel: Decodable {
    let title: String
    let description: String
    let movies: [Movie]
}

struct Movie: Decodable {
    let id: String
    let title: String
    let releaseYear: String
}
