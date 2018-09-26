//
//  ThreadHelper.swift
//  ShudderDemo
//
//  Created by John Crossley on 26/09/2018.
//  Copyright © 2018 John Crossley. All rights reserved.
//

import Foundation

func background(label: String = "background", block: @escaping () -> Void) {
    DispatchQueue(label: label, qos: .userInitiated).async { block() }
}

func main(block: @escaping () -> Void) {
    DispatchQueue.main.async { block() }
}
