//
//  BusAnnotation.swift
//  Partybus
//
//  Created by Brendan Conron on 11/20/16.
//  Copyright © 2016 Swoopy Studios. All rights reserved.
//

import UIKit
import Mapbox

class BusAnnotation: NSObject, MGLAnnotation {

    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?

    var image: UIImage?
    var reuseIdentifier: String?

    init(coordinate: CLLocationCoordinate2D, title: String? = nil, subtitle: String? = nil) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }

}

