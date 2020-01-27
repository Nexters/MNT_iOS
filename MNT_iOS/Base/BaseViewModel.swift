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

class BaseViewModel: NSObject {
    let title: Driver<String>
    
//    let sceneCoordinator: SceneCoordinatorType
//    let storage: StorageType
//
//    init(title: String, sceneCoordinator: SceneCoordinatorType, storage: StorageType) {
//        self.title = Observable.just(title).asDriver(onErrorJustReturn: "")
//        self.sceneCoordinator = sceneCoordinator
//        self.storage = storage
//    }
    
    init(title: String = "", viewModel: BaseViewModel) {
        self.title = Observable.just(title).asDriver(onErrorJustReturn: "")
    }
    
    func decimal(int: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        return formatter.string(from: int as NSNumber) ?? ""
    }
    
    func stringToInt(_ string: String) -> Int {
        let pureIntString = string.components(separatedBy: ",").joined()
        
        return Int(pureIntString) ?? 0
    }
}
