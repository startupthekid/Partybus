//
//  BusSpec.swift
//  Partybus
//
//  Created by Brendan Conron on 11/20/16.
//  Copyright © 2016 Swoopy Studios. All rights reserved.
//

import Foundation
import Quick
import Nimble
import ReactiveSwift
import Result
import Partybus

class BusSpec: QuickSpec {

    override func spec() {

        describe("Bus") {

            it("should map a stubbed response into a list of buses") {
                var buses: [Bus] = []
                let producer = TestProviders.StubbedDoubleMapProvider.request(token: .buses).mapArray(Bus.self)
                producer.startWithResult { result in
                    buses = result.value ?? []
                }
                expect(buses).toEventuallyNot(beEmpty())
            }

        }

    }

}
