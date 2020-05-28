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
            if self.codeTextRelay.value == "" {
                self.showAlert("초대코드를 입력해주세요.")
                return Observable.just(action)
            }
            
            let code: Int = Int(self.codeTextRelay.value) ?? -1
            if (code == -1) {
                self.showAlert("초대코드 입력이 잘못 되었습니다.")
            } else {
                if let user: User = UserDefaults.standard.getObject(key: .user) {
                    APISource.shared.getRoomUserList(roomId: code) { participants in
                        if (participants.count == 0) {
                            self.showAlert("존재하지 않는 방입니다.")
                        } else {
                            if (participants.count > participants[0].room.maxPeople) {
                                self.showAlert("방 인원이 초과하였습니다.")
                            } else {
                                if (participants.count > 1 && participants[1].userFruttoId != nil) {
                                    self.showAlert("이미 시작된 방입니다.")
                                } else {
                                    APISource.shared.getRoomAttend(roomId: code, userId: user.id) { room in
                                        UserDefaults.standard.setObject(object: room, key: .room)

                                        let viewModel = ReadyViewModel(title: "대기화면", coordinator: self.coordinator)
                                        let scene = MainScene.ready(viewModel)

                                        self.coordinator.transition(to: scene, using: .root, animated: true).asObservable().map { _ in }
                                    }
                                }
                            }
                        }
                    }
                } else {
                    print("user getObject 실패")
                }
            }
            
            return Observable.just(action)
        }
    }
    
    func showAlert(_ message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(okAction)
        UIApplication.topViewController()?.present(alert, animated: false)
    }
}
