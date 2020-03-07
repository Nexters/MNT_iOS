//
//  MainUserListViewController.swift
//  MNT_iOS
//
//  Created by Jihye on 2020/02/19.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation

class MainUserListViewController: ViewController {
    var viewModel: MainUserListViewModel?
    
    fileprivate lazy var tableView: UITableView = {
        let tb = UITableView(backgroundColor: .white)
        tb.delegate = self
        tb.dataSource = self
        tb.registerNib(MainUserListCell.self)
        tb.separatorStyle = .none
        tb.showsVerticalScrollIndicator = false
        tb.contentInset = .init(top: 20, left: 0, bottom: 0, right: 0)
        return tb
    }()
    
    override func setupLayout() {
        view.addSubview(tableView)
        tableView.fillSuperview()
    }
}

extension MainUserListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        67
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel?.userlist.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(UserListCell.self)
        // bind
        return cell
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        10
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        UIView(backgroundColor: .clear)
    }
}

extension MainUserListViewController: ViewModelBindableType {
    func bindViewModel(viewModel: MainUserListViewModel) {
        self.viewModel = viewModel

        getUserList()
    }

    private func getUserList() {
        // Call API
    }
}
