//
//  Stop.swift
//  Partybus
//
//  Created by Brendan Conron on 11/16/16.
//  Copyright © 2016 Swoopy Studios. All rights reserved.
//

import ObjectMapper

struct Stop: ImmutableMappable {

    let identifier: String
    let name: String
    let description: String
    let latitude: Double
    let longitude: Double

    init(map: Map) throws {
        identifier = try map.value("id", using: TransformOf(fromJSON: { "\($0)" }, toJSON: { Int($0 ?? "") }))
        name = try map.value("name")
        description = try map.value("description")
        latitude = try map.value("lat")
        longitude = try map.value("lon")
    }
}
