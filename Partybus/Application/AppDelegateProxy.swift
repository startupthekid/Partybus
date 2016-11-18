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

        // Register dependencies
        container.register(UINavigationController.self) { _ in UINavigationController() }
        container.register(UIScreen.self) { _ in UIScreen.main }
        container.register(UIWindow.self, factory: { resolver in
            let window = UIWindow(frame: resolver.resolve(UIScreen.self)!.bounds)
            window.rootViewController = resolver.resolve(UINavigationController.self)
            return window
        })
            .inObjectScope(.hierarchy)
        container.register(ApplicationProtocol.self) { _ in UIApplication.shared }
        container.register(CoordinatorProtocol.self) { r in AppCoordinator(window: r.resolve(UIWindow.self)) }
        container.register(AppDelegate.self) { r in
            AppDelegate(window: r.resolve(UIWindow.self), application: r.resolve(ApplicationProtocol.self)!, coordinator: r.resolve(CoordinatorProtocol.self)!)
        }
            .inObjectScope(.hierarchy)

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
