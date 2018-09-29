//
//  FlickrService.swift
//  ShudderDemo
//
//  Created by John Crossley on 27/09/2018.
//  Copyright © 2018 John Crossley. All rights reserved.
//

import Foundation

class FlickrRequestService: ImageRequestService {

    private var task: URLSessionDataTask?

    private func formatImageUrl(from photo: Flickr.Photo) -> Photo? {
        let urlString = "https://farm\(photo.farm).staticflickr.com/\(photo.server)/\(photo.id)_\(photo.secret)_m.jpg"
        guard let url = URL(string: urlString) else { return nil }
        return Photo(url: url)
    }

    func request(for section: Section, completion: @escaping (Result<[Photo], ImageRequestServiceError>) -> Void) {
        task?.cancel()

        guard let encodedQuery = section.query.addingPercentEncoding(withAllowedCharacters: .alphanumerics) else {
            print("Failed encoding query: \(section.query)")
            completion(.failure(.failedEncodingQuery))
            return
        }

        let baseUrl = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(Constants.Flickr.apiKey)&text=\(encodedQuery)&per_page=\(section.limit)&format=json&nojsoncallback=1"

        guard let url = URL(string: baseUrl) else {
            print("Invalid URL \(baseUrl)")
            completion(.failure(.invalidUrlGenerated))
            return
        }

        let request = URLRequest(url: url)

        task = URLSession.shared.dataTask(with: request) { (data, response, error) in
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
        }

        task?.resume()
    }
}
