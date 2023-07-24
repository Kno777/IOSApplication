//
//  MovieManager.swift
//  NetworkingRESTAPI
//
//  Created by Kno Harutyunyan on 24.07.23.
//

import UIKit

struct MovieManager {
    
    func fetchData(completion: @escaping (MovieModel) -> Void) {
        guard let url = URL(string: "https://reactnative.dev/movies.json") else { return }
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("ERROR: ", error.localizedDescription)
            }
            
            guard let jsonData = data else { return }
            
            let decoder = JSONDecoder()
            
            do {
                let decodedData = try decoder.decode(MovieModel.self, from: jsonData)
                completion(decodedData)
            }catch {
                print("Failed to decode data.", error.localizedDescription)
            }
        }
        
        dataTask.resume()
    }
}
