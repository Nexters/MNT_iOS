//
//  TabBarViewController.swift
//  MNT_iOS
//
//  Created by Jihye on 2020/02/10.
//  Copyright © 2020 최민섭. All rights reserved.
//

import UIKit

class TabBarViewController: ViewController {
    var viewModel: TabBarViewModel?
    var dashBoardButton = UIButton(title: "대시보드", titleColor: .black)
    var feedButton = UIButton(title: "피드", titleColor: .black)
    var missionButton = UIButton(title: "미션", titleColor: .black)
    var stackView = UIView()
    var stackIndex: Int? // 0: 대시보드, 1: 피드, 2: 미션
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.bindMissionAction(self)
    }
    
    override func setupLayout() {
        
    }
}

extension TabBarViewController: ViewModelBindableType {
    func bindViewModel(viewModel: TabBarViewModel) {
        feedButton.rx.action = viewModel.presentFeedAction(self)
        missionButton.rx.action = viewModel.presentMissionAction(self)
    }
    
    func changeIndex(to: Int) {
        self.stackIndex = to
    }
}
