//
//  AppButtonSize.swift
//  SpendInsight
//
//  Created by mac on 15/2/2026.
//
import Foundation

public enum AppButtonSize {
    case small
    case medium
    case large
    
    public var height: CGFloat {
        switch self {
        case .small: return 36
        case .medium: return 44
        case .large: return 52
        }
    }
}
