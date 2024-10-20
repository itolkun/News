//
//  NetworkManager.swift
//  News
//
//  Created by Айтолкун Анарбекова on 20.10.2024.
//

import Foundation

class NetworkManager {
    
    private let apiKey = "pub_567936a595650a79c8d8ff4b8e0fd8aabe208"
    private let server = "https://newsdata.io/api/1/news?apikey="
    private let country = "&country=us"
    
    private func createURL(nextPage: String? = nil) -> URL? {
                
        let urlString = server + apiKey + country + (nextPage == nil ? "&page=\(nextPage ?? "")" : "")
        return URL(string: urlString)
    }

    
    func fetchNews(nextPage: String? = nil, completion: @escaping (Result<[Article], Error>) -> Void) {
        guard let url = createURL(nextPage: nextPage) else {
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
