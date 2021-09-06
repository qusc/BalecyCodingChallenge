//
//  Font+Montserrat.swift
//  BalecyCodingChallenge
//
//  Created by Quirin Schweigert on 06.09.21.
//

import Foundation
import SwiftUI

extension Font {
    enum MontserratFontWeight {
        case regular
        case medium
        case bold
        case extrabold
        
        var fontName: String {
            switch self {
            case .regular:
                return "Montserrat-Regular"
            case .medium:
                return "Montserrat-Medium"
            case .bold:
                return "Montserrat-Bold"
            case .extrabold:
                return "Montserrat-ExtraBold"
            }
        }
    }
    
    static func montserrat(size: CGFloat, weight: MontserratFontWeight = .regular) -> Self {
        .custom(weight.fontName, size: size)
    }
}
