//
//  createViewModel.swift
//  MNT_iOS
//
//  Created by Jihye on 2020/01/29.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation
import RxCocoa
import Action
import RxSwift

class CreateRoomViewModel: ViewModel {
    let roomNameTextRelay = BehaviorRelay(value: "")
    
    func presentSetRoomDetailAction() -> CocoaAction {
        return CocoaAction { _ in
            let viewModel = SetRoomDetailViewModel(title: "정원 및 진행일자 설정", coordinator: self.coordinator)
            let scene = MainScene.setRoomDetail(viewModel)
            
            return self.coordinator.transition(to: scene, using: .push, animated: true).asObservable().map { _ in }
        }
    }
    
}
