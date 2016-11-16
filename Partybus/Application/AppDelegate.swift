//
//  AppDelegate.swift
//  Partybus
//
//  Created by Brendan Conron on 11/15/16.
//  Copyright © 2016 Swoopy Studios. All rights reserved.
//

import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let application: ApplicationProtocol
    let coordinator: AppCoordinator

    init(window: UIWindow, application: ApplicationProtocol) {
        self.window = window
        self.application = application
        coordinator = AppCoordinator(window: window)
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        coordinator.start(nil)
        return true
    }

}
