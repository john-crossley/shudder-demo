//
//  MovieItemCell.swift
//  ShudderDemo
//
//  Created by John Crossley on 26/09/2018.
//  Copyright © 2018 John Crossley. All rights reserved.
//

import UIKit
import SnapKit

class MovieItemCell: UICollectionViewCell {
    private let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(movieImageView)
        movieImageView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }

        backgroundColor = .lightGray
        layer.cornerRadius = 4
        layer.masksToBounds = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func bind(photo: Photo) {
        movieImageView.setImage(photo.url)
    }
}
