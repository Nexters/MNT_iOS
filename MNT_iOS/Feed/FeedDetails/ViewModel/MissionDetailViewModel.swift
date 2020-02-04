//
//  File.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/02/04.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation

class MissionDetailViewModel: ViewModel {
    var missionDetail: MissionDetail?
    
    init(title: String, coordinator: SceneCoordinatorType, missionDetail: MissionDetail) {
        self.missionDetail = missionDetail
        super.init(title: title, coordinator: coordinator)
    }
    
    func missionCompleteAction() -> CocoaAction {
        return Action { [unowned self] _ in
            return self.coordinator.transition(to: MissionScene.sendMission,
                                               using: .popToRoot,
                                               animated: true).asObservable().map { _ in }
        }
    }
}
