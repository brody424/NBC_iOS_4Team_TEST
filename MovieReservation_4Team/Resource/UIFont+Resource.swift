//
//  UIFont+Resource.swift
//  MovieReservation_4Team
//
//  Created by t2023-m0117 on 7/23/24.
//

import UIKit

struct Font {
    let name: String
    let size: CGFloat

    func font() -> UIFont? {
        return UIFont(name: name, size: size)
    }
}

struct FontNames {
    static let mainFont: Font = Font(name: "LINESeedSansKR-Bold", size: 20.0)
    static let subFont: Font = Font(name: "LINESeedSansKR-Regular", size: 14.0)
    static let thinFont: Font = Font(name: "LINESeedSansKR-Thin", size: 12.0)

    static func allFonts() -> [(font: UIFont?, name: String, size: CGFloat)] {
        return [
            (mainFont.font(), mainFont.name, mainFont.size),
            (subFont.font(), subFont.name, subFont.size),
            (thinFont.font(), thinFont.name, thinFont.size)
        ]
    }
}
