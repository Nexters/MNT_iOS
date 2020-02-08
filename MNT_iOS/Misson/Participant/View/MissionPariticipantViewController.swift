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
    let missionTableController = MissionTableViewController()

    override func setupLayout() {
        view.addSubview(missionTableController.view)
        missionTableController.view.fillSuperview()
    }
}

extension MissionParticipantViewController: ViewModelBindableType {
    func bindViewModel(viewModel: MissionViewModel) {
        
        // setupDummys
        (0...6).forEach { viewModel.missions.append(Mission(id: $0,
                                                            title: "메시지 보내기",
                                                            subTitle: "부제목이지롱",
                                                            isDone: $0 % 2 == 0)) }
        missionTableController.viewModel = self.viewModel
    }
}
