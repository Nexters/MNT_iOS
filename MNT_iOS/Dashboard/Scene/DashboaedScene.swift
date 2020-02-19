//
//  DashboaedScene.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/02/19.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation

enum DashboardScene {
    case dashBoard(DashboardViewModel)
}

extension DashboardScene: SceneType {
    func instantiate() -> UIViewController {
        switch self {
        case .dashBoard(let viewModel):
            let navigationVC = NavigationController(rootViewController: DashboardViewController())
            navigationVC.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            navigationVC.navigationBar.shadowImage = UIImage()
            if var dashVC = navigationVC.viewControllers.first as? DashboardViewController {
                dashVC.bind(viewModel: viewModel)
            }
            return navigationVC
        }
    }
}
