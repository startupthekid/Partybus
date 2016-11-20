//
//  TestProviders.swift
//  Partybus
//
//  Created by Brendan Conron on 11/20/16.
//  Copyright © 2016 Swoopy Studios. All rights reserved.
//

import Foundation
import Moya
import Partybus

struct TestProviders {
    static let StubbedDoubleMapProvider = ReactiveCocoaMoyaProvider<DoubleMap>(stubClosure: { target in
        return .immediate
    })
}
