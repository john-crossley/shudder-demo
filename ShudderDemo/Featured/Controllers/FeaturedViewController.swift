//
//  ViewController.swift
//  ShudderDemo
//
//  Created by John Crossley on 25/09/2018.
//  Copyright © 2018 John Crossley. All rights reserved.
//

import UIKit
import SnapKit

fileprivate extension String {
    static let collectionCellId = "collectionCellId"
    static let heroCellId = "heroCellId"
    static let sectionHeaderCellId = "sectionHeaderCellId"
}

class FeaturedViewController: UIViewController {

    private let viewModel: FeaturedViewModel

    private var sections: [SectionViewModel] = [] {
        didSet { tableView.reloadData() }
    }

    init(with viewModel: FeaturedViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        view.separatorStyle = .none
        view.dataSource = self
        view.delegate = self
        view.register(CollectionCell.self, forCellReuseIdentifier: .collectionCellId)
        view.register(HeroCell.self, forCellReuseIdentifier: .heroCellId)
        view.register(UINib(nibName: "SectionHeaderView", bundle: .main), forHeaderFooterViewReuseIdentifier: .sectionHeaderCellId)
        view.backgroundColor = UIColor.Theme.backgroundColor
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Theme.backgroundColor
        view.addSubview(tableView)

        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }

        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "settings"), style: .plain, target: nil, action: nil)

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "search"), style: .plain, target: nil, action: nil)

        viewModel.delegate = self
        viewModel.fetch()

        title = "Featured"
    }
}

extension FeaturedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = sections[indexPath.section]

        switch viewModel.type {
        case .hero:
            let cell = tableView.dequeueReusableCell(withIdentifier: .heroCellId, for: indexPath) as! HeroCell
            cell.bind(using: viewModel)
            return cell
        case .collection:
            let cell = tableView.dequeueReusableCell(withIdentifier: .collectionCellId, for: indexPath) as! CollectionCell
            cell.bind(using: viewModel)
            return cell
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        let viewModel = sections[indexPath.section]

        switch viewModel.type {
        case .hero: return Constants.Hero.height
        case .collection: return Constants.Collection.height
        }
    }
}

extension FeaturedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let section = sections[section]

        switch section.type {
        case .hero: return nil
        case .collection:
            let view = tableView
                .dequeueReusableHeaderFooterView(withIdentifier: .sectionHeaderCellId) as! SectionHeaderView
            view.bind(model: HeaderViewModel(with: section.category))
            return view
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let viewModel = sections[section]

        switch viewModel.type {
        case .hero: return 0
        case .collection: return 36
        }
    }
}

extension FeaturedViewController: FeaturedViewModelDelegate {
    func didUpdate(state: FeaturedViewModel.State) {
        switch state {
        case .idle: break
        case .loading: break
        case .loaded(let sections):
            self.sections = sections
        case .error: break
        }
    }
}
