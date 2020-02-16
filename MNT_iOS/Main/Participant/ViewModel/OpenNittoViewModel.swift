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
            let viewModel = TabBarViewModel(title: "피드", coordinator: self.coordinator)
            let scene = MainScene.enterRoom(viewModel)
            return self.coordinator.transition(to: scene, using: .push, animated: true).asObservable().map { _ in }
        }
    }
}
