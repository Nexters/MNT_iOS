//
//  TabBarViewController.swift
//  MNT_iOS
//
//  Created by Jihye on 2020/02/10.
//  Copyright © 2020 최민섭. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class TabBarViewController: UITabBarController {
    var viewModel: TabBarViewModel?
    
    override var selectedIndex: Int {
        didSet {
            print("tagg selectedIndex: \(selectedIndex)")
        }
    }
    private let bag = DisposeBag()
    
    var dashBoardButton = UIButton(image: #imageLiteral(resourceName: "iconNaviDashboard"), tintColor: .contentImage)
    var feedButton = UIButton(image: #imageLiteral(resourceName: "iconNaviFeed"), tintColor: .contentImage)
    var missionButton = UIButton(image: #imageLiteral(resourceName: "iconNaviMission"), tintColor: .contentImage)
    var dashBoardLabel = UILabel(text: "대시보드",
                                 font: .boldSystemFont(ofSize: 10),
                                 textColor: .contentText,
                                 textAlignment: .center,
                                 numberOfLines: 0)
    var feedLabel = UILabel(text: "피드",
                            font: .boldSystemFont(ofSize: 10),
                            textColor: .contentText,
                            textAlignment: .center,
                            numberOfLines: 0)
    var missionLabel = UILabel(text: "미션",
                               font: .boldSystemFont(ofSize: 10),
                               textColor: .contentText,
                               textAlignment: .center,
                               numberOfLines: 0)
    var dashBoardST = UIButton(title: "", titleColor: .black)
    var feedST = UIButton(title: "", titleColor: .black)
    var missionST = UIButton(title: "", titleColor: .black)
    var stackView = UIView()
    var stackIndex: Int? // 0: 대시보드, 1: 피드, 2: 미션
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addScrollObserver()
        
        tabBar.isHidden = true
        // init page to FeedViewController
            
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            self.navigationController?.isNavigationBarHidden = true
            viewModel?.bindFeedAction()
    }

    override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            self.navigationController?.isNavigationBarHidden = false
    }
    
    func setupLayout() {
        let width = view.frame.width
        let height = view.frame.height

        stackView.frame = CGRect(x: (width - 263)/2,
                                 y: height - 93,
                                 width: 263,
                                 height: 59)

        dashBoardST.stack(dashBoardButton, dashBoardLabel)
        feedST.stack(feedButton, feedLabel)
        missionST.stack(missionButton, missionLabel)
        stackView.hstack(dashBoardST, feedST, missionST)

        dashBoardST.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 10).isActive = true
        dashBoardST.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: -10).isActive = true
        dashBoardST.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: width * 0.082).isActive = true
        feedST.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 10).isActive = true
        feedST.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: -10).isActive = true
        missionST.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 10).isActive = true
        missionST.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: -10).isActive = true
        missionST.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: width * 0.467).isActive = true
        missionST.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -(width * 0.104)).isActive = true

        view.addSubview(stackView)
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
    
    func addScrollObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(animateTabBar(_:)),
                                               name: NSNotification.Name("ScrollAction"),
                                               object: nil)
    }
    
    @objc func animateTabBar(_ notification: Notification) {
        guard let tabBarAction: String = notification.userInfo?["TabBarAction"] as? String else { return }
        
        if (tabBarAction == "HIDE") {
            hideHeader()
        } else {
            showHeader()
        }
    }
    
    func hideHeader() {
        let width = view.frame.width
        let height = view.frame.height
        
        UIView.animate(withDuration: 3.0, delay: 0, options: .curveLinear, animations: {
            self.stackView.frame = CGRect(x: (width - 263)/2,
                                     y: height + 100,
                                     width: 263,
                                     height: 59)
        })
    }
    
    func showHeader() {
        let width = view.frame.width
        let height = view.frame.height

        UIView.animate(withDuration: 1.0, delay: 0, options: .curveLinear, animations: {
            self.stackView.frame = CGRect(x: (width - 263)/2,
                                     y: height - 93,
                                     width: 263,
                                     height: 59)
        })
    }
}

extension TabBarViewController: ViewModelBindableType {
    func bindViewModel(viewModel: TabBarViewModel) {
        feedButton.rx.action = viewModel.presentFeedAction(self)
        missionButton.rx.action = viewModel.presentMissionAction(self)
        
        self.viewControllers = viewModel.viewControllers
        
        //  index 바뀔떄 마다 호출
        viewModel.output.selectedIndexNumber
            .subscribe(onNext: { [weak self] (selectedNumber) in
                guard let self = self else { return }
                self.selectedIndex = selectedNumber
                self.viewModel?.coordinator.changeCurrentVC(self.viewControllers![selectedNumber].sceneViewController)
            }).disposed(by: bag)
    }
}
