//
//  Untitled.swift
//  SpendInsight
//
//  Created by mac on 16/3/2026.
//
import Foundation

// MARK: - Frequency
public enum Frequency: Int16, Codable, Sendable {
    case daily = 0
    case weekly = 1
    case monthly = 2
    case yearly = 3
}
