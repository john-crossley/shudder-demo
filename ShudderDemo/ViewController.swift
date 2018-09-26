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
}

class ViewController: UIViewController {

    private var categories: [String] = []

    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.separatorStyle = .none
        view.dataSource = self
        view.register(UITableViewCell.self, forCellReuseIdentifier: .categoryCellId)
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

        title = "Shudder Featured Demo"
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: .categoryCellId, for: indexPath)
        cell.textLabel?.text = "Hello, Shudder"
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
}

