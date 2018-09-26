//
//  SectionHeaderView.swift
//  ShudderDemo
//
//  Created by John Crossley on 26/09/2018.
//  Copyright © 2018 John Crossley. All rights reserved.
//

import UIKit

class SectionHeaderView: UITableViewHeaderFooterView {
    @IBOutlet private var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = UIColor.Theme.backgroundColor
    }

    func bind(model: HeaderViewModel) {
        self.titleLabel.text = model.title
    }
}
