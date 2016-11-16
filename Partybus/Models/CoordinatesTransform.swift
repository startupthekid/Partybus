//
//  CoordinatesTransform.swift
//  Partybus
//
//  Created by Brendan Conron on 11/15/16.
//  Copyright © 2016 Swoopy Studios. All rights reserved.
//

import Foundation
import ObjectMapper

/// Custom ObjectMapper transform to convert DoubleMap's coordinate json format,
/// `[Double]`, to a list of tuple pairs.
struct CoordinatesTransform: TransformType {
    typealias Object = [(Double, Double)]
    typealias JSON = [Double]

    func transformFromJSON(_ value: Any?) -> Array<(Double, Double)>? {
        guard let points = value as? JSON else { return nil }
        let indexes = Array(stride(from: 0, to: points.count, by: 1))
        let indexedArray = Array(zip(points, indexes))
        let latitudes = indexedArray.filter { $0.1 % 2 == 0 }.map { $0.0 }
        let longitudes = indexedArray.filter { $0.1 % 2 != 0 }.map { $0.0 }
        return Array(zip(latitudes, longitudes))
    }

    func transformToJSON(_ value: Array<(Double, Double)>?) -> Array<Double>? {
        return nil
    }

}
