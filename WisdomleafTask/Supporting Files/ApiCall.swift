//
//  ApiCall.swift
//  WisdomleafTask
//
//  Created by Ajeeth Kumar on 01/06/23.
//

import Foundation

class ApiCall {
    static let shared = ApiCall()
     func get(from url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        let session = URLSession.shared
         print("URL>>>",url)
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                // Handle unexpected response type
                return
            }

            if httpResponse.statusCode == 200 {
                if let data = data {
                    print("Res>>>", data)
                    completion(.success(data))
                    return
                }
            } else {
                let error = NSError(domain: "API Error", code: httpResponse.statusCode, userInfo: nil)
                completion(.failure(error))
                return
            }
        }

        task.resume()
    }
}
