//
//  UserListViewController.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/02/11.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation

class UserListViewController: ViewController {
    var viewModel: UserListViewModel?
    fileprivate lazy var tableView: UITableView = {
        let tb = UITableView(backgroundColor: .white)
        tb.delegate = self
        tb.dataSource = self
        tb.separatorStyle = .none
        tb.allowsSelection = false
        tb.registerNib(UserListCell.self)
        tb.showsVerticalScrollIndicator = false
        tb.contentInset = .init(top: 20, left: 0, bottom: 0, right: 0)
        return tb
    }()
    
    override func setupLayout() {
        view.addSubview(tableView)
        tableView.fillSuperview(padding: .init(top: 0, left: 26, bottom: 0, right: 26))
    }
    
    override func setupNavigationController() {
        navigationItem.titleView = UILabel(text: "참여자 리스트", font: .boldSystemFont(ofSize: 20), textColor: .defaultText)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
}

extension UserListViewController: ViewModelBindableType {
    func bindViewModel(viewModel: UserListViewModel) {
        self.viewModel = viewModel
        
        getUserList()
    }
    
    private func getUserList() {
        APISource.shared.getUserList(roomId: 86386) { (userlist) in
            self.viewModel?.userlist = userlist
            self.tableView.reloadData()
        }
    }
}

extension UserListViewController: UITableViewDelegate, UITableViewDataSource {
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
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        10
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        UIView(backgroundColor: .clear)
    }
}
