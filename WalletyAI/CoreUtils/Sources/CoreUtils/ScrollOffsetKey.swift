//
//  ScrollOffsetKey.swift
//  SpendInsight
//
//  Created by mac on 14/3/2026.
//
import SwiftUI

public struct ScrollOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
