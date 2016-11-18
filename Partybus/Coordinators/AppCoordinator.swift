//
//  AppCoordinator.swift
//  Partybus
//
//  Created by Brendan Conron on 11/15/16.
//  Copyright © 2016 Swoopy Studios. All rights reserved.
//

import UIKit
import Swinject

class AppCoordinator: BaseCoordinator {

    // MARK: - Window

    private let window: UIWindow?

    // MARK: - Dependency Injection

    private let container = Container { c in
        c.register(UINavigationController.self) { _ in UINavigationController() }
        c.register(MapCoordinator.self) { resolver in MapCoordinator(rootViewController: resolver.resolve(UINavigationController.self)!) }
    }

    // MARK: - Coordinators

    private let coordinator: MapCoordinator?

    // MARK: - Initializer

    required init(window: UIWindow?) {
        self.window = window
        coordinator = container.resolve(MapCoordinator.self)
        let navigationController = coordinator?.rootViewController as? UINavigationController ?? UINavigationController()
        navigationController.setNavigationBarHidden(true, animated: false)
        window?.rootViewController = navigationController
        super.init(rootViewController: navigationController)
    }

    required init(rootViewController: UIViewController) {
        fatalError("init(rootViewController:) has not been implemented")
    }

    // MARK: - Coordinator Protocol

    override func start(_ completion: CoordinatorCompletion?) {
        guard let coordinator = coordinator else { fatalError("failed to dependency inject the coordinator") }
        startChild(coordinator, withIdentifier: coordinator.identifier, completion: nil)
        window?.makeKeyAndVisible()
        super.start(completion)
    }
    
}
