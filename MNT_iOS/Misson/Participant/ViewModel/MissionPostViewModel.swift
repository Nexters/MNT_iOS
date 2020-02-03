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
    
    // 액션 등록하고
    // 프리뷰 넘어갈때 mission send 모델 넘겨준다.
    // 프리뷰 페이지에서 완료버튼이 들어오면 전달완료...
}
