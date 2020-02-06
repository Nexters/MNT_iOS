//
//  AlertExitViewModel.swift
//  MNT_iOS
//
//  Created by Jihye on 2020/02/05.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation
import RxCocoa
import Action
import RxSwift

class AlertExitViewModel: ViewModel {
    func presentGuessAction() -> CocoaAction {
        return CocoaAction { _ in
            let viewModel = GuessViewModel(title: "마니또 맞추기", coordinator: self.coordinator)
            let scene = ExitScene.guess(viewModel)

            return self.coordinator.transition(to: scene, using: .push, animated: true).asObservable().map { _ in}
        }
    }
}
