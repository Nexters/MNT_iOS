//
//  MissionPreviewViewModel.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/03/25.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation

class MissionPreviewViewModel: ViewModel {
    let missionSendingData: MissionSendingData
    
    init(missionSendingData: MissionSendingData, coordinator: SceneCoordinatorType) {
        self.missionSendingData = missionSendingData
        super.init(title: "", coordinator: coordinator)
    }
    
    func confirmAction() {
        self.coordinator.transition(using: .popToRoot)
    }
}
