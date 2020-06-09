//
//  OpenNitto.swift
//  MNT_iOS
//
//  Created by Jihye on 2020/02/14.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation

class OpenNittoViewModel: ViewModel {
    
    func presentTabBarAction() -> CocoaAction {
        return CocoaAction { action in
            let viewModel = TabBarViewModel(title: "", coordinator: self.coordinator)
            let scene: SceneType = MainScene.enterRoom(viewModel)
            
            let user: User? = UserDefaults.standard.getObject(key: .user)
            let room: Room? = UserDefaults.standard.getObject(key: .room)
            UserDefaults.standard.setIntValue(value: 1, key: .isEntered)
            
            APISource.shared.getRoomCheck(userId: user!.id) { (roomCheck) in
                let roomNum: Int = roomCheck?.count ?? 0
                if roomNum > 0 {
                    let index = roomNum - 1 // 마지막으로 참가한 방의 인덱스
                    UserDefaults.standard.setObject(object: roomCheck![index].manitto, key: .manitto)
                    UserDefaults.standard.setIntValue(value: roomCheck![index].userFruttoId!, key: .userFruttoId)
                    self.coordinator.transition(to: scene, using: .root, animated: true)
                }
            }
            
            return Observable.just(action)
        }
    }
}
