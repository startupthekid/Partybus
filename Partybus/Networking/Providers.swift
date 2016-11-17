//
//  Providers.swift
//  Partybus
//
//  Created by Brendan Conron on 11/17/16.
//  Copyright © 2016 Swoopy Studios. All rights reserved.
//

import Foundation
import Moya

struct Providers {
    static let DoubleMapProvider = ReactiveCocoaMoyaProvider<DoubleMap>(stubClosure: { target in
        #if Debug
            return .immediate
        #elseif Staging || Release
            return .never
        #endif
    })
}
