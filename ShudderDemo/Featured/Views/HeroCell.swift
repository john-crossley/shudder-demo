//
//  HeroRowCell.swift
//  ShudderDemo
//
//  Created by John Crossley on 27/09/2018.
//  Copyright © 2018 John Crossley. All rights reserved.
//

import UIKit
import SnapKit

class HeroCell: UITableViewCell {

    private var photos: [Photo] = [] {
        didSet { collectionView.reloadData() }
    }

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 8
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)

        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(MovieItemCell.self, forCellWithReuseIdentifier: "movieItemCellId")
        view.dataSource = self
        view.delegate = self
        view.backgroundColor = .clear
        view.showsHorizontalScrollIndicator = false
        view.isPagingEnabled = true
        return view
    }()

    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .white)
        view.hidesWhenStopped = true
        view.color = UIColor.Theme.accentColor
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = .clear
        contentView.backgroundColor = .clear

        contentView.addSubview(activityIndicatorView)
        activityIndicatorView.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(contentView)
        }

        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func bind(using viewModel: SectionViewModel) {
        viewModel.delegate = self
        viewModel.fetch()
    }
}

extension HeroCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let viewModel = photos[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieItemCellId", for: indexPath) as! MovieItemCell
        cell.bind(photo: viewModel)
        return cell
    }
}

extension HeroCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        return CGSize(width: width - 16 , height: 200)
    }
}

extension HeroCell: SectionViewModelDelegate {
    func didUpdate(state: SectionViewModel.State) {
        switch state {
        case .idle: break
        case .loading:
            activityIndicatorView.startAnimating()
        case .loaded(let photos):
            activityIndicatorView.stopAnimating()
            self.photos = photos
        case .error: break
        }
    }
}
