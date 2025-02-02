//
//  File.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/02/04.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation

class FeedDetailViewModel: ViewModel {
    var missionDetail: MissionDetail?
    var feedDetail: Feed?
    
    init(title: String, coordinator: SceneCoordinatorType, feedDetail: Feed) {
        self.feedDetail = feedDetail
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
