//
//  AppDelegate.swift
//  AvanadeAIProject
//
//  Created by Xinyuan Wang on 1/6/18.
//  Copyright © 2018 Avanade. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import GoogleSignIn
import FBSDKCoreKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    
    public static let GoogleLoginNotificationName = "GoogleLogin"
    
    var window: UIWindow?
    
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.sharedManager().enabledDistanceHandlingClasses = [LoginViewController.self,RegisterViewController.self]
        IQKeyboardManager.sharedManager().disabledToolbarClasses = [AddCommentViewController.self]
        UIApplication.shared.isStatusBarHidden = false
        GIDSignIn.sharedInstance().clientID = "1042251977990-iijl7cblb4j8s6nsru7c3q1s9h8n29pd.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().delegate = self
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        print(url.absoluteString)
        if url.absoluteString.range(of: "google") != nil {
            return GIDSignIn.sharedInstance().handle(url as URL?, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
        }
        else {
            return FBSDKApplicationDelegate.sharedInstance().application(app, open: url, options: options)
        }
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

    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print("\(error.localizedDescription)")
        }
        else {
            let myUser = User(email: user.profile.email, fName: user.profile.givenName, lName: user.profile.familyName, title: nil, company: nil)
            myUser.googleToken = user.authentication.idToken
            let userDataDict: [String: User] = ["user": myUser]
            NotificationCenter.default.post(name: Notification.Name(rawValue: AppDelegate.GoogleLoginNotificationName), object: nil, userInfo: userDataDict)
        }
    }

}

