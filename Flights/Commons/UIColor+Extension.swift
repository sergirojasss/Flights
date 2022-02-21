//
//  UIColor+Extension.swift
//  Flights
//
//  Created by ROJAS SERRA Sergi on 22/2/22.
//

import Foundation
import UIKit

extension UIColor {
    static let customBlack = UIColor("1A1A1A")
    static let customGray = UIColor("525252")
    static let customBlue = UIColor("4267B2")
}

extension UIColor {
    convenience init(_ hex: Int, alpha: Double = 1.0) {
        self.init(red: CGFloat((hex >> 16) & 0xFF) / 255.0, green: CGFloat((hex >> 8) & 0xFF) / 255.0, blue: CGFloat(hex & 0xFF) / 255.0, alpha: CGFloat(255 * alpha) / 255)
    }

    public convenience init(_ hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)

        let r, g, b: UInt64
        switch hex.count {
        case 3:
            (r, g, b) = ((int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (r, g, b) = (int >> 16, int >> 8 & 0xFF, int & 0xFF)
        default:
            (r, g, b) = (1, 1, 0)
        }

        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(255) / 255)
    }

    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1) {
        self.init(red: r / 255, green: g / 255, blue: b / 255, alpha: a)
    }
}
