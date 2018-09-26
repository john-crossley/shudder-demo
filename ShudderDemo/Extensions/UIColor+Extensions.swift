//
//  UIColor+Extensions.swift
//  ShudderDemo
//
//  Created by John Crossley on 26/09/2018.
//  Copyright © 2018 John Crossley. All rights reserved.
//

import UIKit

extension UIColor {

    struct Theme {
        static let primaryColor: UIColor = UIColor(named: "primaryColor") ?? .black
        static let backgroundColor: UIColor = UIColor(named: "backgroundColor") ?? .black
        static let accentColor: UIColor = UIColor(named: "accentColor") ?? .red
    }

}
