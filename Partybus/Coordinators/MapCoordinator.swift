//
//  MapCoordinator.swift
//  Partybus
//
//  Created by Brendan Conron on 11/15/16.
//  Copyright © 2016 Swoopy Studios. All rights reserved.
//

import UIKit
import Alamofire
import ReactiveSwift
import Moya_ObjectMapper
import Moya
import Swinject

class MapCoordinator: BaseCoordinator {

    // MARK: - Controllers

    private let mainMapViewController: MapViewController?
    // MARK: - Dependency Injection

    private let container = Container { c in
        c.register(MapViewController.self) { _ in MapViewController() }
        c.register(DispatchQueue.self) { _ in DispatchQueue.global(qos: .utility) }
        c.register(MapViewModelProtocol.self) { _ in MapViewModel() }
    }

    // MARK: - View Model

    private let viewModel: MapViewModelProtocol

    // MARK: - Queues

    let utilityQueue: DispatchQueue?

    // MARK: - Initialization

    required init(rootViewController: UIViewController) {
        mainMapViewController = container.resolve(MapViewController.self)
        utilityQueue = container.resolve(DispatchQueue.self)
        viewModel = container.resolve(MapViewModelProtocol.self)!
        super.init(rootViewController: rootViewController)
    }

    override func start(_ completion: CoordinatorCompletion?) {
        guard let navigationController = rootViewController as? UINavigationController else { return }
        guard let destinationController = mainMapViewController else { return }
        destinationController.loadViewIfNeeded()
        navigationController.setViewControllers([destinationController], animated: false)
        viewModel.routes <~ fetchRoutes().flatMapError { _ in .empty }
        super.start(completion)
    }

    // MARK: - Networking

    private func fetchRoutes() -> SignalProducer<[Route], Moya.Error> {
        return Providers.DoubleMapProvider
            .request(token: .routes)
            .mapArray(Route.self)
            .start(on: QueueScheduler(qos: .utility, name: "com.swoopystudios.partybus.network.api.routes", targeting: utilityQueue))
    }

}
