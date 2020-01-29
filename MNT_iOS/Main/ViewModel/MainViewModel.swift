//
//  MainViewModel.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/01/28.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation
import RxCocoa
import Action
import RxSwift

class MainViewModel: ViewModel {
    let textfieldRelay = BehaviorRelay(value: "")
    
    func presentJoinAction() -> CocoaAction {
        return CocoaAction { _ in
            let viewModel = JoinRoomViewModel(title: "참여하기", coordinator: self.coordinator)
            let scene = MainScene.joinRoom(viewModel)

            return self.coordinator.transition(to: scene, using: .push, animated: true).asObservable().map { _ in }
        }
    }
    
    func presentCreateAction() -> CocoaAction {
        return CocoaAction { _ in
            let viewModel = CreateRoomViewModel(title: "방 만들기", coordinator: self.coordinator)
            let scene = MainScene.createRoom(viewModel)
            
            return self.coordinator.transition(to: scene, using: .push, animated: true).asObservable().map { _ in }
        }
    }
}
