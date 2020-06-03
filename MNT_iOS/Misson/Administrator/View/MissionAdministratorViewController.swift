//
//  MissionAdministratorViewController.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/01/31.
//  Copyright © 2020 최민섭. All rights reserved.
//

import UIKit

class MissionAdministratorViewController: ViewController {
    var viewModel: MissionViewModel?
    let missionTableController: MissionTableViewController = {
        let mt = MissionTableViewController(style: .grouped)
        mt.flag = 1
        return mt
    }()
    
    override func setupLayout() {
        view.addSubview(missionTableController.view)
        missionTableController.view.fillSuperview()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
        BottomBar.shared.showBottomBar()
        
        if let viewModel = viewModel {
            getMissionList(viewModel)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.isHidden = false
    }
}

extension MissionAdministratorViewController: ViewModelBindableType {
    func bindViewModel(viewModel: MissionViewModel) {
        // setupDummys
        
        missionTableController.tableView.rx.itemSelected.subscribe { [weak self] indexPath in
            if indexPath.element?.section == 0 {
                viewModel.addNewMissionAction()
            }
        }
    }
    
    private func getMissionList(_ viewModel: MissionViewModel) {
        let roomId = (UserDefaults.standard.getObject(key: .room) ?? Room()).id
        APISource.shared.getMissionDoneList(roomId: roomId) { [weak self] missions in
            viewModel.orderMissions = missions
            self?.missionTableController.ordermissions = missions
            }?.disposed(by: rx.disposeBag)
    }
}

