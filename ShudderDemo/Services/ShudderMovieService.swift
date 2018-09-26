//
//  FeaturedMovieService.swift
//  ShudderDemo
//
//  Created by John Crossley on 26/09/2018.
//  Copyright © 2018 John Crossley. All rights reserved.
//

import Foundation

class ShudderMovieService: MovieService {

    func featured(callback: @escaping (Result<[Section]>) -> Void) {
        guard let path = Bundle.main.path(forResource: "data", ofType: "json") else {
            callback(.failure(.dataNotFound))
            return
        }

        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            callback(.failure(.dataInvalid))
            return
        }

        let decoder = JSONDecoder()

        do {
            let result = try decoder.decode([Section].self, from: data)
            callback(.success(result))
        } catch let error {
            print("Unable to parse data: \(error.localizedDescription)")
            callback(.failure(.dataInvalid))
        }
    }
}
