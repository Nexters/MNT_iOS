//
//  Coordinator.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/01/28.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit
import Action

class SceneCoordinator: NSObject {
    private var window: UIWindow
    private var currentVC: UIViewController
    
    required init(window: UIWindow) {
        self.window = window
        currentVC = window.rootViewController!
    }
}

extension SceneCoordinator: SceneCoordinatorType {
    func showAlert(title: String, message: String) -> Completable {
        let subject = PublishSubject<Void>()
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction.Action("확인", style: .cancel)
        
        alert.addAction(action)
        
        currentVC.present(alert, animated: true) {
            subject.onCompleted()
        }
        
        return subject.ignoreElements()
    }
    
    func transition(to scene: SceneType, using style: TransitionStyle, animated: Bool) -> Completable {
        let subject = PublishSubject<Void>()
        let target = scene.instantiate()
        
        switch style {
        case .root:
            currentVC = target.sceneViewController
            target.view.backgroundColor = .white
            window.rootViewController = target
            window.makeKeyAndVisible()
            subject.onCompleted()
            
        case .push:
            guard let nav = currentVC.navigationController else {
                subject.onError(TransitionError.navigationControllerMissing)
                break
            }
            nav.rx.willShow
                .subscribe(onNext: { [unowned self] evt in
                    self.currentVC = evt.viewController.sceneViewController
                })
                .disposed(by: rx.disposeBag)
            nav.pushViewController(target, animated: animated)
            subject.onCompleted()
            
        case .modal:
            currentVC.present(target, animated: animated) {
                subject.onCompleted()
            }
            currentVC = target.sceneViewController
            currentVC.modalPresentationStyle = .overFullScreen
        case .popToRoot:
            currentVC.navigationController?.popToRootViewController(animated: true)
        }

        return subject.ignoreElements()
    }
    
    func close(animated: Bool) -> Completable {
        return Completable.create { [unowned self] completable in
            if let presentingVC = self.currentVC.presentingViewController {
                self.currentVC.dismiss(animated: animated) {
                    self.currentVC = presentingVC.sceneViewController
                    completable(.completed)
                }
            } else if let nav = self.currentVC.navigationController {
                guard nav.popViewController(animated: animated) != nil else {
                    completable(.error(TransitionError.cannotPop))
                    return Disposables.create()
                }
                
                self.currentVC = nav.viewControllers.last!
                completable(.completed)
            } else {
                completable(.error(TransitionError.unknown))
            }
            
            return Disposables.create()
        }
    }
}
