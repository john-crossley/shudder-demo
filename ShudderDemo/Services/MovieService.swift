//
//  MovieService.swift
//  ShudderDemo
//
//  Created by John Crossley on 26/09/2018.
//  Copyright © 2018 John Crossley. All rights reserved.
//

import Foundation

enum MovieServiceError: Error {
    case dataNotFound
    case dataInvalid
}

enum Result<T, E: Error> {
    case success(T)
    case failure(E)
}

protocol MovieService {
    func featured(callback: @escaping (Result<[Section], MovieServiceError>) -> Void)
}
