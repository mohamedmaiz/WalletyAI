//
//  CategoryEntityMapper.swift
//  SpendInsight
//
//  Created by mac on 15/2/2026.
//

extension CategoryEntity {
    func toDomain(transactionCount: Int , totalAmount: Double) -> Category? {
        guard let id = id else {return nil}
        return .init(
            id: id,
            name: name ?? "",
            color: color ?? "",
            icon: icon ?? "",
            totalSpending: totalAmount,
            transactionCount: transactionCount
        )
    }
}
