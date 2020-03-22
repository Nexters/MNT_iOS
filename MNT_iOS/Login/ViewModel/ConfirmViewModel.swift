//
//  ConfirmViewModel.swift
//  MNT_iOS
//
//  Created by Jihye on 2020/02/13.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation

class ConfirmViewModel: ViewModel {
    func presentMainAction() -> CocoaAction {
        return CocoaAction { _ in
            let viewModel = MainViewModel(title: "메인", coordinator: self.coordinator)
            let scene = MainScene.main(viewModel)
            
            APISource.shared.postSignUp(user: User())?
                .disposed(by: self.rx.disposeBag)
            
            return self.coordinator.transition(to: scene, using: .root, animated: true).asObservable().map { _ in }
        }
    }
}
