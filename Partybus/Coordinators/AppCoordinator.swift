//
//  AppCoordinator.swift
//  Partybus
//
//  Created by Brendan Conron on 11/15/16.
//  Copyright © 2016 Swoopy Studios. All rights reserved.
//

import UIKit

class AppCoordinator: BaseCoordinator {

    // MARK: - Window

    private let window: UIWindow

    // MARK: - Coordinators

    private let mapCoordinator: MapCoordinator

    // MARK: - Initializer

    required init(window: UIWindow) {
        self.window = window
        let navigationController = UINavigationController()
        navigationController.setNavigationBarHidden(true, animated: false)
        window.rootViewController = navigationController

        mapCoordinator = MapCoordinator(rootViewController: navigationController)
        super.init(rootViewController: navigationController)
    }

    required init(rootViewController: UIViewController) {
        fatalError("init(rootViewController:) has not been implemented")
    }

    // MARK: - Coordinator Protocol

    override func start(_ completion: CoordinatorCompletion?) {
        startChild(mapCoordinator, withIdentifier: "MapCoordinator", completion: nil)
        window.makeKeyAndVisible()
        super.start(completion)
    }
    
}
