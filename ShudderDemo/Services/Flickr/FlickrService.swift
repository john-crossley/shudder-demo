//
//  FlickrService.swift
//  ShudderDemo
//
//  Created by John Crossley on 27/09/2018.
//  Copyright © 2018 John Crossley. All rights reserved.
//

import Foundation

fileprivate struct Constants {
    static let apiKey = ""
}

class FlickrRequestService: ImageRequestService {

    typealias Model = [Photo]

    private func formatImageUrl(from photo: Flickr.Photo) -> Photo? {
        let urlString = "https://farm\(photo.farm).staticflickr.com/\(photo.server)/\(photo.id)_\(photo.secret)_m.jpg"
        guard let url = URL(string: urlString) else { return nil }
        return Photo(url: url)
    }

    func request(for query: String, completion: @escaping (Result<Model, ImageRequestServiceError>) -> Void) {
        guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .alphanumerics) else {
            print("Failed encoding query: \(query)")
            completion(.failure(.failedEncodingQuery))
            return
        }

        let baseUrl = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(Constants.apiKey)&text=\(encodedQuery)&per_page=50&format=json&nojsoncallback=1"

        guard let url = URL(string: baseUrl) else {
            print("Invalid URL \(baseUrl)")
            completion(.failure(.invalidUrlGenerated))
            return
        }

        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Invalid request: \(error.localizedDescription)")
                completion(.failure(.invalidRequest))
                return
            }

            guard let _ = response as? HTTPURLResponse, let data = data else {
                completion(.failure(.invalidResponse))
                return
            }

            let decoder = JSONDecoder()
            do {

                let results = try decoder.decode(Flickr.Response.self, from: data)
                    .photos.photos.compactMap { self.formatImageUrl(from: $0) }

                completion(.success(results))
            } catch let decodingError {
                print("Error decoding data: \(decodingError.localizedDescription)")
                completion(.failure(.unexpectedDataInResponse))
            }
        }.resume()
    }
}