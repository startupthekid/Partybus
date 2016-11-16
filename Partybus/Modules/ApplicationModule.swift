//
//  ApplicationModule.swift
//  Partybus
//
//  Created by Brendan Conron on 11/15/16.
//  Copyright © 2016 Swoopy Studios. All rights reserved.
//

import UIKit
import Cleanse

struct ApplicationModule: Cleanse.Module {

    static func configure<B: Binder>(binder: B) {
        binder.install(module: WindowModule.self)
        binder.bind(ApplicationProtocol.self).to(value: UIApplication.shared)
        binder.bind(AppDelegate.self).asSingleton().to(factory: AppDelegate.init)
    }
    
}
