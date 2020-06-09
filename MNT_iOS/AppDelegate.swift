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
import Firebase
import FirebaseMessaging
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {
    
    var window: UIWindow?
    
    // MARK:- APP Lifecycle
    
    var loginViewController: UIViewController?
    var mainViewController: UIViewController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        UNUserNotificationCenter.current().delegate = self
        Messaging.messaging().delegate = self
        
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter
            .current()
            .requestAuthorization(
                options: authOptions,
                completionHandler: { (_, _) in }
        )
        
        application.registerForRemoteNotifications()
        
        // Override point for customization after application launch.
        //        testing()
        
        login()
//        testingMNTRoomWith(member: .bestchoi)
        
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        var user: User? = UserDefaults.standard.getObject(key: .user)
        
        if user != nil {
            let editedUser: User = User(id: user!.id,
                                        name: user!.name,
                                        profilePic: "string",
                                        fcmToken: fcmToken)
            
            APISource.shared.postSignUp(user: editedUser) {
                UserDefaults.standard.setObject(object: user, key: .user)
            }
        }
        
        UserDefaults.standard.setStringValue(value: fcmToken, key: .fcmToken)
        
        let dataDict:[String: String] = ["token": fcmToken]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
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
    
    private func login() {
        let coordinator = SceneCoordinator(window: window!)
        let user: User? = UserDefaults.standard.getObject(key: .user)
        
        if user == nil {
            kakaoLogin()
        } else {
            let room: Room? = UserDefaults.standard.getObject(key: .room)
            if room == nil { // 방이 없음
                let viewModel = MainViewModel(title: "", coordinator: coordinator)
                let scene = MainScene.main(viewModel as! MainViewModel)
                coordinator.transition(to: scene, using: .root, animated: true)
            } else {
                let isEntered: Int? = UserDefaults.standard.getIntValue(key: .isEntered)
                if isEntered == nil || isEntered == 0 { // 방이 있으나 안 들어감
                    let viewModel = ReadyViewModel(title: "", coordinator: coordinator)
                    let scene = MainScene.ready(viewModel as! ReadyViewModel)
                    coordinator.transition(to: scene, using: .root, animated: true)
                } else { // 방이 있고 들어감
                    APISource.shared.getRoomCheck(userId: user!.id) { (roomCheck) in
                        let roomNum = roomCheck?.count ?? 0
                        
                        if roomNum > 0 {
                            let index = roomNum - 1 // 마지막으로 참가한 방의 인덱스
                            
                            if roomCheck![index].room.isDone == 1 { // 방이 종료됨
                                UserDefaults.standard.setIntValue(value: 1, key: .isOver)
                                let coordinator = SceneCoordinator(window: self.window!)
                                let viewModel = AlertExitViewModel(title: "프루또 종료", coordinator: coordinator)
                                let scene: SceneType = ExitScene.alertExit(viewModel)
                                coordinator.transition(to: scene, using: .root, animated: true)
                            } else { // 방이 종료되지 않음
                                UserDefaults.standard.setIntValue(value: 1, key: .isEntered)
                                let viewModel = TabBarViewModel(title: "Tabbar", coordinator: coordinator)
                                let scene = MainScene.enterRoom(viewModel as! TabBarViewModel)
                                coordinator.transition(to: scene, using: .root, animated: true)
                            }
                        }
                    }
                }
            }
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
    
    
    enum MNTMember {
        case bestchoi
    }
    
    fileprivate func testingMNTRoomWith(member: MNTMember) {
        switch member {
        case .bestchoi:
            let userId = "Bestchoi"
            APISource.shared.getRoomCheck(userId: userId) { [weak self] (rooms) in
                for room in rooms ?? [] {
                    
                    UserDefaults.standard.setObject(object: room.room, key: .room)
                    UserDefaults.standard.setObject(object: room.manitto, key: .manitto)
                    UserDefaults.standard.setObject(object: room.user, key: .user)
                    UserDefaults.standard.setIntValue(value: room.userFruttoId!, key: .userFruttoId)
                    
                    self?.testingMain()
                }
            }
        default:
            break
        }
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
        
        if (isOpened) {
            KOSessionTask.userMeTask(completion: { (error, me) in
                if let error = error as NSError? {
                    print(error.description)
                } else if let me = me as KOUserMe? {
                    APISource.shared.getRoomCheck(userId: me.id!) { (roomCheck) in
                        let roomNum: Int = roomCheck?.count ?? 0
                        
                        if roomNum == 0 { // 참가한 방이 하나도 없음
                            let viewModel = AgreeViewModel(title: "이용약관", coordinator: coordinator)
                            let scene: SceneType = LoginScene.agree(viewModel as! AgreeViewModel)
                            UserDefaults.standard.setStringValue(value: "Kakao", key: .socialLogin)
                            coordinator.transition(to: scene, using: .root, animated: true)
                        } else {
                            let index = roomNum - 1 // 마지막으로 참가한 방의 인덱스
                            UserDefaults.standard.setObject(object: roomCheck![index].user, key: .user)
                            
                            if roomCheck![index].room.isDone == 1 { // 방이 종료됨
                                let viewModel = AgreeViewModel(title: "이용약관", coordinator: coordinator)
                                let scene: SceneType = LoginScene.agree(viewModel as! AgreeViewModel)
                                UserDefaults.standard.setStringValue(value: "Kakao", key: .socialLogin)
                                coordinator.transition(to: scene, using: .root, animated: true)
                            } else {
                                UserDefaults.standard.setObject(object: roomCheck![index].room, key: .room)
                                
                                if roomCheck![index].room.isStart == 1 { // 방이 시작됨
                                    UserDefaults.standard.setObject(object: roomCheck![index].manitto, key: .manitto)
                                    UserDefaults.standard.setIntValue(value: roomCheck![index].userFruttoId!, key: .userFruttoId)
                                    UserDefaults.standard.setIntValue(value: 1, key: .isEntered)
                                    let viewModel = TabBarViewModel(title: "Tabbar", coordinator: coordinator)
                                    let scene = MainScene.enterRoom(viewModel as! TabBarViewModel)
                                    coordinator.transition(to: scene, using: .root, animated: true)
                                } else { // 방이 시작되지 않음
                                    let viewModel = ReadyViewModel(title: "", coordinator: coordinator)
                                    let scene: SceneType = MainScene.ready(viewModel)
                                    coordinator.transition(to: scene, using: .root, animated: true)
                                }
                            }
                        }
                    }
                } else {
                    print("has no id")
                }
            })
        } else {
            let viewModel = LoginViewModel(title: "로그인", coordinator: coordinator)
            let scene = LoginScene.login(viewModel as! LoginViewModel)
            coordinator.transition(to: scene, using: .root, animated: true)
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
            let room : Room? = UserDefaults.standard.getObject(key: .room)
            if room == nil {
                let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
                let queryItems = urlComponents?.queryItems
                let param = queryItems?.filter({$0.name == "roomnum"}).first
                let value = param?.value ?? ""
                
                let coordinator = SceneCoordinator(window: window!)
                let mainViewModel = MainViewModel(title: "", coordinator: coordinator)
                let mainScene: SceneType = MainScene.main(mainViewModel as! MainViewModel)
                
                coordinator.transition(to: mainScene, using: .root, animated: true)
                
                let joinViewModel = JoinRoomViewModel(title: "", coordinator: coordinator)
                let joinScene = MainScene.joinRoom(joinViewModel)
                joinViewModel.kakaoLinkParams = value
                coordinator.transition(to: joinScene, using: .push, animated: true).asObservable().map { _ in }
                
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
            let room : Room? = UserDefaults.standard.getObject(key: .room)
            if room == nil {
                let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
                let queryItems = urlComponents?.queryItems
                let param = queryItems?.filter({$0.name == "roomnum"}).first
                let value = param?.value ?? ""
                
                let coordinator = SceneCoordinator(window: window!)
                let mainViewModel = MainViewModel(title: "", coordinator: coordinator)
                let mainScene: SceneType = MainScene.main(mainViewModel as! MainViewModel)
                
                coordinator.transition(to: mainScene, using: .root, animated: true)
                
                let joinViewModel = JoinRoomViewModel(title: "", coordinator: coordinator)
                let joinScene = MainScene.joinRoom(joinViewModel)
                joinViewModel.kakaoLinkParams = value
                coordinator.transition(to: joinScene, using: .push, animated: true).asObservable().map { _ in }

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
