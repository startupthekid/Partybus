//
//  UIView+Query.swift
//  Partybus
//
//  Created by Brendan Conron on 11/19/16.
//  Copyright © 2016 Swoopy Studios. All rights reserved.
//

import Foundation
import UIKit

extension UIView {

    var x: CGFloat {
        get {
            return frame.origin.x
        }
        set {
            frame.origin.x = newValue
        }
    }

    var y: CGFloat {
        get {
            return frame.origin.y
        }
        set {
            frame.origin.y = newValue
        }
    }

    var width: CGFloat {
        get {
            return frame.width
        }
        set {
            frame.size.width = newValue
        }
    }

    var height: CGFloat {
        get {
            return frame.height
        }
        set {
            frame.size.height = newValue
        }
    }

    var origin: CGPoint {
        get {
            return frame.origin
        }
        set {
            frame.origin = newValue
        }
    }

    var size: CGSize {
        get {
            return frame.size
        }
        set {
            frame.size = newValue
        }
    }
    
}
