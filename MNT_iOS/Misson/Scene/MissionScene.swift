//
//  MissionScene.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/01/31.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation

enum MissionScene {
    case missionParticipant(MissionViewModel)
    case missionAdministrator(MissionViewModel)
    case missionDetail(MissionPostViewModel)
}

extension MissionScene: SceneType {
    func instantiate() -> UIViewController {
        switch self {
        case .missionParticipant(let viewModel):
            var missionVC = MissionParticipantViewController()
            missionVC.bind(viewModel: viewModel)
            return missionVC
        case .missionAdministrator(let viewModel):
            var missionVC = MissionAdministratorViewController()
            missionVC.bind(viewModel: viewModel)
            return missionVC
        case .missionDetail(let viewModel):
            var missionDetailVC = MissionPostViewController()
            missionDetailVC.bind(viewModel: viewModel)
            return missionDetailVC
        }
    }
}
