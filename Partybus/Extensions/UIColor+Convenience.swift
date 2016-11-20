//
//  UIColor+Convenience.swift
//  Partybus
//
//  Created by Brendan Conron on 11/19/16.
//  Copyright © 2016 Swoopy Studios. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {

    /**
     Creates a color using normalized values.

     - parameter r: Red value.
     - parameter g: Green value.
     - parameter b: Blue value.
     - parameter a: Alpha value.

     - returns: `UIColor` object.
     */
    func color(_ r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) -> UIColor {
        return UIColor(red: r / 255, green: g / 255, blue: b / 255, alpha: a)
    }

    /**
     Converts a hex string into a UIColor.

     - parameter hex: Hex color string.
     */
    convenience init(hex: String) {
        let hexString = hex.replacingOccurrences(of: "#", with: "")
        let scanner = Scanner(string: hexString)
        scanner.charactersToBeSkipped = CharacterSet.symbols
        var hexInt: UInt32 = 0
        if scanner.scanHexInt32(&hexInt) {
            let red = (hexInt >> 16) & 0xFF
            let green = (hexInt >> 8) & 0xFF
            let blue = (hexInt) & 0xFF

            self.init(
                red: CGFloat(red) / 255.0,
                green: CGFloat(green) / 255.0,
                blue: CGFloat(blue) / 255.0,
                alpha: 1.0
            )
        } else {
            self.init(
                red: 0.0,
                green: 0.0,
                blue: 0.0,
                alpha: 0.0)
        }
    }
    
}
