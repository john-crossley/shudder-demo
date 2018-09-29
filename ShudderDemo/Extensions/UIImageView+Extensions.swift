//
//  UIImage+Extensions.swift
//  ShudderDemo
//
//  Created by John Crossley on 28/09/2018.
//  Copyright © 2018 John Crossley. All rights reserved.
//

import UIKit
import AlamofireImage

extension UIImageView {
    func setImage(_ url: URL) {
        af_setImage(withURL: url)
    }
}
