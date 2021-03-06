//
//  ImageRequestService.swift
//  ShudderDemo
//
//  Created by John Crossley on 27/09/2018.
//  Copyright © 2018 John Crossley. All rights reserved.
//

import Foundation

enum ImageRequestServiceError: Error {
    case failedEncodingQuery
    case invalidUrlGenerated
    case invalidRequest
    case invalidResponse
    case unexpectedDataInResponse
}

protocol ImageRequestService: class {
    func request(for section: Section, completion: @escaping (Result<[Photo], ImageRequestServiceError>) -> Void)
}
