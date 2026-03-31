//
//  TransactionEntity.swift
//  SpendInsight
//
//  Created by mac on 14/2/2026.
//
import Foundation

struct Transaction: Identifiable , Equatable {
    let id: UUID
    let amount: Double
    let type: TransactionType
    let title: String
    let description: String?
    let date: Date
    let categoryID: UUID?
    let categoryName: String?
    let categoryIcon: String?
    
    init(
        id: UUID,
        amount: Double,
        type: TransactionType,
        title: String,
        description: String?,
        date: Date,
        categoryID: UUID? = nil,
        categoryName: String? = nil,
        categoryIcon: String? = nil
    ) {
        self.id = id
        self.amount = amount
        self.type = type
        self.title = title
        self.description = description
        self.date = date
        self.categoryID = categoryID
        self.categoryName = categoryName
        self.categoryIcon = categoryIcon
    }
}
