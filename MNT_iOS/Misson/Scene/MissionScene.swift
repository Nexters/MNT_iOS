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
    case missionPost(MissionPostViewModel)
    case missionPreview(MissionDetailViewModel)
    case addNewMission(AddNewMissionViewModel)
    case sendMission
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
            
        case .missionPost(let viewModel):
            var missionPostVC = MissionPostViewController()
            missionPostVC.bind(viewModel: viewModel)
            return missionPostVC
            
        case .missionPreview(let viewModel):
            var missionPreviewVC = MissionPreviewViewController()
            missionPreviewVC.bind(viewModel: viewModel)
            return missionPreviewVC
            
        case .sendMission:
            // Demo..
            return MissionParticipantViewController()
        case .addNewMission(let viewModel):
            var addNewMissionVC = AddNewMissionViewController()
            addNewMissionVC.bind(viewModel: viewModel)
            return addNewMissionVC
        }
    }
}
