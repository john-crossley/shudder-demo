//
//  Section.swift
//  ShudderDemo
//
//  Created by John Crossley on 26/09/2018.
//  Copyright © 2018 John Crossley. All rights reserved.
//

import Foundation

struct Section: Codable {
    let type: String
    let category: String
    let items: [Item]
}
