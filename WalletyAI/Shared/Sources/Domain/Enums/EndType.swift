//
//  Untitled.swift
//  SpendInsight
//
//  Created by mac on 16/3/2026.
//
import Foundation

// MARK: - EndType
public enum EndType: Int16, Codable, Sendable {
    case forever = 0
    case endDate = 1
    case count = 2
}
