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

    private var sections: [Section] = [] {
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
        let view = UITableView(frame: .zero, style: .plain)
        view.separatorStyle = .none
        view.dataSource = self
        view.delegate = self
        view.register(CollectionCell.self, forCellReuseIdentifier: .collectionCellId)
        view.register(HeroRowCell.self, forCellReuseIdentifier: .heroCellId)
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

        viewModel.delegate = self
        viewModel.fetch()

        title = "Shudder Featured Demo"
    }
}

extension FeaturedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]

        switch section.type {
        case .hero:
            let cell = tableView.dequeueReusableCell(withIdentifier: .heroCellId, for: indexPath) as! HeroRowCell
            cell.bind(section.items)
            return cell
        case .collection:
            let cell = tableView.dequeueReusableCell(withIdentifier: .collectionCellId, for: indexPath) as! CollectionCell
            cell.bind(section.items)
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
        return 150
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
