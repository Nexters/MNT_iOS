//
//  GuessViewModel.swift
//  MNT_iOS
//
//  Created by Jihye on 2020/02/07.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation
import RxCocoa
import Action
import RxSwift

class GuessViewModel: ViewModel {
    var userNameList: [String] = []
    var userIdList: [Int] = []
    
    func collectionViewCellTouchedAction(_ indexPath: Event<IndexPath>) {
        print("selectedIndexPath: \(indexPath)")
    }
    
    func openAlertAction(_ isSelected : Bool) -> CocoaAction {
        return Action { [unowned self] action in
            var manittoName: String?
            var manittoFruttoId: Int?
            let viewModel = TabBarViewModel(title: "Tabbar", coordinator: self.coordinator)
            let scene = MainScene.enterRoom(viewModel)
            let user: User? = UserDefaults.standard.getObject(key: .user)
            let room: Room? = UserDefaults.standard.getObject(key: .room)
            
            APISource.shared.getRoomUserList(roomId: room!.id) { participants in
                for i in 0..<participants.count {
                    if participants[i].manitto.id == user?.id {
                        manittoName = participants[i].user.name
                        manittoFruttoId = participants[i].userFruttoId
                        
                        let alertVC = FruttoAlertWithImageViewController()
                        alertVC.modalPresentationStyle = .overFullScreen
                        alertVC.setTitleLabel(text: "당신의 마니또는?")
                        alertVC.setManitto(manittoName: manittoName ?? "프루또",
                                           manittoFruttoId: manittoFruttoId ?? 3)
                        alertVC.onConfirm = {
                            print("확인")
                            let viewModel = TabBarViewModel(title: "Tabbar", coordinator: self.coordinator)
                            let scene = MainScene.enterRoom(viewModel)
                            UserDefaults.standard.setIntValue(value: 1, key: .isOver)
                            self.coordinator.transition(to: scene, using: .root, animated: true)
                        }
                        UIApplication.topViewController()?.present(alertVC, animated: true, completion: nil)
                    }
                }
            }
            
            return Observable.just(action)
        }
    }
}

