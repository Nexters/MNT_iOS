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
    
    func missionPreviewAction(content: String, imageURL: String) -> CocoaAction {
        return Action { [unowned self] _ in
            let missionDetail = MissionDetail(mission: self.missionInfo,
                                               fromId: 1,
                                               toId: 1,
                                               fromImageURL: "",
                                               toImageURL: "",
                                               text: content,
                                               imageURL: imageURL)
            let viewModel = FeedDetailViewModel(title: "미리보기",
                                                   coordinator: self.coordinator,
                                                   missionDetail: missionDetail)
            return self.coordinator.transition(to: MissionScene.missionPreview(viewModel),
                                               using: .push,
                                               animated: true).asObservable().map { _ in}
        }
    }
}
