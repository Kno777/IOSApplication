//
//  Service.swift
//  AppStoreJSONApi
//
//  Created by Kno Harutyunyan on 09.08.23.
//

import Foundation

class Service {
    
    static let shared = Service() // singleton
    
    func fetchApps(searchTerm: String, completion: @escaping ([ResultModel], Error?) -> ()) {
        print("Fetching apps from Servic layer")
        
        let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&entity=software"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, resp, err in
            if let err = err {
                print("Failed to fetch apps: ", err)
                completion([], err)
            }
                        
            guard let data = data else { return }
            
            do {
                let searchResult = try JSONDecoder().decode(SearchResultModel.self, from: data)
                completion(searchResult.results, nil)
                
            } catch {
                print("Failed to decode json: ", error)
                completion([], error)
            }
            
        }.resume()
    }
}
