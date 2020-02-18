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
    case userList(UserListViewModel)
    case filter(FeedFilterViewModel)
}

extension FeedScene: SceneType {
    func instantiate() -> UIViewController {
        switch self {
        case .feed(let viewModel):
            let navigationVC = NavigationController(rootViewController: FeedViewController())
            if var feedVC = navigationVC.viewControllers.first as? FeedViewController {
                feedVC.bind(viewModel: viewModel)
            }
            return navigationVC
        case .userList(let viewModel):
            var userlistVC = UserListViewController()
            userlistVC.bind(viewModel: viewModel)
            return userlistVC
        case .filter(let viewModel):
            var filterVC = FeedFilterViewController()
            filterVC.bind(viewModel: viewModel)
            return filterVC
        }
    }
}
