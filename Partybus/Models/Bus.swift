//
//  Bus.swift
//  Partybus
//
//  Created by Brendan Conron on 11/16/16.
//  Copyright © 2016 Swoopy Studios. All rights reserved.
//

import ObjectMapper

public struct Bus: ImmutableMappable {

    let identifier: Int
    let latitude: Double
    let longitude: Double
    let route: Int
    let header: Int
    let lastStop: Int
    let updatedAt: TimeInterval

    public init(map: Map) throws {
        identifier = try map.value("id")
        latitude = try map.value("lat")
        longitude = try map.value("lon")
        route = try map.value("route")
        header = try map.value("heading")
        lastStop = try map.value("lastStop")
        updatedAt = try map.value("lastUpdate")
    }

}
