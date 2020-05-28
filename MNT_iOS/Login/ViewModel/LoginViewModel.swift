//
//  LoginViewModel.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/01/28.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation

class LoginViewModel: ViewModel {
    
    func presentAgreeAction() {
        let viewModel = AgreeViewModel(title: "이용약관", coordinator: self.coordinator)
        let scene: SceneType = LoginScene.agree(viewModel as! AgreeViewModel)
        
        self.coordinator.transition(to: scene, using: .root, animated: true).asObservable().map { _ in }
    }
}
