//
//  TransactionEntityMapper.swift
//  SpendInsight
//
//  Created by mac on 20/2/2026.
//
import Foundation

extension TransactionEntity {
    func toDomain() -> Transaction? {
        guard let id = id else {return nil}
        return .init(
            id: id,
            amount: amount,
            type: type == 0 ? .expense : .income,
            title: title ?? "",
            description: dsc,
            date: date ?? Date(),
            categoryID: category?.id,
            categoryName: category?.name,
            categoryIcon: category?.icon
        )
    }
}
