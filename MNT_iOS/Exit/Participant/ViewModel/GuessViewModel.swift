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
    var profiles: [ManittoProfile] = []
    
    func collectionViewCellTouchedAction(_ indexPath: Event<IndexPath>) {
        print("selectedIndexPath: \(indexPath)")
        
    }
    
    func openAlertAction(_ isSelected : Bool) -> CocoaAction {
        return Action { [unowned self] action in
            
            print("isSelected: \(isSelected)")
            
            let alert = UIAlertController(title: nil, message: "당신의 내또는 누구였습니다!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
            let VC = self.createCustomVC()
            
            alert.setValue(VC, forKey: "contentViewController")

            alert.addAction(okAction)
            UIApplication.topViewController()?.present(alert, animated: false)
            
            return Observable.just(action)
        }
    }
    
    func createCustomVC() -> UIViewController {
        let nameImage = UIImageView(image: #imageLiteral(resourceName: "endCherry"))
        let customVC = UIViewController()
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        customVC.view = containerView
        customVC.view.addSubview(nameImage)
        
        nameImage.anchor(.top(customVC.view.topAnchor, constant: customVC.view.frame.height * 0.225))
        nameImage.centerXToSuperview()
        
        return customVC
    }
}

