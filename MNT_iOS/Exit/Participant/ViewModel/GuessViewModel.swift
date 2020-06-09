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
            let alert = UIAlertController(title: nil, message: "당신의 마니또는?", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .default, handler: { (action) in
                UserDefaults.standard.setIntValue(value: 1, key: .isOver)
                self.coordinator.transition(to: scene, using: .root, animated: true)
            })
            var VC: UIViewController?
            let user: User? = UserDefaults.standard.getObject(key: .user)
            let room: Room? = UserDefaults.standard.getObject(key: .room)
            
            APISource.shared.getRoomUserList(roomId: room!.id) { participants in
                for i in 0..<participants.count {
                    if participants[i].manitto.id == user?.id {
                        manittoName = participants[i].user.name
                        manittoFruttoId = participants[i].userFruttoId
                        VC = self.createCustomVC(manittoName!, manittoFruttoId!)
                        alert.setValue(VC, forKey: "contentViewController")
                        alert.addAction(okAction)
                        UIApplication.topViewController()?.present(alert, animated: false)
                    }
                }
            }
            
            return Observable.just(action)
        }
    }
    
    func createCustomVC(_ manittoName: String, _ manittoFruittoId: Int) -> UIViewController {
        let nameImage = UIImageView(image: FruitImage.sharedInstance.getFruitPopUp(manittoFruittoId))
        var nameLabel = UILabel(text: manittoName,
                                font: .mediumFont(ofSize: 16),
                                textColor: .defaultText,
                                textAlignment: .center,
                                numberOfLines: 0)
        let customVC = UIViewController()
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        customVC.view = containerView
        customVC.view.addSubview(nameImage)
        customVC.view.addSubview(nameLabel)
        
        nameImage.anchor(.top(customVC.view.topAnchor, constant: customVC.view.frame.height * 0.225))
        nameLabel.anchor(.top(nameImage.topAnchor, constant: nameImage.frame.height * 0.34))
        nameImage.centerXToSuperview()
        nameLabel.centerXToSuperview()
        
        customVC.preferredContentSize.width = 300
        customVC.preferredContentSize.height = 200
        
        return customVC
    }
}

