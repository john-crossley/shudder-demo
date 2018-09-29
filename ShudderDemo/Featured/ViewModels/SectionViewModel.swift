//
//  SectionViewModel.swift
//  ShudderDemo
//
//  Created by John Crossley on 28/09/2018.
//  Copyright © 2018 John Crossley. All rights reserved.
//

import Foundation

protocol SectionViewModelDelegate: class {
    func didUpdate(state: SectionViewModel.State)
}

class SectionViewModel {

    enum State {
        case idle
        case loading
        case loaded([Photo])
        case error
    }

    weak var delegate: SectionViewModelDelegate?

    var state: State = .idle {
        didSet {
            main {
                self.delegate?.didUpdate(state: self.state)
            }
        }
    }

    private let section: Section
    private let service: ImageRequestService

    var type: SectionType {
        return section.type
    }

    var category: String {
        return section.category
    }

    init(with section: Section, service: ImageRequestService) {
        self.section = section
        self.service = service
    }

    func fetch() {
        self.state = .loading
        background { self.loadPhotosForSection() }
    }

    private func loadPhotosForSection() {
        service.request(for: section) { result in
            switch result {
            case .success(let photos):
                self.state = .loaded(photos)
            case .failure(let error):
                print("Something went wrong: \(error.localizedDescription)")
                self.state = .error
            }
        }
    }
}
