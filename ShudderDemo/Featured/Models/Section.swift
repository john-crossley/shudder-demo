//
//  Section.swift
//  ShudderDemo
//
//  Created by John Crossley on 26/09/2018.
//  Copyright © 2018 John Crossley. All rights reserved.
//

import Foundation

enum SectionType: String, Codable {
    case hero
    case collection
}

struct Section: Codable {
    let type: SectionType
    let category: String
    let query: String
    let limit: Int
}
