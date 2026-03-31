//
//  Untitled.swift
//  SpendInsight
//
//  Created by mac on 16/3/2026.
//
import Foundation
// MARK: - TransactionType

public enum TransactionType: Int16, Codable, Sendable {
    case expense = 0
    case income = 1
}
