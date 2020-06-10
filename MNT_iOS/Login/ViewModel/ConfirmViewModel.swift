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
            let socialLogin: String? = UserDefaults.standard.getStringValue(key: .socialLogin)
            if (self.nameTextRelay.value == "" || self.nameTextRelay.value == nil) && socialLogin! != "Kakao" {
                let alertVC = FruttoAlert1ViewController()
                alertVC.modalPresentationStyle = .overFullScreen
                alertVC.setTitleLabel(text: "이름을 입력해주세요.")
                UIApplication.topViewController()?.present(alertVC, animated: true, completion: nil)

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
        let user: User?
        if UserDefaults.standard.getStringValue(key: .socialLogin) == "Kakao" {
            user = User(id: self.id!,
                        name: name!,
                        profilePic: "string",
                        fcmToken: UserDefaults.standard.getStringValue(key: .fcmToken) ?? "string")
        } else {
            user = User(id: self.id!,
                        name: nameTextRelay.value ?? "프루또",
                        profilePic: "string",
                        fcmToken: UserDefaults.standard.getStringValue(key: .fcmToken) ?? "string")
        }
        
        APISource.shared.postSignUp(user: user!) {
            UserDefaults.standard.setObject(object: user!, key: .user)
        }
    }
}
