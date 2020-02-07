//
//  AlertExitOrNotViewModel.swift
//  MNT_iOS
//
//  Created by Jihye on 2020/02/07.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation
import RxCocoa
import Action
import RxSwift

class AlertExitOrNotViewModel: ViewModel {
    func openAlertAction() -> CocoaAction {
        return Action { [unowned self] action in
            let alert = UIAlertController(title: nil, message: "마니또를 공개하시겠습니까?\n참가자들의 마니또가 공개됩니다.", preferredStyle: .alert)
            let noAction = UIAlertAction(title: "취소", style: .default, handler: nil)
            let okAction = UIAlertAction(title: "종료하기", style: .default, handler: nil)

            alert.addAction(noAction)
            alert.addAction(okAction)
            UIApplication.topViewController()?.present(alert, animated: false)

            return Observable.just(action)
        }
    }
}
