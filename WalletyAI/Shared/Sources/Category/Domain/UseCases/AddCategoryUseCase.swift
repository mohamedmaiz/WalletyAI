//
//  AddCategoryUseCase.swift
//  SpendInsight
//
//  Created by mac on 14/2/2026.
//
import Foundation

final class AddCategoryUseCase {
    let repo: CategoriesRepository
    init(repo: CategoriesRepository) {
        self.repo = repo
    }
    
    func execute(name: String , icon: String , color: String) throws -> Category {
        let entity = Category(
            id: UUID(),
            name: name,
            color: color,
            icon: icon,
            totalSpending: 0,
            transactionCount: 0
        )
        return try repo.addCategory(entity)
    }
}
