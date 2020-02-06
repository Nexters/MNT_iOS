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
    
    func openAlertAction() -> CocoaAction {
        return Action { [unowned self] action in
            let alert = UIAlertController(title: nil, message: "당신의 내또는 누구였습니다!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)

            alert.addAction(okAction)

//            let contentView = FromToView()
//            alert.setValue(contentView, forKey: "FromToView")

            UIApplication.topViewController()?.present(alert, animated: false)

            //self.present(alert, animated: false)

            return Observable.just(action)
        }
    }
}
