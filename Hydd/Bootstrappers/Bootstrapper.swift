//
//  Bootstrapper.swift
//  Hydd
//
//  Created by Syed Kashan on 31/12/2019.
//  Copyright © 2019 Syed Kashan. All rights reserved.
//

import UIKit
import Foundation

struct Bootstrapper {
    
    var window: UIWindow
    static var instance: Bootstrapper?
    
    static func initialize(_ launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) {
        instance = Bootstrapper(window: makeNewWindow())
        Bootstrapper.setupTheLanguage()
        UserDefaults.standard.set(true, forKey: "INITIALIZE")
        instance!.bootstrap()
    }
    
    private static func makeNewWindow() -> UIWindow {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.backgroundColor = .white
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.window = window
        }
        return window
    }
    
    static func setupTheLanguage() {
        instance!.setupTheLanguage()
    }
    private func setupTheLanguage() {
        UserDefaults.set(selectedLanguage: AppLanguage.currentAppleLanguage() ?? "en")
        if let languageCode = AppLanguage.currentAppleLanguage() {
            AppLanguage.set(selectedLanguage: languageCode)
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }
    }
    mutating func bootstrap() {
        //Decision point to show Onboarding, Login, Home.
        showSetupView()
        window.makeKeyAndVisible()
    }
    
    static func showLogin() {
        guard let instance = instance else { fatalError("Instance is not initialized") }
        instance.showSetupView()
    }
    
    private init(window: UIWindow) {
        self.window = window
    }
    
    // MARK: - LOGOUT
    static func logout() {
        HUM.shared.SetUserLogedOUT()
        showLogin()
    }
    
    static func showProfile() {
        guard let instance = instance else { fatalError("Instance is not initialized") }
        instance.gotoProfile()
    }
    private func gotoProfile() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            let contoller = MyProfileRouter.createModule()
            let nav = UINavigationController(rootViewController: contoller)
            nav.modalPresentationStyle = .overFullScreen
            nav.modalTransitionStyle = .crossDissolve
            UIViewController.top().present(nav, animated: true, completion: nil)
        })
    }
    
    static func gotoInProgessJobs() {
        guard let instance = instance else { fatalError("Instance is not initialized") }
        instance.gotoProgressJobList()
    }
    private func gotoProgressJobList() {
        let contoller = MyJobsRouter.createModule()
        let nav = UINavigationController(rootViewController: contoller)
        self.window.rootViewController = nav
        UIView.transition(with: window, duration: 0.8, options: [.transitionCrossDissolve], animations: nil, completion: nil)
    }
    
    static func gotoEarnings() {
        guard let instance = instance else { fatalError("Instance is not initialized") }
        instance.gotoEarningList()
    }
    private func gotoEarningList() {
        let contoller = MyEarningsRouter.createModule()
        let nav = UINavigationController(rootViewController: contoller)
        self.window.rootViewController = nav
        UIView.transition(with: window, duration: 0.8, options: [.transitionCrossDissolve], animations: nil, completion: nil)
    }
    
    static func gotoJobList() {
        guard let instance = instance else { fatalError("Instance is not initialized") }
        instance.showJobList()
    }
    private func showJobList() {
        let contoller = JobListingRouter.createModule()
        let nav = UINavigationController(rootViewController: contoller)
        self.window.rootViewController = nav
        UIView.transition(with: window, duration: 0.8, options: [.transitionCrossDissolve], animations: nil, completion: nil)
    }
    
    private func showSetupView() {
        let controller = SplashRouter.createModule()
        self.window.rootViewController = controller
        UIView.transition(with: window, duration: 0.8, options: [.transitionCrossDissolve], animations: nil, completion: nil)
    }
    
    static func makeUserFlow() {
        guard let instance = instance else { fatalError("Instance is not initialized") }
        instance.showUserFlow()
    }
    private func showUserFlow() {
        if UserDefaults.standard.isUserLogedIn ?? false {
            Bootstrapper.showTabbar(selectedIndex: 0)
        } else {
            let controller = SigninRouter.createModule()
            let nav = UINavigationController(rootViewController: controller)
            self.window.rootViewController = nav
            UIView.transition(with: window, duration: 0.8, options: [.transitionCrossDissolve], animations: nil, completion: nil)
        }
    }
    
    static func showMissionDetail(data: CarSummaryModel) {
        guard let instance = instance else { fatalError("Instance is not initialized") }
        instance.missionDetail(data: data)
    }
    private func missionDetail(data: CarSummaryModel) {
        DispatchQueue.main.async {
            if let tabbar = UIViewController.top() as? HyddTabbarVC {
                (tabbar.selectedIndex != 0) ? (tabbar.selectedIndex = 0) : ()
                if let selectedTab = tabbar.selectedViewController,
                    let navVC = selectedTab as? UINavigationController {
                    navVC.popToRootViewController(animated: false)
                    let controller = StartJobRouter.createModule(.listing, dataList: data)
                    navVC.pushViewController(controller, animated: false)
                }
            }
        }
    }
    
    static func showChatScreen(clientId: Int, clientName: String, clientImage: String) {
        guard let instance = instance else { fatalError("Instance is not initialized") }
        instance.chatScreen(clientId: clientId, clientName: clientName, clientImage: clientImage)
    }
    private func chatScreen(clientId: Int, clientName: String, clientImage: String) {
        DispatchQueue.main.async {
            if let tabbar = UIViewController.top() as? HyddTabbarVC {
                (tabbar.selectedIndex != 2) ? (tabbar.selectedIndex = 2) : ()
                if let selectedTab = tabbar.selectedViewController,
                    let navVC = selectedTab as? UINavigationController {
                    navVC.popToRootViewController(animated: false)
                    let controller = ChatRouter.createModule(clientId, clientName, clientImage, .pushNotification)
                    navVC.pushViewController(controller, animated: false)
                }
            }
        }
    }
    
    static func showTabbar(selectedIndex: Int) {
        guard let instance = instance else { fatalError("Instance is not initialized") }
        if HUM.shared.user?.access == "full"{
            instance.makeTabbar(selectedIndex: selectedIndex)
        } else {
            instance.makeTabbarRestricted(selectedIndex: selectedIndex)
        }
    }
    private func makeTabbar(selectedIndex: Int) {
        
        let newjobs = DJM.shared.getValue(view: "tabbar_view", variable: "newjobs")
        let newJobsController = JobListingRouter.createModule()
        newJobsController.title = newjobs
        let newJobsBarButton = UITabBarItem(title: newjobs,
                                            image: UIImage(named: "icon_new_jobs_uncolored"),
                                            tag: 0)
        newJobsBarButton.selectedImage = UIImage(named: "icon_new_jobs_colored")
        newJobsController.tabBarItem = newJobsBarButton
        
        let myjobs = DJM.shared.getValue(view: "tabbar_view", variable: "myjobs")
        let myjobsController = MyJobsRouter.createModule()
        myjobsController.title = myjobs
        let myjobsBarButton = UITabBarItem(title: myjobs,
                                           image: UIImage(named: "icon_my_jobs_uncolored"),
                                           tag: 1)
        myjobsBarButton.selectedImage = UIImage(named: "icon_my_jobs_colored")
        myjobsController.tabBarItem = myjobsBarButton
        
        let chat = DJM.shared.getValue(view: "tabbar_view", variable: "chat")
        let chatController = ChatListRouter.createModule()
        chatController.title = chat
        let chatBarButton = UITabBarItem(title: chat,
                                         image: UIImage(named: "icon_chat_uncolored"),
                                         tag: 2)
        chatBarButton.selectedImage = UIImage(named: "icon_chat_colored")
        chatController.tabBarItem = chatBarButton
        
        let earnings = DJM.shared.getValue(view: "tabbar_view", variable: "earnings")//DJM.shared.getValue(view: "tab_bar_view", variable: "tab_one_title")
        let earningsController = MyEarningsRouter.createModule()
        earningsController.title = earnings
        let earningsBarButton = UITabBarItem(title: earnings,
                                             image: UIImage(named: "icon_earning_uncolored"),
                                             tag: 3)
        earningsBarButton.selectedImage = UIImage(named: "icon_euro_colored")
        earningsController.tabBarItem = earningsBarButton
        
        let profile = DJM.shared.getValue(view: "tabbar_view", variable: "others")//DJM.shared.getValue(view: "tab_bar_view", variable: "tab_one_title")
        let othersController = OtherRouter.createModule()
        othersController.title = profile
        let othersBarButton = UITabBarItem(title: profile,
                                           image: UIImage(named: "icon_others_uncolored"),
                                           tag: 4)
        othersBarButton.selectedImage = UIImage(named: "icon_others_colored")
        othersController.tabBarItem = othersBarButton
        
        let tabBarViewController = HyddTabbarVC()
        tabBarViewController.viewControllers = [newJobsController, myjobsController,
                                                chatController, earningsController, othersController
            ].map {UINavigationController(rootViewController: $0)}
        
        tabBarViewController.selectedIndex = selectedIndex
        self.window.rootViewController = tabBarViewController
        UIView.transition(with: window, duration: 0.8, options: [.transitionCrossDissolve], animations: nil, completion: nil)
        
        if UserDefaults.standard.bool(forKey: "INITIALIZE") {
            UserDefaults.standard.set(false, forKey: "INITIALIZE")
            Deeplinker.checkDeepLink()
        }
    }
    
    private func makeTabbarRestricted(selectedIndex: Int) {
        
        let newjobs = DJM.shared.getValue(view: "tabbar_view", variable: "newjobs")
        let newJobsController = JobListingRouter.createModule()
        newJobsController.title = newjobs
        let newJobsBarButton = UITabBarItem(title: newjobs,
                                            image: UIImage(named: "icon_new_jobs_uncolored"),
                                            tag: 0)
        newJobsBarButton.selectedImage = UIImage(named: "icon_new_jobs_colored")
        newJobsController.tabBarItem = newJobsBarButton
        
        let myjobs = DJM.shared.getValue(view: "tabbar_view", variable: "myjobs")
        let myjobsController = MyJobsRouter.createModule()
        myjobsController.title = myjobs
        let myjobsBarButton = UITabBarItem(title: myjobs,
                                           image: UIImage(named: "icon_my_jobs_uncolored"),
                                           tag: 1)
        myjobsBarButton.selectedImage = UIImage(named: "icon_my_jobs_colored")
        myjobsController.tabBarItem = myjobsBarButton
        
        let chat = DJM.shared.getValue(view: "tabbar_view", variable: "chat")
        let chatController = ChatListRouter.createModule()
        chatController.title = chat
        let chatBarButton = UITabBarItem(title: chat,
                                         image: UIImage(named: "icon_chat_uncolored"),
                                         tag: 2)
        chatBarButton.selectedImage = UIImage(named: "icon_chat_colored")
        chatController.tabBarItem = chatBarButton
        
        
        let profile = DJM.shared.getValue(view: "tabbar_view", variable: "others")//DJM.shared.getValue(view: "tab_bar_view", variable: "tab_one_title")
        let othersController = OtherRouter.createModule()
        othersController.title = profile
        let othersBarButton = UITabBarItem(title: profile,
                                           image: UIImage(named: "icon_others_uncolored"),
                                           tag: 3)
        othersBarButton.selectedImage = UIImage(named: "icon_others_colored")
        othersController.tabBarItem = othersBarButton
        
        let tabBarViewController = HyddTabbarVC()
        tabBarViewController.viewControllers = [newJobsController, myjobsController,
                                                chatController, othersController
            ].map {UINavigationController(rootViewController: $0)}
        
        tabBarViewController.selectedIndex = selectedIndex
        self.window.rootViewController = tabBarViewController
        UIView.transition(with: window, duration: 0.8, options: [.transitionCrossDissolve], animations: nil, completion: nil)
        
        if UserDefaults.standard.bool(forKey: "INITIALIZE") {
            UserDefaults.standard.set(false, forKey: "INITIALIZE")
            Deeplinker.checkDeepLink()
        }
    }
}
