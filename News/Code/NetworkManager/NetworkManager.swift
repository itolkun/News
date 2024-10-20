//
//  NetworkManager.swift
//  News
//
//  Created by Айтолкун Анарбекова on 20.10.2024.
//

import Foundation

class NetworkManager {
    
    let basicURL = "https://newsdata.io/api/1/news?apikey=pub_567936a595650a79c8d8ff4b8e0fd8aabe208&country=us"
    
    func fetchNews(completion: @escaping (Result<[Article], Error>) -> Void) {
        guard let url = URL(string: basicURL) else {
            print("Invalid URL")
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                print("No data received")
                return
            }
            do {
                let decodedResponse = try JSONDecoder().decode(NewsApiResponse.self, from: data)
                completion(.success(decodedResponse.results))
            } catch let jsonError {
                completion(.failure(jsonError))
            }
        }
        
        task.resume()
    }
}
