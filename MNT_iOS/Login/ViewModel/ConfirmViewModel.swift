//
//  ConfirmViewModel.swift
//  MNT_iOS
//
//  Created by Jihye on 2020/02/13.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation
import Alamofire

class ConfirmViewModel: ViewModel {
    var id: String?
    var name: String?
    let nameTextRelay = BehaviorRelay(value: "")
    
    func presentMainAction() -> CocoaAction {
        return CocoaAction { action in
            if self.nameTextRelay.value == "" || self.nameTextRelay.value == nil {
                let alert = UIAlertController(title: nil, message: "이름을 입력해주세요.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
                alert.addAction(okAction)
                UIApplication.topViewController()?.present(alert, animated: false)
                
                return Observable.just(action)
            } else {
                let viewModel = MainViewModel(title: "메인", coordinator: self.coordinator)
                let scene = MainScene.main(viewModel)
                
                self.requestMe()
                
                return self.coordinator.transition(to: scene, using: .root, animated: true).asObservable().map { _ in }
            }
        }
    }
    
    func requestMe() {
        let user = User(id: self.id!,
                        name: nameTextRelay.value ?? "프루또",
                        profilePic: "string",
                        fcmToken: UserDefaults.standard.getStringValue(key: .fcmToken) ?? "string")
        
        APISource.shared.postSignUp(user: user) {
            UserDefaults.standard.setObject(object: user, key: .user)
        }
    }
}
