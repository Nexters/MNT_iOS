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
    
    func test() {
        APISource.shared.getRoomExistCheck(userId: "zik") { httpStatus in
            if httpStatus != 404 {
                let viewModel = ReadyViewModel(title: "", coordinator: self.coordinator)
                let scene: SceneType = MainScene.ready(viewModel as! ReadyViewModel)
                self.coordinator.transition(to: scene, using: .root, animated: true).asObservable().map { _ in }
            }
        }?.disposed(by: rx.disposeBag)
    }
    
    func presentJoinAction() -> CocoaAction {
        return CocoaAction { _ in
            let viewModel = JoinRoomViewModel(title: "참여하기", coordinator: self.coordinator)
            let scene = MainScene.joinRoom(viewModel)

            return self.coordinator.transition(to: scene, using: .push, animated: true).asObservable().map { _ in }
        }
    }
    
    func presentSetAction() -> CocoaAction {
        return CocoaAction { _ in
            let viewModel = SetRoomTitleViewModel(title: "방 만들기", coordinator: self.coordinator)
            let scene = MainScene.setRoomTitle(viewModel)
            
            return self.coordinator.transition(to: scene, using: .push, animated: true).asObservable().map { _ in }
        }
    }
}
