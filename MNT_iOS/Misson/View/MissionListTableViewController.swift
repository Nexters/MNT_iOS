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

protocol MissionTableViewControllerHeaderDataSource {
    func tableViewHeader() -> UIView?
}

class MissionTableViewController: UITableViewController {
    var viewModel: MissionViewModel? {
        didSet {
            tableView.reloadSection(section: 0)
        }
    }
    
    var delegate: MissionTableViewControllerHeaderDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerNib(MissionCell.self)
        
        tableView.rx.itemSelected.subscribe { (_) in
            print("tapped")
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.missions.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(MissionCell.self)
        guard let item = viewModel?.missions[indexPath.row] else { return UITableViewCell(frame: .zero)}
        cell.bindViewModel(viewModel: item.asMissionCellViewModel)
//        cell.rx.tapGesture()
//            .when(.recognized)
//            .materialize()
//            .filter { $0.error == nil }
//            .dematerialize()
//            .subscribe(onNext: { [unowned self] _ in
//                self.viewModel?.missionDetailAction(index: indexPath.row).execute()
//            })
//            .disposed(by: self.rx.disposeBag)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return delegate?.tableViewHeader()
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return delegate == nil ? 0 : 120
    }
}
