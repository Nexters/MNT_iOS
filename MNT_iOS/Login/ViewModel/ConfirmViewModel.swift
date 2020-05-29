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
    
    func presentMainAction() -> CocoaAction {
        return CocoaAction { _ in
            let viewModel = MainViewModel(title: "메인", coordinator: self.coordinator)
            let scene = MainScene.main(viewModel)
            
            self.requestMe()
            
            return self.coordinator.transition(to: scene, using: .root, animated: true).asObservable().map { _ in }
        }
    }
    
    func requestMe() {
        let user = User(id: self.id!,
                        name: self.name!,
                        profilePic: "string",
                        fcmToken: "string")
        
        APISource.shared.postSignUp(user: user){
            UserDefaults.standard.setObject(object: user, key: .user)
            print(user)
        }
    }
}
