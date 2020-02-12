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
        viewModel?.bindFeedAction(self)
    }
    
    override func setupLayout() {
        
    }
    
    func changeIndex(to: Int) {
        self.stackIndex = to
    }
}

extension TabBarViewController: ViewModelBindableType {
    func bindViewModel(viewModel: TabBarViewModel) {
        feedButton.rx.action = viewModel.presentFeedAction(self)
        missionButton.rx.action = viewModel.presentMissionAction(self)
    }
    
    func hideHeader() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
            if #available(iOS 11.0, *) {
                self.stackView.frame = CGRect(x: self.stackView.frame.origin.x, y: (self.view.frame.height + self.view.safeAreaInsets.bottom + 0), width: self.stackView.frame.width, height: 50)
            } else {
                self.stackView.frame = CGRect(x: self.stackView.frame.origin.x, y: (self.view.frame.height + 100), width: self.stackView.frame.width, height: 50)
            }
        })
    }
    
    func showHeader() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
            if #available(iOS 11.0, *) {
                self.stackView.frame = CGRect(x: self.stackView.frame.origin.x, y: self.view.frame.height - (50 + self.view.safeAreaInsets.bottom + 0), width: self.stackView.frame.width, height: 50)
            } else {
                self.stackView.frame = CGRect(x: self.stackView.frame.origin.x, y: self.view.frame.height - (50 + 100), width: self.stackView.frame.width, height: 50)
            }
        })
    }
}
