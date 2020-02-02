//
//  MissionDetailViewModel.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/01/31.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation

class MissionPostViewModel: ViewModel {
    let missionInfo: Mission
    
    init(title: String, coordinator: SceneCoordinatorType, missionInfo: Mission) {
        self.missionInfo = missionInfo
        super.init(title: title, coordinator: coordinator)
    }
}
