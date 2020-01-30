//
//  MainScene.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/01/28.
//  Copyright © 2020 최민섭. All rights reserved.
//

import UIKit

enum MainScene {
    case main(MainViewModel)
    case joinRoom(JoinRoomViewModel)
    case createRoom(CreateRoomViewModel)
    case setRoomDetail(SetRoomDetailViewModel)
    case ready(ReadyViewModel)
}

extension MainScene: SceneType {
    
    func instantiate(from storyboard: String) -> UIViewController {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        
        switch self {
        case .main(let viewModel):
            // 메모리 적재 타이밍을 위하여 인스턴스 내부 생성
            // UINavigationConroller -> MainViewController 순으로
            guard let navigationController = storyboard.instantiateViewController(withIdentifier: "MainViewController") as? UINavigationController,
                var viewController = navigationController.viewControllers.first as? MainViewController
                else {
                    return UIViewController()
            }
            
            viewController.bind(viewModel: viewModel)
            return navigationController
        case .joinRoom(let viewModel):
            guard var viewController = storyboard.instantiateViewController(withIdentifier: "JoinRoomViewController") as? JoinRoomViewController else { return UIViewController() }

            viewController.bind(viewModel: viewModel)
            return viewController
        case .createRoom(let viewModel):
            guard var viewController = storyboard.instantiateViewController(withIdentifier: "CreateRoomViewController") as? CreateRoomViewController else { return UIViewController() }

            viewController.bind(viewModel: viewModel)
            return viewController
        case .setRoomDetail(let viewModel):
            guard var viewController = storyboard.instantiateViewController(withIdentifier: "SetRoomDetailViewController") as? SetRoomDetailViewController else { return UIViewController() }

            viewController.bind(viewModel: viewModel)
            return viewController
        case .ready(let viewModel):
            guard var viewController = storyboard.instantiateViewController(withIdentifier: "ReadyViewController") as? ReadyViewController else { return UIViewController() }

            viewController.bind(viewModel: viewModel)
            return viewController
        }
        
    }
    
    func instantiate() -> UIViewController {
        return instantiate(from: "Main")
    }
}

