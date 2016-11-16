//
//  WindowModule.swift
//  Partybus
//
//  Created by Brendan Conron on 11/15/16.
//  Copyright © 2016 Swoopy Studios. All rights reserved.
//

import UIKit
import Cleanse

struct WindowModule: Cleanse.Module {

    static func configure<B: Binder>(binder: B) {
        binder
            .bind(UIWindow.self)
            .asSingleton()
            .to {
                let window = UIWindow(frame: UIScreen.main.bounds)
                window.rootViewController = UINavigationController()
                return window
        }
    }

}
