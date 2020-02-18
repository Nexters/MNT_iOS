//
//  FeedFilterViewController.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/02/11.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation

class FeedFilterViewController: ViewController {
    var viewModel: FeedFilterViewModel?
    var selectedSection: Int? = nil
    
    fileprivate lazy var tableView: UITableView = {
        let tb = UITableView()
        tb.delegate = self
        tb.dataSource = self
        tb.separatorStyle = .none
        tb.registerNib(FeedFilterCell.self)
        tb.showsVerticalScrollIndicator = false
        tb.contentInset = .init(top: 20, left: 0, bottom: 0, right: 0)
        return tb
    }()
    
    override func setupLayout() {
        let closebar = CloseButtonBar(title: "필터") { [weak self] in self?.dismiss(animated: true, completion: nil) }
        view.addSubview(closebar)
        view.addSubview(tableView)
        
        closebar.anchor(top: topAnchor,
                        leading: view.leadingAnchor,
                        bottom: nil,
                        trailing: view.trailingAnchor)
        
        tableView.anchor(top: closebar.bottomAnchor,
                         leading: view.leadingAnchor,
                         bottom: view.bottomAnchor,
                         trailing: view.trailingAnchor)
    }
}

extension FeedFilterViewController: ViewModelBindableType {
    func bindViewModel(viewModel: FeedFilterViewModel) {
        viewModel.items = [
            FeedFilterCellViewModel(filtername: "나에게 온 미션보기", subMenus: []),
            FeedFilterCellViewModel(filtername: "내가 보낸 미션보기", subMenus: []),
            FeedFilterCellViewModel(filtername: "미션별로 보기", subMenus: [
                FeedFilterSubMenu(image: #imageLiteral(resourceName: "imgProfilePineapple"), text: "칭찬하기"),
                FeedFilterSubMenu(image: #imageLiteral(resourceName: "imgProfilePineapple"), text: "칭찬하기"),
                FeedFilterSubMenu(image: #imageLiteral(resourceName: "imgProfilePineapple"), text: "칭찬하기")
            ]),
            FeedFilterCellViewModel(filtername: "참가자별로 보기", subMenus: [
                FeedFilterSubMenu(image: #imageLiteral(resourceName: "imgProfilePineapple"), text: "칭찬하기"),
                FeedFilterSubMenu(image: #imageLiteral(resourceName: "imgProfilePineapple"), text: "칭찬하기"),
                FeedFilterSubMenu(image: #imageLiteral(resourceName: "imgProfilePineapple"), text: "칭찬하기")
            ])
        ]
        
        tableView.reloadData()
    }
}

extension FeedFilterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        67
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(FeedFilterCell.self)
        guard let item = viewModel?.items[indexPath.section] else { return UITableViewCell(frame: .zero)}
        cell.bind(viewModel: item)
        if selectedSection == indexPath.section { cell.expand() }
        else { cell.collapse() }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if selectedSection != section { return 10 }
        guard let item = viewModel?.items[section] else { return 10 }
        return CGFloat(item.subMenus.count * 50) + 55
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if selectedSection != section { return UIView(backgroundColor: .clear) }
        guard let item = viewModel?.items[section] else { return UIView(backgroundColor: .clear) }
        return FeedFilterCellFooterView(subMenus: item.subMenus)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedSection == indexPath.section { selectedSection = nil }
        else { selectedSection = indexPath.section }
        
        UIView.transition(with: tableView, duration: 0.3, options: .transitionCrossDissolve, animations: { [weak self] in
            self?.tableView.reloadData()
        }, completion: nil)
        
    }
}
