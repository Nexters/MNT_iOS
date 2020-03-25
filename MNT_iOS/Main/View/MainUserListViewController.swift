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
        tb.separatorStyle = .none
        tb.allowsSelection = false
        tb.registerNib(MainUserListCell.self)
        tb.showsVerticalScrollIndicator = false
        tb.contentInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        return tb
    }()
    
    override func setupLayout() {
        view.addSubview(tableView)
        tableView.fillSuperview()
    }
    
    override func setupNavigationController() {
        navigationItem.titleView = UILabel(text: "참여자 리스트", font: .boldSystemFont(ofSize: 20), textColor: .defaultText)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
}

extension MainUserListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.userList.count ?? 0
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        67
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(MainUserListCell.self)
        cell.nameLabel.text = viewModel?.userList[indexPath.row]
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
    
    func getUserList() {
        APISource.shared.getRoomUserList(roomId: 12768) { participants in
            for i in 0..<participants.count {
                print(participants[i].user.name)
                self.viewModel?.userList.append(participants[i].user.name)
                self.tableView.reloadData()
            }
        }?.disposed(by: self.rx.disposeBag)
    }
}
