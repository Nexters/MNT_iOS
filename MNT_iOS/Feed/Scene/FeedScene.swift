//
//  FeedScene.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/01/31.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation

enum FeedScene {
    case feed(FeedViewModel)
}

extension FeedScene: SceneType {
    func instantiate() -> UIViewController {
        switch self {
        case .feed(let viewModel):
            let navigationVC = UINavigationController(rootViewController: FeedViewController())
            if var feedVC = navigationVC.viewControllers.first as? FeedViewController {
                feedVC.bind(viewModel: viewModel)
            }
            return navigationVC
        }
    }
}
