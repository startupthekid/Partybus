//
//  RouteSpec.swift
//  Partybus
//
//  Created by Brendan Conron on 11/16/16.
//  Copyright © 2016 Swoopy Studios. All rights reserved.
//

import Foundation
import Quick
import Nimble
import ObjectMapper
@testable import Partybus

class RouteSpec: QuickSpec {

    override func spec() {

        describe("Route") {

            var json: [String: Any] = [:]

            beforeEach {
                do {
                    let resourcePath = URL(fileURLWithPath: Bundle(for: type(of: self)).path(forResource: "route", ofType: "json")!)
                    let data = try Data(contentsOf: resourcePath, options: [.mappedIfSafe])
                    json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] ?? [:]
                } catch {
                    fail("unable to parse json file route.json. failed with error: \(error)")
                }
            }

            it("should transform a json object into a route object") {
                expect { try Route(JSON: json) as ImmutableMappable }.toNot(throwError())
            }

        }
    }
}
