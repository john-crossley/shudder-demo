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
    static let categoryCellId = "categoryCellId"
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
        view.register(CategoryRowCell.self, forCellReuseIdentifier: .categoryCellId)
        view.register(UINib(nibName: "SectionHeaderView", bundle: .main), forHeaderFooterViewReuseIdentifier: .sectionHeaderCellId)
        view.backgroundColor = UIColor.Theme.backgroundColor
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Theme.backgroundColor
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(self.view)
        }

        viewModel.delegate = self
        viewModel.fetch()

        title = "Shudder Featured Demo"
    }
}

extension FeaturedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: .categoryCellId, for: indexPath) as! CategoryRowCell
        cell.bind(items: sections[indexPath.section].items)
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}

extension FeaturedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section != 0 else { return nil }

        let category = sections[section].category

        let view = tableView
            .dequeueReusableHeaderFooterView(withIdentifier: .sectionHeaderCellId) as! SectionHeaderView
        view.bind(model: HeaderViewModel(with: category))
        return view
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
