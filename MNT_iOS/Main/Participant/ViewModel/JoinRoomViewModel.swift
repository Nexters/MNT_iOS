//
//  joinViewModel.swift
//  MNT_iOS
//
//  Created by Jihye on 2020/01/29.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation
import RxCocoa
import Action
import RxSwift

class JoinRoomViewModel: ViewModel {
    let codeTextRelay = BehaviorRelay(value: "")
    
    func presentReadyAction() -> CocoaAction {
        return CocoaAction { action in
            if self.codeTextRelay.value == "" {
                let alert = UIAlertController(title: nil, message: "초대코드를 입력해주세요.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
                alert.addAction(okAction)
                UIApplication.topViewController()?.present(alert, animated: false)
                
                return Observable.just(action)
            }
            else {
                let viewModel = ReadyViewModel(title: "대기화면", coordinator: self.coordinator)
                let scene = MainScene.ready(viewModel)
                
                self.getRoomAttend(self.codeTextRelay.value)
                
                return self.coordinator.transition(to: scene, using: .push, animated: true).asObservable().map { _ in }
            }
        }
    }
    
    private func getRoomAttend(_ roomId: String) {
        APISource.shared.getRoomAttend(roomId: Int(roomId) ?? 0, userId: "zik") { room in
            print("roomId = \(Int(roomId) ?? 0)")
        }?.disposed(by: rx.disposeBag)
    }
}
