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
    var imageData: UploadableImage?
    
    lazy var missionSendingData: MissionSendingData = {
        return MissionSendingData(mission: missionInfo, content: "")
    }()
    
    lazy var missionName: String = {
        let missionName = missionInfo.missionName ?? ""
        return missionName
    }()
    
    lazy var missionDescription: String = {
        let subTitle = missionList.filter{ $0.title == missionName }.map { $0.subtitle }.first ?? ""
        return subTitle
    }()
    
    init(title: String, coordinator: SceneCoordinatorType, missionInfo: Mission) {
        self.missionInfo = missionInfo
        super.init(title: title, coordinator: coordinator)
    }
    
    func missionPreviewAction() -> CocoaAction {
        return Action { [unowned self] _ in
            let viewModel = MissionPreviewViewModel(missionSendingData: self.missionSendingData,
                                                    imageData: self.imageData,
                                                    coordinator: self.coordinator)
            return self.coordinator.transition(to: MissionScene.missionPreview(viewModel),
                                               using: .push,
                                               animated: true).asObservable().map { _ in}
        }
    }
    
}

