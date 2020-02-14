//
//  SetRoomTitleViewModel.swift
//  MNT_iOS
//
//  Created by Jihye on 2020/01/29.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation
import RxCocoa
import Action
import RxSwift

class SetRoomTitleViewModel: ViewModel {
    let roomTitleTextRelay = BehaviorRelay(value: "")
    
    func presentSetRoomDetailAction() -> CocoaAction {
        return CocoaAction { action in
            if self.roomTitleTextRelay.value == "" || self.roomTitleTextRelay.value == nil {
                let alert = UIAlertController(title: nil, message: "방 이름을 입력해주세요.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
                alert.addAction(okAction)
                UIApplication.topViewController()?.present(alert, animated: false)
                
                return Observable.just(action)
            }
            else {
                let viewModel = SetRoomDetailViewModel(title: "정원 및 진행일자 설정", coordinator: self.coordinator)
                let scene = MainScene.setRoomDetail(viewModel)
                
                return self.coordinator.transition(to: scene, using: .push, animated: true).asObservable().map { _ in }
            }
        }
    }
}
