//
//  Service.swift
//  AppStoreJSONApi
//
//  Created by Kno Harutyunyan on 09.08.23.
//

import Foundation

class Service {
    
    static let shared = Service() // singleton
    
    func fetchApps(completion: @escaping (AppGroupModel?, Error?) -> ()) {
        print("Fetching games from Servic layer.")
        
        let urlStringApps = "https://rss.applemarketingtools.com/api/v2/us/apps/top-free/50/apps.json"
        let urlStringMusic = "https://rss.applemarketingtools.com/api/v2/us/music/most-played/50/albums.json"
        let urlStringBooks = "https://rss.applemarketingtools.com/api/v2/us/books/top-free/50/books.json"
                
        // MARK: - help us sync out data fetches together
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        fetchAppGroups(urlString: urlStringApps, completion: completion)
        dispatchGroup.leave()
        
        dispatchGroup.enter()
        fetchAppGroups(urlString: urlStringMusic, completion: completion)
        dispatchGroup.leave()
        
        dispatchGroup.enter()
        fetchAppGroups(urlString: urlStringBooks, completion: completion)
        dispatchGroup.leave()
        
        // completion
        dispatchGroup.notify(queue: .main) {
            print("completed you dispatch group task...")
        }
        
    }
    
    // helper
    func fetchAppGroups(urlString: String, completion: @escaping (AppGroupModel?, Error?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, resp, err in
            if let err = err {
                print("Failed to fetch games: ", err)
                completion(nil, err)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let appGroup = try JSONDecoder().decode(AppGroupModel.self, from: data)
                completion(appGroup, nil)
            } catch {
                print("Failed to decode json: ", error)
                completion(nil, error)
            }
            
        }.resume()
    }
    
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
    
    func fetchSocialAppsHeader(completion: @escaping ([SocialAppsHeaderModel]?, Error?) -> Void) {
        
        let urlString = "https://api.letsbuildthatapp.com/appstore/social"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, resp, err in
            if let err = err {
                print("Failed to fetch social: ", err)
                completion(nil, err)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let socialAppsHeaderModel = try JSONDecoder().decode([SocialAppsHeaderModel].self, from: data)
                completion(socialAppsHeaderModel, nil)
            } catch {
                print("Failed to decode json: ", error)
                completion(nil, error)
            }
            
        }.resume()
    }
}
