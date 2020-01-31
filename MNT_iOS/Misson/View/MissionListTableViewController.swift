//
//  MissionTableViewController.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/01/31.
//  Copyright © 2020 최민섭. All rights reserved.
//

import UIKit
import RxCocoa
import RxGesture


class MissionTableViewController: UITableViewController {
    var viewModel: MissionViewModel? {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.registerNib(MissionCell.self)
        tableView.delegate = self
        tableView.dataSource = self
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModel?.missions.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(MissionCell.self)
        guard let item = viewModel?.missions[indexPath.row] else { return UITableViewCell(frame: .zero)}
        cell.bindViewModel(viewModel: item.asMissionCellViewModel)
        cell.rx.tapGesture()
            .when(.recognized)
            .materialize()
            .filter { $0.error == nil }
            .dematerialize()
            .subscribe(onNext: { [unowned self] _ in
                self.viewModel?.missionDetailAction(index: indexPath.row).execute()
            })
            .disposed(by: self.rx.disposeBag)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = viewModel?.missions[indexPath.row] else { return }
        
    }
}
