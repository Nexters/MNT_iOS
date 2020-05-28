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
    
    func presentMainAction() -> CocoaAction {
        return CocoaAction { _ in
            let viewModel = MainViewModel(title: "메인", coordinator: self.coordinator)
            let scene = MainScene.main(viewModel)
            
            self.requestMe()
            
            return self.coordinator.transition(to: scene, using: .root, animated: true).asObservable().map { _ in }
        }
    }
    
    func requestMe() {
        var user: User?
        
        KOSessionTask.userMeTask(completion: { (error, me) in
            if let error = error as NSError? {
                UIAlertController.showMessage(error.description)
            } else if let me = me as KOUserMe? {
                
//                 아래 주석 해제할 때 삭제할 것
                user = User(id: "2579483",
                            name: "name",
                            profilePic: "string",
                            fcmToken: "string")
                
//                 아래 주석 해제할 때 삭제할 것
                APISource.shared.postSignUp(user: user!,
                                            completion: {
                                                UserDefaults.standard.setObject(object: user!, key: .user)
                })
                
//                user = User(id: me.id!,
//                            name: me.nickname!,
//                            profilePic: me.profileImageURL?.absoluteString ?? "",
//                            fcmToken: "string")
//
//                APISource.shared.postSignUp(user: user!){
//                    UserDefaults.standard.setObject(object: user!, key: .user)
//                }?.disposed(by: self.rx.disposeBag)
            } else {
                print("has no id")
            }
        })
    }
}
