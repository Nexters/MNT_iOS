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
    fileprivate var emptyView = EmptyPageView()
    
    override func setupLayout() {
        view.addSubview(missionTableController.view)
        view.addSubview(emptyView)
        
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
        
        emptyView.setType(type: .missionParticipant)
    }

    // MARK:- View Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
                
        navigationController?.navigationBar.isHidden = true
        BottomBar.shared.showBottomBar()
        
        getMissionDoneList()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.isHidden = false
    }
}

extension MissionParticipantViewController: ViewModelBindableType {
    func bindViewModel(viewModel: MissionViewModel) {
        NotificationCenter.default.addObserver(self, selector: #selector(notifyMissionPosted), name: .init("MissionPosted"), object: nil)
    }
    
    @objc private func notifyMissionPosted() {
        getMissionDoneList()
    }
    
    private func getMissionDoneList() {
        
        guard let viewModel = viewModel else { return }
        
        let userId = (UserDefaults.standard.getObject(key: .user) ?? User()).id
        let roomId = (UserDefaults.standard.getObject(key: .room) ?? Room()).id
        APISource.shared.getMyMissionDoneList(roomId: roomId, userId: userId) { [weak self] (missions) in
            viewModel.missions = missions
            self?.emptyView.isHidden = missions.count > 0
            self?.missionTableController.missions = viewModel.missions
            }?.disposed(by: rx.disposeBag)
    }
}
