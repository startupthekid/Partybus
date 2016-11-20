//
//  AppCoordinator.swift
//  Partybus
//
//  Created by Brendan Conron on 11/15/16.
//  Copyright © 2016 Swoopy Studios. All rights reserved.
//

import UIKit
import Swinject
import SwinjectAutoregistration

class AppCoordinator: BaseCoordinator {

    // MARK: - Window

    private let window: UIWindow?

    // MARK: - Dependency Injection

    private let container = Container { c in
        c.autoregister(MapViewAppearanceProviding.self, initializer: DefaultMapViewAppearanceProvider.init)
        c.autoregister(UIViewController.self, initializer: MapViewController.init(appearanceProvider:))
        c.autoregister(MapCoordinator.self, initializer: MapCoordinator.init(rootViewController:))
    }

    // MARK: - Coordinators

    private let coordinator: MapCoordinator

    // MARK: - Initializer

    required init(window: UIWindow?) {
        self.window = window
        coordinator = container.resolve(MapCoordinator.self)!
        let navigationController = NavigationController(rootViewController: coordinator.rootViewController)
        navigationController.setNavigationBar(hidden: true, animated: false)
        window?.rootViewController = navigationController
        super.init(rootViewController: navigationController)
    }

    required init(rootViewController: UIViewController) {
        fatalError("init(rootViewController:) has not been implemented")
    }

    // MARK: - Coordinator Protocol

    override func start(_ completion: CoordinatorCompletion?) {
        startChild(coordinator, withIdentifier: coordinator.identifier, completion: nil)
        window?.makeKeyAndVisible()
        super.start(completion)
    }
    
}
