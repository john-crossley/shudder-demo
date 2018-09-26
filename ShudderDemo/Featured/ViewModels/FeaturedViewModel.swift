//
//  FeaturedViewModel.swift
//  ShudderDemo
//
//  Created by John Crossley on 26/09/2018.
//  Copyright © 2018 John Crossley. All rights reserved.
//

import Foundation

class FeaturedViewModel {
    private let service: MovieService

    init(service: MovieService) {
        self.service = service

        service.featured { result in
            switch result {
            case .success(let result):
                print(">>> \(result)")
            case .failure(let error):
                print(">>> \(error)")
            }
        }
    }
}
