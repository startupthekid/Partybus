//
//  AppDelegate.swift
//  Partybus
//
//  Created by Brendan Conron on 11/15/16.
//  Copyright © 2016 Swoopy Studios. All rights reserved.
//

import UIKit
import Swinject

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let application: ApplicationProtocol
    let coordinator: CoordinatorProtocol

    init(window: UIWindow?, application: ApplicationProtocol, coordinator: CoordinatorProtocol) {
        self.window = window
        self.application = application
        self.coordinator = coordinator
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        coordinator.start(nil)
        return true
    }

}
