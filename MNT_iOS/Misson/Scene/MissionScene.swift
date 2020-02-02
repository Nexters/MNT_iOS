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
            // 메모리 적재 타이밍을 위하여 인스턴스 내부 생성
            // UINavigationConroller -> Mission... Controller 순으로
            let navigationVC = UINavigationController(rootViewController: MissionParticipantViewController())
            if var mainVC = navigationVC.viewControllers.first as? MissionParticipantViewController {
                mainVC.bind(viewModel: viewModel)
            }
            return navigationVC
        case .missionAdministrator(let viewModel):
            let navigationVC = UINavigationController(rootViewController: MissionAdministratorViewController())
            if var mainVC = navigationVC.viewControllers.first as? MissionAdministratorViewController {
                mainVC.bind(viewModel: viewModel)
            }
            return navigationVC
        case .missionDetail(let viewModel):
            var missionDetailVC = MissionPostViewController()
            missionDetailVC.bind(viewModel: viewModel)
            return missionDetailVC
        }
    }
}
