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

protocol ReactiveViewModelable {
    associatedtype InputType
    associatedtype OutputType
    
    var input: InputType { get set }
    var output: OutputType { get }
}

class TabBarViewModel: ViewModel, ReactiveViewModelable {
    typealias InputType = Input
    typealias OutputType = Output
    
    public lazy var input: InputType = Input()
    public lazy var output: OutputType = Output()
    
    struct Input {
        
    }
    
    struct Output {
        public let selectedIndexNumber = PublishRelay<Int>()
    }
    
    // MARK: ViewControllers
    
    public lazy var viewControllers: [UIViewController] = {
        return [
            dashVC, 
            feedVC,
            missionVC
        ]
    }()
    
    fileprivate lazy var dashVC: UINavigationController = {
        let viewModel = DashboardViewModel(title: "대시보드", coordinator: self.coordinator)
        let dashScene = DashboardScene.dashBoard(viewModel)
        var target: UIViewController = UIViewController()
        let closer = { (vc: UIViewController) in
            target = vc
        }
        self.coordinator.transition(to: dashScene, using: .replace(closer), animated: true)
        return target.navigationController!
    }()
    
    fileprivate lazy var feedVC: UINavigationController = {
        let viewModel = FeedViewModel(title: "피드", coordinator: self.coordinator)
        let feedScene = FeedScene.feed(viewModel)
        var target: UIViewController = UIViewController()
        let closer = { (vc: UIViewController) in
            target = vc
        }
        self.coordinator.transition(to: feedScene, using: .replace(closer), animated: true)
        return target.navigationController!
    }()
    
    fileprivate lazy var missionVC: UIViewController = {
        let viewModel = MissionViewModel(title: "미션", coordinator: self.coordinator)
        //let missionScene = MissionScene.missionAdministrator(viewModel)
        let missionScene = MissionScene.missionParticipant(viewModel)
        var target: UIViewController = UIViewController()
        let closer = { (vc: UIViewController) in
            target = vc
        }
        self.coordinator.transition(to: missionScene, using: .replace(closer), animated: true)
        return target.navigationController!
    }()
    
    func presentDashboardAction() -> CocoaAction {
        return CocoaAction { [weak self] action in
            self?.bindDashboardAction()
            return Observable.just(action)
        }
    }
    
    func presentFeedAction() -> CocoaAction {
        return CocoaAction { [weak self] action in
            self?.bindFeedAction()
            return Observable.just(action)
        }
    }
    
    func presentMissionAction() -> CocoaAction {
        return CocoaAction { [weak self] action in
            self?.bindMissionAction()
            return Observable.just(action)
        }
    }
    
    func bindDashboardAction() {
        output.selectedIndexNumber.accept(0)
    }
    
    func bindFeedAction() {
        output.selectedIndexNumber.accept(1)
    }
    
    func bindMissionAction() {
        output.selectedIndexNumber.accept(2)
    }
    
    func exitAction() {
        let viewModel = AlertExitViewModel(title: "프루또 종료", coordinator: self.coordinator)
        let scene: SceneType = ExitScene.alertExit(viewModel)
        coordinator.transition(to: scene, using: .root, animated: true)
    }
}
