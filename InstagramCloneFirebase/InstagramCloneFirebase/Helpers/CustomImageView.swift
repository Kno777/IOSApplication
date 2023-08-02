//
//  CustomImageView.swift
//  InstagramCloneFirebase
//
//  Created by Kno Harutyunyan on 31.07.23.
//

import UIKit

var imageCache: [String: UIImage] = [:]

class CustomImageView: UIImageView {
        
    func loadImage(urlString: String) {
        print("Loading image...")
        
        // fixed photo repeting issue
        let lastURLUsedToLoadImage = urlString
        
        self.image = nil
        
        if let cachedImage = imageCache[urlString] {
            self.image = cachedImage
            return
        }

        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, resp, err in
            if let err = err {
                print("Failed to get post. ", err)
                return
            }
            
            if url.absoluteString != lastURLUsedToLoadImage {
                return
            }
            
            guard let imageData = data else { return }
            
            let photoImage = UIImage(data: imageData)
            
            imageCache[url.absoluteString] = photoImage
            
            DispatchQueue.main.async {
                self.image = photoImage
            }
            
        }.resume()
    }
}
