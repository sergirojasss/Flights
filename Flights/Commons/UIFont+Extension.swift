//
//  UIFont+Extension.swift
//  Flights
//
//  Created by ROJAS SERRA Sergi on 22/2/22.
//

import Foundation
import UIKit

extension UIFont {
    static func semibold(size: CGFloat) -> UIFont {
        guard let customFont = UIFont(name: "Poppins-Semibold", size: size) else {
            return UIFont.systemFont(ofSize: size)
        }
        return customFont
    }

    static func medium(size: CGFloat) -> UIFont {
        guard let customFont = UIFont(name: "Poppins-Medium", size: size) else {
            return UIFont.systemFont(ofSize: size)
        }
        return customFont
    }

    static func regular(size: CGFloat) -> UIFont {
        guard let customFont = UIFont(name: "Poppins-Regular", size: size) else {
            return UIFont.systemFont(ofSize: size)
        }
        return customFont
    }

    static func extraBold(size: CGFloat) -> UIFont {
        guard let customFont = UIFont(name: "Poppins-ExtraBold", size: size) else {
            return UIFont.systemFont(ofSize: size)
        }
        return customFont
    }
}
