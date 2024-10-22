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
    var timer = Timer()
    
    //MARK:- ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addScrollObserver()
        
        if UserDefaults.standard.getIntValue(key: .isOver) != 1 {
            timer = Timer.scheduledTimer(timeInterval: 30,
                                         target: self,
                                         selector: #selector(updatetime),
                                         userInfo: nil,
                                         repeats: true)
        }
        
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
    
    // MARK: SetupLayout
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
    
    func setItemColor(_ selectedIndex: Int) {

        switch selectedIndex {
        case 0:
            dashBoardButton.tintColor = UIColor.accentColor
            dashBoardLabel.textColor = UIColor.accentColor
            feedButton.tintColor = UIColor.contentText
            feedLabel.textColor = UIColor.contentText
            missionButton.tintColor = UIColor.contentText
            missionLabel.textColor = UIColor.contentText
        case 1:
            dashBoardButton.tintColor = UIColor.contentText
            dashBoardLabel.textColor = UIColor.contentText
            feedButton.tintColor = UIColor.accentColor
            feedLabel.textColor = UIColor.accentColor
            missionButton.tintColor = UIColor.contentText
            missionLabel.textColor = UIColor.contentText
        case 2:
            dashBoardButton.tintColor = UIColor.contentText
            dashBoardLabel.textColor = UIColor.contentText
            feedButton.tintColor = UIColor.contentText
            feedLabel.textColor = UIColor.contentText
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
    
    @objc func updatetime() {
        let user: User? = UserDefaults.standard.getObject(key: .user)
        let room: Room? = UserDefaults.standard.getObject(key: .room)
        
        APISource.shared.getRoomCheck(userId: user!.id) { (roomCheck) in
            let roomNum: Int = roomCheck?.count ?? 0
            
            if roomNum > 0 {
                let index = roomNum - 1 // 마지막으로 참가한 방의 인덱스
                
                if roomCheck![index].room.isDone == 1 { // 방이 종료됨
                    self.timer.invalidate()
                    self.viewModel?.exitAction()
                }
            }
        }
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
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: {
            self.stackView.frame = CGRect(x: (width - 263)/2,
                                     y: height + 100,
                                     width: 263,
                                     height: 59)
        })
    }
    
    func showHeader() {
        let width = view.frame.width
        let height = view.frame.height

        UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
            self.stackView.frame = CGRect(x: (width - 263)/2,
                                     y: height - 93,
                                     width: 263,
                                     height: 59)
        })
    }
}

extension TabBarViewController: ViewModelBindableType {
    func bindViewModel(viewModel: TabBarViewModel) {
        feedButton.rx.action = viewModel.presentFeedAction()
        missionButton.rx.action = viewModel.presentMissionAction()
        dashBoardButton.rx.action = viewModel.presentDashboardAction()
        
        self.viewControllers = viewModel.viewControllers
        
        //  index 바뀔떄 마다 호출
        viewModel.output.selectedIndexNumber
            .subscribe(onNext: { [weak self] (selectedNumber) in
                guard let self = self else { return }
                self.selectedIndex = selectedNumber
                self.viewModel?.coordinator.changeCurrentVC(self.viewControllers![selectedNumber].sceneViewController)
                self.setItemColor(selectedNumber)
            }).disposed(by: bag)
    }
}
