//
//  Coordinatable.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/01/28.
//  Copyright © 2020 최민섭. All rights reserved.
//
import RxSwift

enum TransitionStyle {
    case root
    case push
    case modal
    case popToRoot
}

enum TransitionError: Error {
    case navigationControllerMissing
    case cannotPop
    case unknown
}

protocol SceneType {
    func instantiate() -> UIViewController
}

protocol SceneCoordinatorType {
    func showAlert(title: String, message: String) -> Completable
    
    func transition(to scene: SceneType, using style: TransitionStyle, animated: Bool) -> Completable
    
    func close(animated: Bool) -> Completable
}
