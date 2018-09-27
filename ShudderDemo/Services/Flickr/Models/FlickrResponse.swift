//
//  FlickrResponse.swift
//  ShudderDemo
//
//  Created by John Crossley on 27/09/2018.
//  Copyright © 2018 John Crossley. All rights reserved.
//

import Foundation

struct FlickrResponse: Codable {
    let photos: Photos
}

struct Photos: Codable {
    let photos: [Photo]

    private enum CodingKeys: String, CodingKey {
        case photos = "photo"
    }
}

struct Photo: Codable {
    let id: String
    let farm: Int
    let secret: String
}
