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
    
    func openAlertAction(_ fromImage: String, _ fromLabel: String, _ toImage: String, _ toLabel: String) -> CocoaAction {
        return Action { [unowned self] action in
            
            let alert = UIAlertController(title: nil, message: "당신의 내또는 누구였습니다!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
            let VC = FromToViewController()
            
            VC.manittoLabel.text = fromLabel
            VC.targetLabel.text = toLabel
            VC.manittoImageView.kf.setImage(with: URL(string: fromImage))
            VC.targetImageView.kf.setImage(with: URL(string: toImage))
            
            alert.setValue(VC, forKey: "contentViewController")

            alert.addAction(okAction)
            UIApplication.topViewController()?.present(alert, animated: false)

            return Observable.just(action)
        }
    }
}

