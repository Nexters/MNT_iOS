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
        kakaoLogin() // 로그인,로그아웃 상태 받기
//        testing()
        return true
    }
    
    fileprivate func kakaoLogin() {
        guard  let session = KOSession.shared() else {
            return
        }
        
        if session.token?.accessToken != nil {
            transReady()
        } else {
            addObserver() // 로그인,로그아웃 상태 변경 받기
            reloadRootViewController()
        }
    }
    
    fileprivate func transMain() {
        let coordinator = SceneCoordinator(window: window!)
        let viewModel = MainViewModel(title: "", coordinator: coordinator)
        let scene: SceneType = MainScene.main(viewModel as! MainViewModel)
        coordinator.transition(to: scene, using: .root, animated: true)
    }
    
    fileprivate func transReady() {
        let coordinator = SceneCoordinator(window: window!)
        let viewModel = ReadyViewModel(title: "", coordinator: coordinator)
        let scene: SceneType = MainScene.ready(viewModel as! ReadyViewModel)
        coordinator.transition(to: scene, using: .root, animated: true)

    }
    
    fileprivate func testing() {
//        testingFeed()
//        testingMission()
//        testingMain()
//        testingAdminExit()
//        testingParticipantExit()
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
        print("tagg appledelaget after coordinator")
        let viewModel = TabBarViewModel(title: "Tabbar", coordinator: coordinator)
        print("tagg appledelaget after viewmodel")
        let scene: SceneType = MainScene.enterRoom(viewModel)
        print("tagg appledelaget after enterRoom")
        coordinator.transition(to: scene, using: .root, animated: true)
    }
    
    fileprivate func testingAdminExit() {
        let coordinator = SceneCoordinator(window: window!)
        let viewModel = AlertExitOrNotViewModel(title: "푸르또 종료", coordinator: coordinator)
        let scene: SceneType = ExitScene.alertExitOrNot(viewModel)
        coordinator.transition(to: scene, using: .root, animated: true)
    }
    
    fileprivate func testingParticipantExit() {
        let coordinator = SceneCoordinator(window: window!)
        let viewModel = AlertExitViewModel(title: "푸르또 종료", coordinator: coordinator)
        let scene: SceneType = ExitScene.alertExit(viewModel)
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

        coordinator.transition(to: scene, using: .root, animated: true)
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

