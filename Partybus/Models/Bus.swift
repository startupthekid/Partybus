//
//  Bus.swift
//  Partybus
//
//  Created by Brendan Conron on 11/16/16.
//  Copyright © 2016 Swoopy Studios. All rights reserved.
//

import ObjectMapper

struct Bus: ImmutableMappable {

    let identifier: String
    let latitude: Double
    let longitude: Double
    let header: Int
    let lastStop: Int
    let updatedAt: TimeInterval

    init(map: Map) throws {
        identifier = try map.value("id", using: TransformOf(fromJSON: { "\($0)" }, toJSON: { Int($0 ?? "") }))
        latitude = try map.value("lat")
        longitude = try map.value("lon")
        header = try map.value("header")
        lastStop = try map.value("lastStop")
        updatedAt = try map.value("lastUpdate")
    }

}
