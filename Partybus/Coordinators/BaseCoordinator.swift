//
//  BaseCoordinator.swift
//  Partybus
//
//  Created by Brendan Conron on 11/15/16.
//  Copyright © 2016 Swoopy Studios. All rights reserved.
//

import UIKit

class BaseCoordinator: NSObject, CoordinatorProtocol {

    let rootViewController: UIViewController

    var childCoordinators: [String: CoordinatorProtocol] = [:]

    required init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }

    func start(_ completion: CoordinatorCompletion? = nil) {
        completion?(self)
    }

    func stop(_ completion: CoordinatorCompletion? = nil) {
        completion?(self)
    }
    
}
