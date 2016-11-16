//
//  CoordinatorProtocol.swift
//  Partybus
//
//  Created by Brendan Conron on 11/15/16.
//  Copyright © 2016 Swoopy Studios. All rights reserved.
//

import Foundation
import UIKit

typealias CoordinatorCompletion = (CoordinatorProtocol) -> ()

protocol CoordinatorProtocol: class {

    /// A unique identifier.
    var identifier: String { get }

    var rootViewController: UIViewController { get }

    /// Identifier -> coordination mapping. All the child coordinators this coordinators is responsible for.
    var childCoordinators: [String: CoordinatorProtocol] { get set }

    init(rootViewController: UIViewController)

    /**
     Tells the coordinator to take control of the application flow.

     - parameter completion: Completion block.
     */
    func start(_ completion: CoordinatorCompletion?)

    /**
     Tells the coordinator to stop and relinquish flow control.

     - parameter completion: Completion block.
     */
    func stop(_ completion: CoordinatorCompletion?)

    /**
     Adds a new child coordinator and starts it.

     - parameter coordinator: The coordinator to start.
     - parameter identifier:  Unique coordinator identifier.
     - parameter completion:  Completion block.

     - returns: The started coordinator.
     */
    func startChild<T: CoordinatorProtocol>(_ coordinator: T, withIdentifier identifier: String, completion: CoordinatorCompletion?) -> T

    /**
     Stops the coordinators and removes it.

     - parameter coordinatorWithIdentifier: Identifier for the coordinator.
     - parameter completion:                Completion block.
     */
    func stop(coordinatorWithIdentifier identifier: String, completion: CoordinatorCompletion?)

    /// Stops all children and calls their respective stop methods.
    ///
    /// - parameter completion: Completion block, may be optional.
    func stopAllChildren(with completion: CoordinatorCompletion?)

}

extension CoordinatorProtocol {

    var identifier: String {
        return "\(type(of: self))"
    }

    @discardableResult
    func startChild<T: CoordinatorProtocol>(_ coordinator: T, withIdentifier identifier: String, completion: CoordinatorCompletion? = nil) -> T {
        childCoordinators[identifier] = coordinator
        coordinator.start(completion)
        return coordinator
    }

    func stop(coordinatorWithIdentifier identifier: String, completion: CoordinatorCompletion? = nil) {
        guard let coordinator = childCoordinators[identifier],
            let index = childCoordinators.index(forKey: identifier) else {
                fatalError("No coordinator exists with the identifier \(identifier)")
        }
        coordinator.stop { [weak self] coordinator in
            self?.childCoordinators.remove(at: index)
            completion?(coordinator)
        }
    }

    func stopAllChildren(with completion: CoordinatorCompletion? = nil) {
        childCoordinators.forEach { $0.1.stop(nil) }
        childCoordinators.removeAll()
    }

    func startChildWith<T: CoordinatorProtocol>(_ rootViewController: UIViewController, completion: CoordinatorCompletion? = nil, configureWith configurationBlock: ((T) -> Void)? = nil) -> T {
        let coordinator = T.init(rootViewController: rootViewController)
        configurationBlock?(coordinator)
        let _ = startChild(coordinator, withIdentifier: coordinator.identifier, completion: completion)
        return coordinator
    }
    
}

