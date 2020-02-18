//
//  AppDelegate.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/01/04.
//  Copyright © 2020 최민섭. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    // MARK:- APP Lifecycle
    
    var loginViewController: UIViewController?
    var mainViewController: UIViewController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        kakaoLogin() // 로그인,로그아웃 상태 받기
        testing()
        return true
    }
    
    fileprivate func kakaoLogin() {
        guard  let session = KOSession.shared() else {
            return
        }
        
        if session.token?.accessToken != nil {
            let coordinator = SceneCoordinator(window: window!)
            let viewModel = MainViewModel(title: "메인", coordinator: coordinator)
            let scene: SceneType = MainScene.main(viewModel as! MainViewModel)
            coordinator.transition(to: scene, using: .root, animated: true)
        } else {
            addObserver() // 로그인,로그아웃 상태 변경 받기
            reloadRootViewController()
        }
    }
    
    fileprivate func testing() {
//        testingFeed()
//        testingMission()
        testingMain()
    }
    
    fileprivate func testingMission() {
        let coordinator = SceneCoordinator(window: window!)
        let viewModel = MissionViewModel(title: "미션", coordinator: coordinator)
        let scene: SceneType = MissionScene.missionParticipant(viewModel)
//        let scene: SceneType = MissionScene.missionAdministrator(viewModel)
        coordinator.transition(to: scene, using: .root, animated: true)
    }
    
    fileprivate func testingFeed() {
        let coordinator = SceneCoordinator(window: window!)
        let viewModel = FeedViewModel(title: "피드", coordinator: coordinator)
        let scene: SceneType = FeedScene.feed(viewModel)
        coordinator.transition(to: scene, using: .root, animated: true)
    }
    
    fileprivate func testingMain() {
        let coordinator = SceneCoordinator(window: window!)
        let viewModel = TabBarViewModel(title: "Tabbar", coordinator: coordinator)
        let scene: SceneType = MainScene.enterRoom(viewModel)
        coordinator.transition(to: scene, using: .root, animated: true)
    }
    
    fileprivate func addObserver() {
        NotificationCenter
            .default
            .addObserver(self,
                         selector: #selector(AppDelegate.kakaoSessionDidChangeWithNotification),
                         name: NSNotification.Name.KOSessionDidChange,
                         object: nil)
    }
    
    fileprivate func reloadRootViewController() {
        guard let isOpened = KOSession.shared()?.isOpen() else { return }
        
        let coordinator = SceneCoordinator(window: window!)
        let viewModel = isOpened ? ConfirmViewModel(title: "확인", coordinator: coordinator) : LoginViewModel(title: "로그인", coordinator: coordinator)
        let scene: SceneType = isOpened ? LoginScene.confirm(viewModel as! ConfirmViewModel) : LoginScene.login(viewModel as! LoginViewModel)
//
//        coordinator.transition(to: scene, using: .root, animated: true)
    }
    
    @objc fileprivate func kakaoSessionDidChangeWithNotification() {
        reloadRootViewController()
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        if KOSession.handleOpen(url) {
            return true
        }
        return false
        
//        if KLKTalkLinkCenter.shared().isTalkLinkCallback(url) {
//            let params = url.query
//            UIAlertController.showMessage("카카오링크 메시지 액션\n\(params ?? "파라미터 없음")")
//            return true
//        }
        return false
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        if KOSession.handleOpen(url) {
            return true
        }
        return false
//        if KLKTalkLinkCenter.shared().isTalkLinkCallback(url) {
//            let params = url.query
//            UIAlertController.showMessage("카카오링크 메시지 액션\n\(params ?? "파라미터 없음")")
//            return true
//        }
        return false
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        KOSession.handleDidEnterBackground()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        KOSession.handleDidBecomeActive()
    }
}

