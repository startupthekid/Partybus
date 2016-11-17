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

class MapCoordinator: BaseCoordinator {

    // MARK: - Controllers

    private lazy var mapViewController: MapViewController = {
        return MapViewController()
    }()

    // MARK: - View Model

    private let viewModel = MapViewModel()

    // MARK: - Queues

    let utilityQueue = DispatchQueue.global(qos: .utility)

    // MARK: - Initialization

    required init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
    }

    override func start(_ completion: CoordinatorCompletion?) {
        guard let navigationController = rootViewController as? UINavigationController else { return }
        mapViewController.loadViewIfNeeded()
        navigationController.setViewControllers([mapViewController], animated: false)
        viewModel.routes <~ fetchRoutes().flatMapError { _ in .empty }
        super.start(completion)
    }

    // MARK: - Networking

    private func fetchRoutes() -> SignalProducer<[Route], Moya.Error> {
        return Providers.DoubleMapProvider.request(token: .routes).mapArray(Route.self)
    }

}
