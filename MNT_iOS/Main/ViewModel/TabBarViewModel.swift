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
    
    public lazy var viewControllers: [UIViewController] = {
        return [
            UIViewController(),
            feedVC,
            missionVC
        ]
    }()
    
    public lazy var input: InputType = Input()
    public lazy var output: OutputType = Output()
    
    struct Input {
        
    }
    
    struct Output {
        public let selectedIndexNumber = PublishRelay<Int>()
    }
    
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
        let mainScene = MissionScene.missionParticipant(viewModel)
        var target: UIViewController = UIViewController()
        let closer = { (vc: UIViewController) in
            target = vc
        }
        self.coordinator.transition(to: mainScene, using: .replace(closer), animated: true)
        return target.navigationController!
    }()
    
    func presentFeedAction(_ VC: TabBarViewController) -> CocoaAction {
        return CocoaAction { [weak self] action in
            self?.bindFeedAction()
            return Observable.just(action)
        }
    }
    
    func presentMissionAction(_ VC: TabBarViewController) -> CocoaAction {
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
}
