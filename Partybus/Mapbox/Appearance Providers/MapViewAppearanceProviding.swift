//
//  MapViewAppearanceProviding.swift
//  Partybus
//
//  Created by Brendan Conron on 11/19/16.
//  Copyright © 2016 Swoopy Studios. All rights reserved.
//

import Foundation
import Mapbox

protocol MapViewAppearanceProviding: MGLMapViewDelegate {}

class DefaultMapViewAppearanceProvider: NSObject, MapViewAppearanceProviding {

    func mapView(_ mapView: MGLMapView, strokeColorForShapeAnnotation annotation: MGLShape) -> UIColor {
        if let annotation = annotation as? RoutePolyline {
            // Return orange if the polyline does not have a custom color.
            return annotation.color ?? .orange
        }
        // Fallback to the default tint color.
        return mapView.tintColor
    }

}
