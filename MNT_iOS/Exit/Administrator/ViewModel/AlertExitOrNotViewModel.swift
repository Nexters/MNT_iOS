//
//  AlertExitOrNotViewModel.swift
//  MNT_iOS
//
//  Created by Jihye on 2020/02/07.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation
import RxCocoa
import Action
import RxSwift

class AlertExitOrNotViewModel: ViewModel {
    
    func cancelAction() -> CocoaAction {
        return Action { action in
            
            return Observable.just(action)
        }
    }
    
    func exitAction() -> CocoaAction {
        return CocoaAction { _ in
            let viewModel = TabBarViewModel(title: "모아보기", coordinator: self.coordinator)
            let scene = MainScene.enterRoom(viewModel)
            
            return self.coordinator.transition(to: scene, using: .push, animated: true).asObservable().map { _ in }
        }
    }
}
