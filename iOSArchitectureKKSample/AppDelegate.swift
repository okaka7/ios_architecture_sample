//
//  AppDelegate.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/06/10.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import UIKit
import SwiftyBeaver

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    private(set) var appCoordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // アプリウィンドウを設定します。
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        
        let appCoordinator = AppCoordinator(window: window)
        appCoordinator.start()
        self.appCoordinator = appCoordinator
        #if DEBUG
        log.debug("App Start!!!")
        #endif

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    private let isReceivedStateCorrect: (URLComponents) -> Bool = { components in
        guard let receivedState: String = components.queryItems?.getFirstQueryValue("state") as? String,
                let sentState: DribbbleState = LocalCache.shared[.dribbbleState] else {
            return false
        }
        
        return sentState == receivedState
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            return false
        }
        
        
        if components.path == R.string.localizable.dribbbleOauthCallBackPath()  {
            if isReceivedStateCorrect(components) {
                guard let code = components.queryItems?.getFirstQueryValue("code") as? String else {
                        return false
                }
                
                Repository.DribbbleOauth
                    .tokenRequest(code: code)
                    .subscribe(onSuccess: { token in log.debug("tokenGet\(token)")},
                               
                               onError: {error in log.error("tokenFail\(error)")})
                
            }
            LocalCache.shared[.dribbbleState] = nil
        }
        
        
        return true
    }
}
