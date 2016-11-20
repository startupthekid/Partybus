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
import SwinjectAutoregistration

class MapCoordinator: BaseCoordinator {

    // MARK: - Controllers

    private let mainMapViewController: MapViewController?

    // MARK: - Dependency Injection

    private let container = Container { c in
        c.autoregister(DispatchQueue.self, argument: DispatchQoS.QoSClass.self, initializer: DispatchQueue.global(qos:))
        c.autoregister(MapViewModelProtocol.self, initializer: MapViewModel.init)
    }

    // MARK: - View Model

    private let viewModel: MapViewModelProtocol

    // MARK: - Queues

    let utilityQueue: DispatchQueue?

    // MARK: - Constants

    private struct Constants {
        static let QueueKey = "com.swoopystudios.partybus.network.api"
        static let RefreshInterval: Double = 60
    }

    // MARK: - Initialization

    required init(rootViewController: UIViewController) {
        mainMapViewController = rootViewController as? MapViewController
        utilityQueue = container.resolve(DispatchQueue.self, argument: DispatchQoS.QoSClass.utility)
        viewModel = container.resolve(MapViewModelProtocol.self)!
        super.init(rootViewController: rootViewController)
    }

    override func start(_ completion: CoordinatorCompletion?) {
        guard let controller = mainMapViewController else { return }
        viewModel.routes <~ fetchRoutes().flatMapError { _ in .empty }
        viewModel.stops <~ fetchStops().flatMapError { _ in .empty }
        viewModel.buses <~ fetchBuses().flatMapError { _ in .empty }
        controller.stopAnnotations <~ viewModel.stopAnnotations
        controller.routePolylines <~ viewModel.routePolylines
        super.start(completion)
    }

    // MARK: - Networking

    private func fetchRoutes() -> SignalProducer<[Route], Moya.Error> {
        return Providers.DoubleMapProvider
            .request(token: .routes)
            .mapArray(Route.self)
            .start(on: QueueScheduler(qos: .utility, name: "\(Constants.QueueKey).routes", targeting: utilityQueue))
            .take(first: 1)
            .retry(upTo: 3)
    }

    private func fetchStops() -> SignalProducer<[Stop], Moya.Error> {
        return Providers.DoubleMapProvider
            .request(token: .stops)
            .mapArray(Stop.self)
            .start(on: QueueScheduler(qos: .utility, name: "\(Constants.QueueKey).stops", targeting: utilityQueue))
            .take(first: 1)
            .retry(upTo: 3)
    }

    private func fetchBuses() -> SignalProducer<[Bus], Moya.Error> {
        let scheduler = QueueScheduler(qos: .utility, name: "\(Constants.QueueKey).buses", targeting: utilityQueue)
        let producer =  Providers.DoubleMapProvider
            .request(token: .buses)
            .mapArray(Bus.self)
            .start(on: scheduler)
            .retry(upTo: 3)
        return producer.concat(timer(interval: Constants.RefreshInterval, on: scheduler)
            .flatMap(.latest) { _ in producer })
    }

}
