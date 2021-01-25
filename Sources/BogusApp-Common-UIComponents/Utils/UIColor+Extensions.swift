//
//  UIColor+Extensions.swift
//  BougsApp-iOS
//
//  Created by Marius Ilie on 23/01/2021.
//

import UIKit

extension UIColor {
    static var appBackground: UIColor { UIColor(named: "AppBackgroundColorScheme") ?? .clear }
    static var neumorphicPrimaryShadow: UIColor { UIColor(named: "NeumorphicPrimaryShadow") ?? .clear }
    static var neumorphicSecondaryShadow: UIColor { UIColor(named: "NeumorphicSecondaryShadow") ?? .clear }
}
