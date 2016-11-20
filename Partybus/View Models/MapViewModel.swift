//
//  MapViewModel.swift
//  Partybus
//
//  Created by Brendan Conron on 11/16/16.
//  Copyright © 2016 Swoopy Studios. All rights reserved.
//

import Foundation
import ReactiveSwift
import CoreLocation

// TODO: Rename this entire class cluster: https://trello.com/b/mY9VZ8Qw/ios

struct MapViewModel: MapViewModelProtocol {

    let routes = MutableProperty<[Route]>([])
    let stops = MutableProperty<[Stop]>([])
    let buses = MutableProperty<[Bus]>([])

    let stopAnnotations: Property<[StopAnnotation]>
    let routePolylines: Property<[RoutePolyline]>
    let busAnnotations: Property<[BusAnnotation]>

    init() {
        stopAnnotations = Property(initial: [], then: stops.producer.map { stops in
            return stops.map { (stop: Stop) -> StopAnnotation in StopAnnotation(coordinate: CLLocationCoordinate2D(latitude: stop.latitude, longitude: stop.longitude)) }
        })

        routePolylines = Property(initial: [], then: routes.producer.map { routes in
            return routes.map {
                var coordinates = $0.path.map { CLLocationCoordinate2D(latitude: $0.0, longitude: $0.1) }
                let polyline = RoutePolyline(coordinates: &coordinates, count: UInt($0.path.count))
                polyline.color = UIColor(hex: $0.color)
                return polyline
            }
        })

        busAnnotations = Property(initial: [], then: buses.producer.map { buses in
            return buses.map { (bus: Bus) -> BusAnnotation in BusAnnotation(coordinate: CLLocationCoordinate2D(latitude: bus.latitude, longitude: bus.longitude)) }
        })
    }

}
