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
    var kakaoLinkParams : String? = nil
    
    func test() {
        APISource.shared.getRoomExistCheck(userId: "zik") { httpStatus in
            if httpStatus != 404 {
                let viewModel = ReadyViewModel(title: "", coordinator: self.coordinator)
                let scene: SceneType = MainScene.ready(viewModel as! ReadyViewModel)
                self.coordinator.transition(to: scene, using: .root, animated: true).asObservable().map { _ in }
            }
        }?.disposed(by: rx.disposeBag)
    }
    
    func checkKakaoLinkParams() {
        print("Kakao Params = \(kakaoLinkParams)")
        
        if kakaoLinkParams != nil {
            // 방 시작됐는지 확인
            // - 시작 됨 : 해당 방에 참여하면 TabBar로 가도록
            // - 시작 안 됨 : joinRoom에 가도록
            // 방이 종료되었으면..?
            
            APISource.shared.getRoomCheck(userId: "zik") { roomCheck in
                if roomCheck[0].userFruttoId == nil { // 방 시작 안 함
                    let viewModel = JoinRoomViewModel(title: "", coordinator: self.coordinator)
                    let scene: SceneType = MainScene.joinRoom(viewModel as! JoinRoomViewModel)
                    viewModel.kakaoLinkParams = self.kakaoLinkParams
                    self.coordinator.transition(to: scene, using: .push, animated: true).asObservable().map { _ in }
                }
            }?.disposed(by: rx.disposeBag)
        }
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
