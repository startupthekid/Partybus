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
//        rxs.disposeBag
//            ++ viewModel.routes <~ fetchRoutes().takeUntil(mapViewController.rxs.onDeinit)
        super.start(completion)
    }

    // MARK: - Networking

//    private func fetchRoutes() -> Observable<[Route]> {
//        return Alamofire.SessionManager.default.rx.request(.get, "https://tufts.doublemap.com/map/v2/routes").responseArray()
//    }

}
