//
//  Publisher+assignNoRetain.swift
//  BalecyCodingChallenge
//
//  Created by Quirin Schweigert on 06.09.21.
//

import Foundation
import Combine
import SwiftUI

// https://stackoverflow.com/questions/57980476/how-to-prevent-strong-reference-cycles-when-using-apples-new-combine-framework

extension Publisher where Self.Failure == Never {
    public func assignNoRetain<Root>(
        to keyPath: ReferenceWritableKeyPath<Root, Self.Output>,
        on object: Root
    ) -> AnyCancellable where Root: AnyObject {
        sink { [weak object] (value) in
            object?[keyPath: keyPath] = value
        }
    }
}

extension Publisher where Self.Failure == Never {
    public func assignNoRetainWithAnimation<Root>(
        _ animation: Animation? = .default,
        to keyPath: ReferenceWritableKeyPath<Root, Self.Output>,
        on object: Root
    ) -> AnyCancellable where Root: AnyObject {
        sink { [weak object] (value) in
            withAnimation(animation) {
                object?[keyPath: keyPath] = value
            }
        }
    }
}
