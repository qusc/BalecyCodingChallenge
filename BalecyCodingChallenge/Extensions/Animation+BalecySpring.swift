//
//  Animation+BalecySpring.swift
//  BalecyCodingChallenge
//
//  Created by Quirin Schweigert on 06.09.21.
//

import SwiftUI

extension Animation {
    static let balecySpring: Self = .interactiveSpring(response: 0.35, dampingFraction: 0.75)
}
