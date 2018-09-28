//
//  FlickrResponse.swift
//  ShudderDemo
//
//  Created by John Crossley on 27/09/2018.
//  Copyright © 2018 John Crossley. All rights reserved.
//

import Foundation

struct Flickr: Codable {

    struct Photo: Codable {
        let id: String
        let farm: Int
        let secret: String
        let server: String
    }

    struct Photos: Codable {
        let photos: [Flickr.Photo]

        private enum CodingKeys: String, CodingKey {
            case photos = "photo"
        }
    }

    struct Response: Codable {
        let photos: Flickr.Photos
    }
}
