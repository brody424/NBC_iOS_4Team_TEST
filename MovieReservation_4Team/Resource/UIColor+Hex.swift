//
//  UIColor+Hex.swift
//  MovieReservation_4Team
//
//  Created by Lee-Juhee on 7/23/24.
//
//let main = UIColor.mainColor
//let Black = UIColor.Black
//let White = UIColor.White

import UIKit

extension UIColor {
    convenience init(hexCode: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hexCode.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()

        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }

        assert(hexFormatted.count == 6, "Invalid hex code used.")

        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)

        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }

    static let colors: [String: String] = [
        "mainColor": "#BB1024",
        "Black": "#221F1F",
        "White": "#F5F5F1"
    ]

    static func color(named name: String) -> UIColor? {
        guard let hexCode = colors[name] else { return nil }
        return UIColor(hexCode: hexCode)
    }

    static var mainColor: UIColor { return color(named: "mainColor")! }
    static var Black: UIColor { return color(named: "Black")! }
    static var White: UIColor { return color(named: "White")! }
}




