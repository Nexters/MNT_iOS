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
    
    lazy var tableView: UITableView = {
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
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.title = "참여자 리스트"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
}

extension MainUserListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.userList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(MainUserListCell.self)
        cell.nameLabel.text = viewModel?.userList[indexPath.row]
//        cell.deleteButton.tag = indexPath.row
//        cell.deleteButton.addTarget(self,
//                                    action: #selector(buttonTapped(_:)),
//                                    for: .touchUpInside)
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        67
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        10
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        UIView(backgroundColor: .clear)
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        let name : String = (viewModel?.userList[sender.tag])!
        let alert = UIAlertController(title: "",
                                      message: "\(name)님을 내보내시겠습니까?",
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "네",
                                     style: .default) { (action) in
                                        self.deleteUser()
        }
        let cancelAction = UIAlertAction(title: "아니오",
                                         style: .default,
                                         handler: nil)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func deleteUser() {
        APISource.shared.deleteRoomUser(roomId: 23430,
                                        userId: "05103") {
            }?.disposed(by: self.rx.disposeBag)
//
        // delete in userList TableView
//        getUserList()
    }
}

extension MainUserListViewController: ViewModelBindableType {
    func bindViewModel(viewModel: MainUserListViewModel) {
        self.viewModel = viewModel

        getUserList()
    }
    
    func getUserList() {
        
        APISource.shared.getRoomUserList(roomId: 23430) { participants in
            for i in 0..<participants.count { self.viewModel?.userList.append(participants[i].user.name)
                self.tableView.reloadData()
            }
        }?.disposed(by: self.rx.disposeBag)
    }
}
