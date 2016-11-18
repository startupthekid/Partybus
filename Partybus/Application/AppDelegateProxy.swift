//
//  AppDelegateProxy.swift
//  Partybus
//
//  Created by Brendan Conron on 11/15/16.
//  Copyright © 2016 Swoopy Studios. All rights reserved.
//

import UIKit
import Swinject

@UIApplicationMain
class AppDelegateProxy: UIResponder, UIApplicationDelegate {

    var applicationDelegate: AppDelegate?

    let container: Container

    override init() {
        container = Container()
        super.init()
        container.register(UIWindow.self, factory: { _ in
            let window = UIWindow(frame: UIScreen.main.bounds)
            window.rootViewController = UINavigationController()
            return window
        })
        .inObjectScope(.container)

        container.register(ApplicationProtocol.self) { _ in UIApplication.shared }
        container.register(AppDelegate.self) { r in AppDelegate(window: r.resolve(UIWindow.self)!, application: r.resolve(ApplicationProtocol.self)!) }.inObjectScope(.container)

    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        applicationDelegate = container.resolve(AppDelegate.self)
        return applicationDelegate?.application(application, didFinishLaunchingWithOptions: launchOptions) ?? true
    }

    // MARK: - UIResponder

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        applicationDelegate?.touchesBegan(touches, with: event)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        applicationDelegate?.touchesMoved(touches, with: event)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        applicationDelegate?.touchesEnded(touches, with: event)
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        applicationDelegate?.touchesCancelled(touches, with: event)
    }

}
