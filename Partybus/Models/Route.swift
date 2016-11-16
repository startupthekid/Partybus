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

    init(map: Map) throws {
        identifier = try map.value("id")
        name = try map.value("name")
        shortName = try map.value("short_name")
        description = try map.value("description")
        color = try map.value("color")
        scheduleURI = try map.value("schedule")
        active = try map.value("active")
        path = try map.value("path", using: CoordinatesTransform())
    }

}

//[{"id":3,"name":"Davis Square Shuttle","short_name":"J","description":"The Davis Square Shuttle stops at Davis Square, The Campus Center, Carmichael, Olin and then back to The Campus Center before returning to Davis Square.","color":"4351FC","schedule":"http:\/\/publicsafety.tufts.edu\/adminsvc\/saturday-schedule-2\/","active":true,"path":[42.405303,-71.120566,42.40533,-71.1206,42.40538,-71.12073,42.40541,-71.12082,42.40566,-71.12064,42.4058,-71.12055,42.40582,-71.12053,42.4059,-71.12048,42.40614,-71.12032,097,-71.11655,42.401,-71.11651,42.40103,-71.11648,42.40104,-71.11646,42.40106,-71.11645,42.40107,-71.11643,42.40109,…………………...],"stops":[1,2,3,4,5,6]}]
