//
//  TabBarViewModel.swift
//  MNT_iOS
//
//  Created by Jihye on 2020/02/10.
//  Copyright © 2020 최민섭. All rights reserved.
//

import Foundation
import RxCocoa
import Action
import RxSwift

class TabBarViewModel: ViewModel {
    func presentFeedAction(_ VC: TabBarViewController, _ stackIndex: Int) -> CocoaAction {
        return CocoaAction { action in
            if stackIndex != 1 {
                self.bindFeedAction(VC)
            }
            return Observable.just(action)
        }
    }
    
    func presentMissionAction(_ VC: TabBarViewController, _ stackIndex: Int) -> CocoaAction {
        return CocoaAction { action in
            if stackIndex != 2 {
                self.bindMissionAction(VC)
            }
            return Observable.just(action)
        }
    }
    
    func bindFeedAction(_ VC: TabBarViewController) {
        let viewModel = FeedViewModel(title: "피드", coordinator: self.coordinator)
        let FeedVC = FeedScene.feed(viewModel).instantiate()
        
        //let previousStackIndex = VC.stackIndex
        //removePreviousVC(previousStackIndex)
        
        VC.changeIndex(to: 1)
        VC.view.addSubview(FeedVC.view)
        setStackViewAction(VC)
        
//        VC.printIndex()
    }
    
    func bindMissionAction(_ VC: TabBarViewController) {
        let viewModel = MissionViewModel(title: "미션", coordinator: self.coordinator)
        let MissionVC = MissionScene.missionParticipant(viewModel).instantiate()
        
        //let previousStackIndex = VC.stackIndex
        //removePreviousVC(previousStackIndex)
        
        VC.changeIndex(to: 2)
        VC.view.addSubview(MissionVC.view)
        setStackViewAction(VC)
        
//        VC.printIndex()
    }
    
    func setStackViewAction(_ VC: TabBarViewController) {
        VC.stackView.hstack(VC.dashBoardButton.withHeight(50),
                            VC.feedButton.withHeight(50),
                            VC.missionButton.withHeight(50),
                            alignment: .center,
                            distribution: .fillEqually)
                    .withMargins(.init(top: 0,
                                       left: 0,
                                       bottom: 0,
                                       right: 0))
        
        VC.stackView.frame = CGRect(x: VC.view.frame.width/10,
                                    y: VC.view.frame.height/10 * 9,
                                    width: VC.view.frame.width/10 * 8,
                                    height: 50)
        
        VC.view.addSubview(VC.stackView)
        VC.view.bringSubviewToFront(VC.stackView)
    }
    
    func removePreviousVC(_ previousStackIndex: Int) {
        switch previousStackIndex {
//        case 0:
        case 1:
            FeedViewController().removeFromParent()
        case 2:
            MissionParticipantViewController().removeFromParent()
        default:
            print("이전 페이지 없음")
        }
    }
}
