//
//  AgreeViewModel.swift
//  MNT_iOS
//
//  Created by Jihye on 2020/05/13.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation

class AgreeViewModel: ViewModel {
    
    func presentConfirmAction() -> CocoaAction {
        return CocoaAction { _ in
            let viewModel = ConfirmViewModel(title: "반가워요!", coordinator: self.coordinator)
            let scene = LoginScene.confirm(viewModel)
            
            return self.coordinator.transition(to: scene, using: .push, animated: true).asObservable().map { _ in }
        }
    }
}
