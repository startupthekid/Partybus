//
//  CoordinatesTransformSpec.swift
//  Partybus
//
//  Created by Brendan Conron on 11/15/16.
//  Copyright © 2016 Swoopy Studios. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import Partybus

class CoordinatesTransformSpec: QuickSpec {

    override func spec() {

        describe("CoordinatesTransform") {

            var points: [Double] = []
            var transform: CoordinatesTransform!

            beforeEach {
                do {
                    let resourcePath = URL(fileURLWithPath: Bundle(for: type(of: self)).path(forResource: "points", ofType: "json")!)
                    let data = try Data(contentsOf: resourcePath, options: [.mappedIfSafe])
                    points = try JSONSerialization.jsonObject(with: data, options: []) as? [Double] ?? []
                } catch {
                    fail("unable to parse json file points.json. failed with error: \(error)")
                }
                transform = CoordinatesTransform()
            }

            it("should transform a list of points into tuple coordinate pairs") {
                let coordinates = transform.transformFromJSON(points)
                expect(coordinates).toNot(beNil())
                expect(coordinates).toNot(beEmpty())
                expect(coordinates).to(haveCount(points.count / 2))
            }

            it("should not transform into json") {
                let json = transform.transformToJSON([(0.0, 0.0)])
                expect(json).to(beNil())
            }
        }
    }
}
