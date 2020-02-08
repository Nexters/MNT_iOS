//
//  FeedViewController.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/01/31.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation

class FeedViewController: ViewController {
    
    var viewModel: FeedViewModel?
    
    lazy var tableView: UITableView = {
        let tb = UITableView()
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.registerNib(FeedCell.self)
        tb.delegate = self
        tb.dataSource = self
        return tb
    }()
    
    override func setupLayout() {
        view.addSubview(tableView)
        tableView.fillSuperview()
    }
}

fileprivate let dummyImage = "https://image.shutterstock.com/image-vector/user-icon-260nw-523867123.jpg"
fileprivate let dummmyPostImageURL = "https://www.goodmorningcc.com/news/photo/201807/92806_109217_2652.jpg"

extension FeedViewController: ViewModelBindableType {
    func bindViewModel(viewModel: FeedViewModel) {
        // setup Dummys
        print(viewModel)
        (0...100).forEach {
            self.viewModel?.infos.append(FeedInfo(manittoName: "마니또\($0)",
                                                                manittoProfileImageURL: dummyImage,
                                                                targetName: "너에게..",
                                                                targetProfileImageURL: dummyImage,
                                                                postURL: dummmyPostImageURL,
                                                                text: "yolo")) }
        tableView.reloadData()
    }
}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(viewModel?.infos.count)
        return viewModel?.infos.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(FeedCell.self)
        guard let item = viewModel?.infos[indexPath.row] else { return UITableViewCell(frame: .zero)}
        cell.bindViewModel(viewModel: item.asFeedCellViewModel)
        return cell
    }
}
