//
//  MissionViewModel.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/01/31.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Action

class MissionViewModel: ViewModel {
    var missions: [Mission] = []
    
    func missionDetailAction(index: Int) -> CocoaAction {
        return Action { [unowned self] _ in
            let viewModel = MissionPostViewModel(title: "미션 등록",
                                                 coordinator: self.coordinator,
                                                 missionInfo: self.missions[index])
            let scene = MissionScene.missionDetail(viewModel)
            return self.coordinator
                .transition(to: scene,
                            using: .modal,
                            animated: true)
                .asObservable().map { _ in }
        }
    }
}
