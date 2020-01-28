//
//  MainViewModel.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/01/28.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation
import RxCocoa
import Action
import RxSwift

class MainViewModel: ViewModel {
    let textfieldRelay = BehaviorRelay(value: "")
    
//    func buttonAction() -> CocoaAction {
//        return Action { [unowned self] action in
//            return Observable.just(action)
//            .flatMap(<#T##selector: (()) throws -> ObservableConvertibleType##(()) throws -> ObservableConvertibleType#>)
//        }
//    }
}
