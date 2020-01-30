//
//  SetRoomDetailViewModel.swift
//  MNT_iOS
//
//  Created by Jihye on 2020/01/29.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation
import RxCocoa
import Action
import RxSwift

class SetRoomDetailViewModel: ViewModel {
    
    func presentReadyAction() -> CocoaAction {
        return CocoaAction { _ in
            let viewModel = ReadyViewModel(title: "대기화면", coordinator: self.coordinator)
            let scene = MainScene.ready(viewModel)
            
            return self.coordinator.transition(to: scene, using: .push, animated: true).asObservable().map { _ in }
        }
    }
}
