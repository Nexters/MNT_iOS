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
        // 로그인,로그아웃 상태 변경 받기
        setupEntryControllers()

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(AppDelegate.kakaoSessionDidChangeWithNotification),
                                               name: NSNotification.Name.KOSessionDidChange,
                                               object: nil)
        reloadRootViewController()
        
        return true
    }
    
    fileprivate func setupEntryControllers() {        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let navigationController = storyboard.instantiateViewController(withIdentifier: "navigator") as! UINavigationController
        let navigationController2 = storyboard.instantiateViewController(withIdentifier: "navigator") as! UINavigationController
        
        let viewController = storyboard.instantiateViewController(withIdentifier: "login") as UIViewController
        navigationController.pushViewController(viewController, animated: true)
        self.loginViewController = navigationController
        
        let viewController2 = storyboard.instantiateViewController(withIdentifier: "main") as UIViewController
        navigationController2.pushViewController(viewController2, animated: true)
        self.mainViewController = navigationController2
    }
    
    fileprivate func reloadRootViewController() {
        guard let isOpened = KOSession.shared()?.isOpen() else { return }
        
        if !isOpened {
            let mainViewController = self.mainViewController as! UINavigationController
            mainViewController.popToRootViewController(animated: true)
        }
        
        self.window?.rootViewController = isOpened ? self.mainViewController : self.loginViewController
        self.window?.makeKeyAndVisible()
    }
    
    @objc fileprivate func kakaoSessionDidChangeWithNotification() {
        reloadRootViewController()
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        if KOSession.handleOpen(url) {
            return true
        }
        return false
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        if KOSession.handleOpen(url) {
            return true
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

