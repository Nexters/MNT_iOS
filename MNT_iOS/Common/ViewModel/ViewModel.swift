//
//  BaseViewModel.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/01/27.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class ViewModel: NSObject {
    let title: Driver<String>
    let coordinator: SceneCoordinatorType

    init(title: String, coordinator: SceneCoordinatorType) {
        self.title = Observable.just(title).asDriver(onErrorJustReturn: "")
        self.coordinator = coordinator
    }
    
    init(title: String = "", viewModel: ViewModel) {
        self.title = Observable.just(title).asDriver(onErrorJustReturn: "")
        self.coordinator = viewModel.coordinator
    }
}
