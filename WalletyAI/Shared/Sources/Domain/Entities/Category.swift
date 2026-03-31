//
//  TransactionEntity.swift
//  SpendInsight
//
//  Created by mac on 14/2/2026.
//
import Foundation

struct Category : Identifiable , Equatable{
    let id: UUID
    let name: String
    let color: String
    let icon: String
    let totalSpending: Double
    let transactionCount: Int
}
