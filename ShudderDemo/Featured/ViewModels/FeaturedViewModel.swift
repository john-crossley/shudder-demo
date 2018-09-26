//
//  FeaturedViewModel.swift
//  ShudderDemo
//
//  Created by John Crossley on 26/09/2018.
//  Copyright © 2018 John Crossley. All rights reserved.
//

import Foundation

protocol FeaturedViewModelDelegate: class {
    func didUpdate(state: FeaturedViewModel.State)
}

class FeaturedViewModel {
    private let service: MovieService

    weak var delegate: FeaturedViewModelDelegate?

    enum State {
        case idle
        case loading
        case loaded([Section])
        case error
    }

    private(set) var state: State = .idle {
        didSet {
            main {
                self.delegate?.didUpdate(state: self.state)
            }
        }
    }

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

    func fetch() {
        self.state = .loading
        background { self.requestSectionsFromService() }
    }

    ///
    /// Naturally I would introduce some form of repository layer
    /// here for caching purposes, but because this is loading data
    /// directly from the file system it's unnecessary.
    ///
    private func requestSectionsFromService() {
        service.featured { result in
            switch result {
            case .success(let sections):
                self.state = .loaded(sections)
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                self.state = .error
            }
        }
    }
}
