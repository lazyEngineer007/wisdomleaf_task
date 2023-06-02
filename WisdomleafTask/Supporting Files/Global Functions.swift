//
//  Global Functions.swift
//  WisdomleafTask
//
//  Created by Ajeeth Kumar on 01/06/23.
//

import Foundation
import UIKit

// Create an NSCache instance to store the downloaded images
private let imageCache = NSCache<NSString, UIImage>()

func downloadImage(from urlString: String, placeholderImage: UIImage? = nil, completion: @escaping (UIImage?) -> Void) {
    // Check if the image is already cached
    if let cachedImage = imageCache.object(forKey: urlString as NSString) {
        completion(cachedImage)
    } else {
        // Image not cached, download it
        guard let imageUrl = URL(string: urlString) else {
            completion(nil)
            return
        }

        // Set placeholder image while loading
        DispatchQueue.main.async {
            completion(placeholderImage)
        }

        let task = URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
            if let error = error {
                print("Error downloading image: \(error)")
                completion(nil)
                return
            }

            if let imageData = data, let image = UIImage(data: imageData) {
                // Store the downloaded image in the cache
                imageCache.setObject(image, forKey: urlString as NSString)

                // Set the downloaded image
                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
}

