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
        print("fcmToken is \(fcmToken)")
        
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
//        var viewModel: ViewModel?
//        var scene: SceneType?
        let user: User? = UserDefaults.standard.getObject(key: .user)
        
        if user == nil {
            kakaoLogin()
        } else {
            let room: Room? = UserDefaults.standard.getObject(key: .room)
            if room == nil {
                let viewModel = MainViewModel(title: "", coordinator: coordinator)
                let scene = MainScene.main(viewModel as! MainViewModel)
                coordinator.transition(to: scene, using: .root, animated: true)
            } else {
                let isEntered: Int? = UserDefaults.standard.getIntValue(key: .isEntered)
                if isEntered == nil || isEntered == 0 {
                    let viewModel = ReadyViewModel(title: "", coordinator: coordinator)
                    let scene = MainScene.ready(viewModel as! ReadyViewModel)
                    coordinator.transition(to: scene, using: .root, animated: true)
                } else {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    let endDate = dateFormatter.date(from: room!.endDay)!
                    let expirationDate = Date(timeInterval: 75600, since: endDate)
                    let today = Date(timeInterval: 32400, since: Date())
                    let interval = expirationDate.timeIntervalSince(today)
                    
                    if interval < 0 {
                        let coordinator = SceneCoordinator(window: window!)
                        let viewModel = AlertExitViewModel(title: "프루또 종료", coordinator: coordinator)
                        let scene: SceneType = ExitScene.alertExit(viewModel)
                        coordinator.transition(to: scene, using: .root, animated: true)
                    } else {
                        let viewModel = TabBarViewModel(title: "Tabbar", coordinator: coordinator)
                        let scene = MainScene.enterRoom(viewModel as! TabBarViewModel)
                        coordinator.transition(to: scene, using: .root, animated: true)
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
                        if (roomCheck != nil) {
                            var user = roomCheck![0].user
                            user.fcmToken = UserDefaults.standard.getStringValue(key: .fcmToken) ?? "string"
                            
                            UserDefaults.standard.setObject(object: user, key: .user)
                            UserDefaults.standard.setObject(object: roomCheck![0].room, key: .room)
                            
                            APISource.shared.postSignUp(user: user) {
                                UserDefaults.standard.setObject(object: user, key: .user)
                            }
                            
                            if (roomCheck![0].userFruttoId != nil) {
                                let isEntered: Int? = UserDefaults.standard.getIntValue(key: .isEntered)
                                if isEntered == nil {
                                    let viewModel = ReadyViewModel(title: "", coordinator: coordinator)
                                    let scene = MainScene.ready(viewModel as! ReadyViewModel)
                                    coordinator.transition(to: scene, using: .root, animated: true)
                                } else {
                                    let viewModel = TabBarViewModel(title: "Tabbar", coordinator: coordinator)
                                    let scene = MainScene.enterRoom(viewModel as! TabBarViewModel)
                                    if let user : User = UserDefaults.standard.getObject(key: .user) {
                                        APISource.shared.getRoomCheck(userId: user.id) { (roomCheck) in
                                            UserDefaults.standard.setObject(object: roomCheck![0].manitto, key: .manitto)
                                            UserDefaults.standard.setIntValue(value: roomCheck![0].userFruttoId!, key: .userFruttoId)
                                        }
                                    }
                                    coordinator.transition(to: scene, using: .root, animated: true)
                                }
                            } else {
                                let viewModel = ReadyViewModel(title: "", coordinator: coordinator)
                                let scene: SceneType = MainScene.ready(viewModel)
                                coordinator.transition(to: scene, using: .root, animated: true)
                            }
                        } else {
                            let viewModel = AgreeViewModel(title: "이용약관", coordinator: coordinator)
                            let scene: SceneType = LoginScene.agree(viewModel as! AgreeViewModel)
                            UserDefaults.standard.setStringValue(value: "Kakao", key: .socialLogin)
                            coordinator.transition(to: scene, using: .root, animated: true)
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
                //                let params = url.query
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
        
//        let urlComponents = NSURLComponents(string: url)
//        let queryItems = urlComponents?.queryItems
//        let param = queryItems?.filter({$0.name == "param1"}).first
//
//        let value = param?.value ?? ""
//
//        return value
        
        // Called When Execute KaKaoLink
        if KLKTalkLinkCenter.shared().isTalkLinkCallback(url) {
            let room : Room? = UserDefaults.standard.getObject(key: .room)
            if room == nil {
//                let params = url.query
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
