//
//  Untitled.swift
//  SpendInsight
//
//  Created by mac on 16/3/2026.
//
import Foundation

// MARK: - RecurringStatus
public enum RecurringStatus: Int16, Codable, Sendable {
    case active = 0
    case paused = 1
    case cancelled = 2
}
