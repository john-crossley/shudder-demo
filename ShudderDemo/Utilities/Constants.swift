//
//  Constants.swift
//  ShudderDemo
//
//  Created by John Crossley on 29/09/2018.
//  Copyright © 2018 John Crossley. All rights reserved.
//

import UIKit

struct Constants {
    static let spacing: CGFloat = 8

    struct Collection {
        static let height: CGFloat = 150
        static let visibleCount = 3
    }

    struct Hero {
        static let height: CGFloat = {
            return 200 + Constants.spacing * 2
        }()
    }

    struct Flickr {
        static let apiKey = "af0a9941948b6858b22ba3d7cb85bbad"
    }
}
