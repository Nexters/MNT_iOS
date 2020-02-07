//
//  ExitScene.swift
//  MNT_iOS
//
//  Created by Jihye on 2020/02/05.
//  Copyright © 2020 최민섭. All rights reserved.
//

import UIKit

enum ExitScene {
    case alertExitOrNot(AlertExitOrNotViewModel)
    case alertExit(AlertExitViewModel)
    case guess(GuessViewModel)
}

extension ExitScene: SceneType {
    func instantiate() -> UIViewController {
        switch self {
        case .alertExitOrNot(let viewModel):
            let navigationVC = UINavigationController(rootViewController: AlertExitOrNotViewController())
            if var alertExitOrNotVC = navigationVC.viewControllers.first as? AlertExitOrNotViewController {
                alertExitOrNotVC.bind(viewModel: viewModel)
            }
            return navigationVC
        case .alertExit(let viewModel):
            let navigationVC = UINavigationController(rootViewController: AlertExitViewController())
            if var alertExitVC = navigationVC.viewControllers.first as? AlertExitViewController {
                alertExitVC.bind(viewModel: viewModel)
            }
            return navigationVC
        case .guess(let viewModel):
            var guessVC = GuessViewController()
            guessVC.bind(viewModel: viewModel)
            return guessVC
        }
    }
}
