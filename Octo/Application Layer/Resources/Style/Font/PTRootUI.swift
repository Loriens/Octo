//
//  PTRootUI.swift
//  Octo
//
//  Created by Vladislav Markov on 20.04.2024.
//

import UIKit

enum PTRootUI: String {
    case light = "PTRootUI-Light"
    case regular = "PTRootUI-Regular"
    case medium = "PTRootUI-Medium"
    case bold = "PTRootUI-Bold"

    func dynamicallyScalingFont(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: rawValue, size: size) else {
            preconditionFailure("Retrieve \(rawValue) font with error")
        }
        return UIFontMetrics.default.scaledFont(for: font)
    }
}
