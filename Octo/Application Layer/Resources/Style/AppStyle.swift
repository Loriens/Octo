//
//  AppStyle.swift
//  Octo
//
//  Created by Vladislav Markov on 20.04.2024.
//

import UIKit

enum AppStyle {
    enum Background {
        static let basic: UIColor? = UIColor { traitCollection in
            switch traitCollection.userInterfaceStyle {
            case .light, .unspecified:
                return UIColor(hex: "#FFFFFF") ?? .clear
            case .dark:
                return UIColor(hex: "#0F1116") ?? .clear
            @unknown default:
                return UIColor(hex: "#FFFFFF") ?? .clear
            }
        }
    }

    enum Text {
        static let primary: UIColor? = UIColor { traitCollection in
            switch traitCollection.userInterfaceStyle {
            case .light, .unspecified:
                return UIColor(hex: "#222222") ?? .clear
            case .dark:
                return UIColor(hex: "#E4E8EE") ?? .clear
            @unknown default:
                return UIColor(hex: "#222222") ?? .clear
            }
        }
        static let secondary = UIColor(hex: "#99A0AB")
    }
}

// MARK: - UIColor + hex

extension UIColor {
    convenience init?(hex: String) {
        // swiftlint:disable identifier_name
        let r, g, b, a: CGFloat
        // swiftlint:enable identifier_name

        var mutableString = hex

        if hex.count == 7 {
            mutableString.append("FF")
        }

        if hex.hasPrefix("#") {
            let start = mutableString.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(mutableString[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
}
