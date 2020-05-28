//
//  AppDelegate.swift
//  MNT_iOS
//
//  Created by 최민섭 on 2020/01/04.
//  Copyright © 2020 최민섭. All rights reserved.
//

import UIKit
import CoreData
import RxAlamofire
import Alamofire

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    // MARK:- APP Lifecycle
    
    var loginViewController: UIViewController?
    var mainViewController: UIViewController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            
        // Override point for customization after application launch.
//        testing()
        
        let coordinator = SceneCoordinator(window: window!)
        var viewModel: ViewModel?
        var scene: SceneType?
        let user: User? = UserDefaults.standard.getObject(key: .user)
        
        if user == nil {
            kakaoLogin()
        } else {
            let room: Room? = UserDefaults.standard.getObject(key: .room)
            if room == nil {
                viewModel = MainViewModel(title: "", coordinator: coordinator)
                scene = MainScene.main(viewModel as! MainViewModel)
                coordinator.transition(to: scene!, using: .root, animated: true)
            } else {
                let userFruttoId: Int? = UserDefaults.standard.getIntValue(key: .userFruttoId)
                if userFruttoId == nil {
                    viewModel = ReadyViewModel(title: "", coordinator: coordinator)
                    scene = MainScene.ready(viewModel as! ReadyViewModel)
                    coordinator.transition(to: scene!, using: .root, animated: true)
                } else {
                    viewModel = TabBarViewModel(title: "Tabbar", coordinator: coordinator)
                    scene = MainScene.enterRoom(viewModel as! TabBarViewModel)
                    coordinator.transition(to: scene!, using: .root, animated: true)
                }
            }
        }
        
        return true
    }
    
    private func setNavigationbarAppearance() {
        if let navigationBar = UINavigationBar.appearance() as? UINavigationBar {
            navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationBar.shadowImage = UIImage()
            navigationBar.tintColor = .defaultText
            let inset = UIEdgeInsets(top: -16, left: -16, bottom: 0, right: 0)
            navigationBar.backIndicatorTransitionMaskImage = #imageLiteral(resourceName: "arrowLeft").withAlignmentRectInsets(inset)
        }
    }
    
    fileprivate func kakaoLogin() {
        if UserDefaults.standard.getStringValue(key: .socialLogin) == "Kakao" {
            guard let session = KOSession.shared() else { return }
            session.logoutAndClose { (success, error) in
              if success {
                print("logout success.")
              } else {
                print("logout fail")
              }
            }
        }
        
        addObserver() // 로그인,로그아웃 상태 변경 받기
        reloadRootViewController()
    }
    
    fileprivate func transMain() {
        let coordinator = SceneCoordinator(window: window!)
        let viewModel = MainViewModel(title: "", coordinator: coordinator)
        let scene: SceneType = MainScene.main(viewModel as! MainViewModel)
        coordinator.transition(to: scene, using: .root, animated: true)
    }
    
    fileprivate func testing() {
//        testingFeed()
//        testingMission()
        testingMain()
//        testingAdminExit()
//        testingParticipantExit()
//        testingReady()
    }
    
    fileprivate func testingReady() {
        let coordinator = SceneCoordinator(window: window!)
        let viewModel = ReadyViewModel(title: "", coordinator: coordinator)
        let scene: SceneType = MainScene.ready(viewModel)
        
        UserDefaults.standard.setObject(object: User(id: "2005162",
                                                     name: "string",
                                                     profilePic: "string",
                                                     fcmToken: "string"), key: .user)
        
        UserDefaults.standard.setObject(object: Room(endDay: "2020-05-12",
                                                     id: 48275,
                                                     isDone: 0,
                                                     isStart: 0,
                                                     maxPeople: 0,
                                                     name: "string",
                                                     startDay: "2020-05-12"),
                                        key: .room)
        
        coordinator.transition(to: scene, using: .root, animated: true)
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
        var viewModel: ViewModel?
        var scene: SceneType?
        
        if (isOpened) {
            KOSessionTask.userMeTask(completion: { (error, me) in
                if let error = error as NSError? {
                    print(error.description)
                } else if let me = me as KOUserMe? {
                    viewModel = AgreeViewModel(title: "이용약관", coordinator: coordinator)
                    scene = LoginScene.agree(viewModel as! AgreeViewModel)
                    UserDefaults.standard.setStringValue(value: "Kakao", key: .socialLogin)
                    coordinator.transition(to: scene!, using: .root, animated: true)
                } else {
                    print("has no id")
                }
            })
        } else {
            viewModel = LoginViewModel(title: "로그인", coordinator: coordinator)
            scene = LoginScene.login(viewModel as! LoginViewModel)
            coordinator.transition(to: scene!, using: .root, animated: true)
        }
    }
    
    @objc fileprivate func kakaoSessionDidChangeWithNotification() {
        reloadRootViewController()
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        if KOSession.handleOpen(url) {
            return true
        }
        
        // Called When Execute KaKaoLink
        if KLKTalkLinkCenter.shared().isTalkLinkCallback(url) {
            if UserDefaults.standard.getIntValue(key: .userFruttoId) == nil {
                let params = url.query
                let coordinator = SceneCoordinator(window: window!)
                let viewModel = MainViewModel(title: "", coordinator: coordinator)
                let scene: SceneType = MainScene.main(viewModel as! MainViewModel)

                viewModel.kakaoLinkParams = params
                coordinator.transition(to: scene, using: .root, animated: true)
                return true
            }
        }
        return false
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        if KOSession.handleOpen(url) {
            return true
        }
        
        // Called When Execute KaKaoLink
        if KLKTalkLinkCenter.shared().isTalkLinkCallback(url) {
            if UserDefaults.standard.getIntValue(key: .userFruttoId) == nil {
                let params = url.query
                let coordinator = SceneCoordinator(window: window!)
                let viewModel = MainViewModel(title: "", coordinator: coordinator)
                let scene: SceneType = MainScene.main(viewModel as! MainViewModel)

                viewModel.kakaoLinkParams = params
                coordinator.transition(to: scene, using: .root, animated: true)
                return true
            }
        }
        return false
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        KOSession.handleDidEnterBackground()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        KOSession.handleDidBecomeActive()
    }
}
