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
    case setRoomTitle(SetRoomTitleViewModel)
    case setRoomDetail(SetRoomDetailViewModel)
    case ready(ReadyViewModel)
    case enterRoom(TabBarViewModel)
    case openNitto(OpenNittoViewModel)
    case showParticipant(MainUserListViewModel)
}

extension MainScene: SceneType {
    func instantiate() -> UIViewController {
        switch self {
        case .main(let viewModel):
            // 메모리 적재 타이밍을 위하여 인스턴스 내부 생성
            // UINavigationConroller -> MainViewController 순으로
            let navigationVC = UINavigationController(rootViewController: MainViewController())
            if var mainVC = navigationVC.viewControllers.first as? MainViewController {
                mainVC.bind(viewModel: viewModel)
            }
            return navigationVC
            
        case .joinRoom(let viewModel):
            var joinRoomVC = JoinRoomViewController()
            joinRoomVC.bind(viewModel: viewModel)
            return joinRoomVC
            
        case . setRoomTitle(let viewModel):
            var setRoomTitleVC = SetRoomTitleViewController()
            setRoomTitleVC.bind(viewModel: viewModel)
            return setRoomTitleVC
            
        case .setRoomDetail(let viewModel):
            var setRoomDetailVC = SetRoomDetailViewController()
            setRoomDetailVC.bind(viewModel: viewModel)
            return setRoomDetailVC
            
        case .ready(let viewModel):
            let navigationVC = UINavigationController(rootViewController: ReadyViewController())
            if var readyVC = navigationVC.viewControllers.first as? ReadyViewController {
                readyVC.bind(viewModel: viewModel)
            }
            return navigationVC
            
        case .enterRoom(let viewModel):
            var tabBarVC = TabBarViewController()
            tabBarVC.bind(viewModel: viewModel)
            return tabBarVC
            
        case .openNitto(let viewModel):
            var openNittoVC = OpenNittoViewController()
            openNittoVC.bind(viewModel: viewModel)
            return openNittoVC
            
        case .showParticipant(let viewModel):
            var mainUserListVC = MainUserListViewController()
            mainUserListVC.bind(viewModel: viewModel)
            return mainUserListVC
        }
    }
}

