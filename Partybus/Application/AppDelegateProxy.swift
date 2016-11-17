//
//  AppDelegateProxy.swift
//  Partybus
//
//  Created by Brendan Conron on 11/15/16.
//  Copyright © 2016 Swoopy Studios. All rights reserved.
//

import UIKit
import Cleanse

@UIApplicationMain
class AppDelegateProxy: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var applicationDelegate: AppDelegate?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let propertyInjector = try! ComponentFactory.of(AppDelegateProxy.Component.self).build()
        propertyInjector.injectProperties(into: self)
        return applicationDelegate?.application(application, didFinishLaunchingWithOptions: launchOptions) ?? true
    }

    func injectProperties(_ window: UIWindow, delegate: AppDelegate) {
        self.window = window
        applicationDelegate = delegate
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

extension AppDelegateProxy {

    struct Component: Cleanse.RootComponent {
        
        typealias Root = PropertyInjector<AppDelegateProxy>

        static func configure<B: Binder>(binder: B) {
            binder.install(module: ApplicationModule.self)
            binder.bindPropertyInjectionOf(AppDelegateProxy.self).to(injector: AppDelegateProxy.injectProperties)
        }

    }

}
