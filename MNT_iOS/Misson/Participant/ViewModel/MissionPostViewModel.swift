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
    var sendMissionInfo: SendMission?
    
    init(title: String, coordinator: SceneCoordinatorType, missionInfo: Mission) {
        self.missionInfo = missionInfo
        super.init(title: title, coordinator: coordinator)
    }
    
    func missionPreviewAction(content: String, imageURL: String) -> CocoaAction {
        return Action { [unowned self] _ in
            self.sendMissionInfo = SendMission(mission: self.missionInfo,
                                               fromId: 1,
                                               toId: 1,
                                               fromImageURL: "",
                                               toImageURL: "",
                                               text: content,
                                               imageURL: imageURL)
            return self.coordinator.transition(to: MissionScene.missionPreview(self),
                                               using: .push,
                                               animated: true).asObservable().map { _ in}
        }
    }
    
    func missionCompleteAction() -> CocoaAction {
        return Action { [unowned self] _ in
            return self.coordinator.transition(to: MissionScene.sendMission,
                                               using: .popToRoot,
                                               animated: true).asObservable().map { _ in }
        }
    }
}
