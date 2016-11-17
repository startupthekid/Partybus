//
//  Route.swift
//  Partybus
//
//  Created by Brendan Conron on 11/15/16.
//  Copyright © 2016 Swoopy Studios. All rights reserved.
//

import ObjectMapper

struct Route: ImmutableMappable {

    let identifier: String
    let name: String
    let shortName: String
    let description: String
    let color: String
    let scheduleURI: String
    let active: Bool
    let path: [(Double, Double)]
    let stops: [Int]

    init(map: Map) throws {
        identifier = try map.value("id", using: TransformOf(fromJSON: { "\($0)" }, toJSON: { Int($0 ?? "") }))
        name = try map.value("name")
        shortName = try map.value("short_name")
        description = try map.value("description")
        color = try map.value("color")
        scheduleURI = try map.value("schedule")
        active = try map.value("active")
        path = try map.value("path", using: CoordinatesTransform())
        stops = try map.value("stops")
    }

}
