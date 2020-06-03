//
//  MissionViewController.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/01/31.
//  Copyright © 2020 최민섭. All rights reserved.
//

import UIKit

class MissionParticipantViewController: ViewController {
    
    var viewModel: MissionViewModel?
    let missionTableController = MissionTableViewController(style: .grouped)

    override func setupLayout() {
        view.addSubview(missionTableController.view)
        missionTableController.view.anchor(
            .top(topAnchor),
            .leading(view.leadingAnchor),
            .trailing(view.trailingAnchor),
            .bottom(bottomAnchor)
        )
        
        missionTableController.tableView.rx.itemSelected.subscribe { [weak self] indexPath in
            guard let index = indexPath.element?.row else { return }
            self?.viewModel?.missionDetailAction(index: index)
        }
    }
    
    
    // MARK:- View Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
        BottomBar.shared.showBottomBar()
        
        if let viewModel = viewModel {
            getMissionDoneList(viewModel)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.isHidden = false
    }
}

extension MissionParticipantViewController: ViewModelBindableType {
    func bindViewModel(viewModel: MissionViewModel) {
    }
    
    private func getMissionDoneList(_ viewModel: MissionViewModel) {
        let userId = (UserDefaults.standard.getObject(key: .user) ?? User()).id
        let roomId = (UserDefaults.standard.getObject(key: .room) ?? Room()).id
        APISource.shared.getMyMissionDoneList(roomId: roomId, userId: userId) { [weak self] (missions) in
            viewModel.missions = missions
            self?.missionTableController.missions = viewModel.missions
            }?.disposed(by: rx.disposeBag)
    }
}
