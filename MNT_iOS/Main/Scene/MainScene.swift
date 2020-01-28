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
        }
    }
}

