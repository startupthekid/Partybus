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

            var jsonArray: [[String: AnyObject]] = []

            beforeEach {
                do {
                    let resourcePath = URL(fileURLWithPath: Bundle(for: type(of: self)).path(forResource: "routes", ofType: "json")!)
                    let data = try Data(contentsOf: resourcePath, options: [.mappedIfSafe])
                    jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: AnyObject]] ?? []
                } catch {
                    fail("unable to parse json file routes.json. failed with error: \(error)")
                }
            }

            it("should transform json into a list of arrays") {
                let routes = jsonArray.map { try! Route(JSON: $0) }
                expect(routes).toNot(beEmpty())
                expect(routes).to(haveCount(jsonArray.count))
            }
        }
    }
}
