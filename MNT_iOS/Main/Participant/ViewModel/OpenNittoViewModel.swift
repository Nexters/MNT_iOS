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
            
            APISource.shared.getRoomStart(roomId: 12768) { (request) in
                print("지혜짱")
            }?.disposed(by: self.rx.disposeBag)
            
            return self.coordinator.transition(to: scene, using: .root, animated: true).asObservable().map { _ in }
        }
    }
}
