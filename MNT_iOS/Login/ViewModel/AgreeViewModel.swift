//
//  AgreeViewModel.swift
//  MNT_iOS
//
//  Created by Jihye on 2020/05/13.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation

class AgreeViewModel: ViewModel {
    
//    func presentMainAction() -> CocoaAction {
//        return CocoaAction { _ in
//            let viewModel = MainViewModel(title: "메인", coordinator: self.coordinator)
//            let scene = MainScene.main(viewModel)
//
//            let user: User = User(id: "0622", name: "설아", profilePic: "string", fcmToken: "string")
//
//            APISource.shared.postSignUp(user: user){
//                print("testing : signUp")
//            }?.disposed(by: self.rx.disposeBag)
//
//            return self.coordinator.transition(to: scene, using: .root, animated: true).asObservable().map { _ in }
//        }
//    }
    
    func presentConfirmAction() -> CocoaAction {
        return CocoaAction { _ in
            let viewModel = ConfirmViewModel(title: "반가워요!", coordinator: self.coordinator)
            let scene = LoginScene.confirm(viewModel)
            
            return self.coordinator.transition(to: scene, using: .push, animated: true).asObservable().map { _ in }
        }
    }
}
