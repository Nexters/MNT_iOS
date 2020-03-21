//
//  MissionViewModel.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/01/31.
//  Copyright © 2020 최민섭. All rights reserved.
//

class MissionViewModel: ViewModel {
    var missions: [Mission] = []
    
    func missionDetailAction(index: Int) {
        if missions[index].userMission.userDone == 1 {
            return
        }
        
        let viewModel = MissionPostViewModel(title: "미션 등록",
                                             coordinator: self.coordinator,
                                             missionInfo: self.missions[index])
        let scene = MissionScene.missionPost(viewModel)
        self.coordinator
            .transition(to: scene,
                        using: .push,
                        animated: true)
            .asObservable().map { _ in }
    }
    
    func addNewMissionAction(_ gesture: UITapGestureRecognizer) -> Void {
        let viewModel = AddNewMissionViewModel(title: "미션 부여하기", coordinator: self.coordinator)
        let scene = MissionScene.addNewMission(viewModel)
        self.coordinator
            .transition(to: scene,
                        using: .push,
                        animated: true)
    }
}
