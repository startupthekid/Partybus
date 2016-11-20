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
import ReactiveSwift
@testable import Partybus

class RouteSpec: QuickSpec {

    override func spec() {

        describe("Route") {

            it("should map stubbed json into a list of routes") {
                var routes: [Route] = []
                let producer = TestProviders.StubbedDoubleMapProvider.request(token: .routes).mapArray(Route.self).on(value: {
                    routes = $0
                })
                producer.start()
                expect(routes).toEventuallyNot(beEmpty())
            }

        }
    }
}
