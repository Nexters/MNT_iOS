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
    var dashBoardButton = UIButton(title: "", titleColor: .black)
    var feedButton = UIButton(title: "", titleColor: .black)
    var missionButton = UIButton(title: "", titleColor: .black)
    var dashBoardLabel = UILabel(text: "대시보드", font: .boldSystemFont(ofSize: 10), textColor: UIColor.contentText, textAlignment: .center, numberOfLines: 0)
    var feedLabel = UILabel(text: "피드", font: .boldSystemFont(ofSize: 10), textColor: UIColor.contentText, textAlignment: .center, numberOfLines: 0)
    var missionLabel = UILabel(text: "미션", font: .boldSystemFont(ofSize: 10), textColor: UIColor.contentText, textAlignment: .center, numberOfLines: 0)

    var stackView = UIView()
    var stackIndex: Int? // 0: 대시보드, 1: 피드, 2: 미션
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.bindFeedAction(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            self.navigationController?.isNavigationBarHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            self.navigationController?.isNavigationBarHidden = false
    }
    
    override func setupLayout() {
        let width = view.frame.width
        let height = view.frame.height
        
        stackView.stack(UIView().withHeight(height * 0.012),
                        stackView.hstack(UIView().withWidth(36),
                                         dashBoardButton.withWidth(24),
                                         UIView().withWidth(59),
                                         feedButton.withWidth(24),
                                         UIView().withWidth(59),
                                         missionButton.withWidth(24),
                                         UIView().withWidth(37)).withHeight(24),
                        UIView().withHeight(5),
                        stackView.hstack(UIView().withWidth(31),
                                         dashBoardLabel.withWidth(35),
                                         UIView().withWidth(48),
                                         feedLabel.withWidth(35),
                                         UIView().withWidth(57),
                                         missionLabel.withWidth(18),
                                         UIView().withWidth(39)).withHeight(10),
                        UIView().withHeight(10))
        
        stackView.frame = CGRect(x: (width - 263)/2,
                                 y: height - (59 + 34),
                                 width: 263,
                                 height: 59)
        
        stackView.backgroundColor = UIColor.white
        stackView.layer.masksToBounds = false
        stackView.layer.cornerRadius = 30
        stackView.setupShadow(opacity: 0.15,
                              radius: 10,
                              offset: .init(width: 0, height: 3))
    }
    
    func changeIndex(to: Int) {
        self.stackIndex = to
    }
    
    func bringTabBarToFront() {
        setItemColor()
        view.addSubview(stackView)
        view.bringSubviewToFront(stackView)
    }
    
    func setItemColor() {
        dashBoardButton.setImage(#imageLiteral(resourceName: "dashboard"), for: .normal)
        feedButton.setImage(#imageLiteral(resourceName: "feed"), for: .normal)
        missionButton.setImage(#imageLiteral(resourceName: "mission"), for: .normal)
        dashBoardButton.tintColor = UIColor.contentImage
        feedButton.tintColor = UIColor.contentImage
        missionButton.tintColor = UIColor.contentImage
        dashBoardLabel.textColor = UIColor.contentText
        feedLabel.textColor = UIColor.contentText
        missionLabel.textColor = UIColor.contentText

        switch stackIndex {
        case 0:
            dashBoardButton.tintColor = UIColor.accentColor
            dashBoardLabel.textColor = UIColor.accentColor
        case 1:
            feedButton.tintColor = UIColor.accentColor
            feedLabel.textColor = UIColor.accentColor
        case 2:
            missionButton.tintColor = UIColor.accentColor
            missionLabel.textColor = UIColor.accentColor
        default:
            print("error")
        }
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
