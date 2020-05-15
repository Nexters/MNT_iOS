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
    var kakaoLinkParams : String?
    
    func presentReadyAction() -> CocoaAction {
        return CocoaAction { action in
            // * 예외처리 *
            // 초대코드가 비어있거나
            // 초대코드가 int 형으로 변환할 수 없거나
            // 일치하는 초대코드가 없거나
            
            if self.codeTextRelay.value == "" {
                let alert = UIAlertController(title: nil, message: "초대코드를 입력해주세요.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
                alert.addAction(okAction)
                UIApplication.topViewController()?.present(alert, animated: false)
            }
            else {
                let viewModel = ReadyViewModel(title: "대기화면", coordinator: self.coordinator)
                let scene = MainScene.ready(viewModel)
                
                if let user: User = UserDefaults.standard.getObject(key: .user) {
                    APISource.shared.getRoomAttend(roomId: Int(self.codeTextRelay.value)!, userId: user.id) { room in
                        print("res = \(room)")
                        UserDefaults.standard.setObject(object: room, key: .room)
                    }
                    return self.coordinator.transition(to: scene, using: .root, animated: true).asObservable().map { _ in }
                } else {
                    print("user getObject 실패")
                }
            }
            return Observable.just(action)
        }
    }
}
