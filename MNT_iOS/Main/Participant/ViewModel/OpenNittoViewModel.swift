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
            
            if room?.id != 60263 {
                APISource.shared.getRoomCheck(userId: user!.id) { (roomCheck) in
                    UserDefaults.standard.setObject(object: roomCheck![0].manitto, key: .manitto)
                    UserDefaults.standard.setIntValue(value: roomCheck![0].userFruttoId!, key: .userFruttoId)
                }
            }
            UserDefaults.standard.setIntValue(value: 1, key: .isEntered)
            
            return self.coordinator.transition(to: scene, using: .root, animated: true).asObservable().map { _ in }
        }
    }
}
