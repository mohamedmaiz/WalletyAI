//
//  MockCategoriesRepository.swift
//  SpendInsight
//
//  Created by mac on 17/2/2026.
//
import Foundation

class MockCategoriesRepository: CategoriesRepository{
    func fetchCategories() throws -> [Category]? {
        return [
            .init(
                id: UUID(),
                name: "Mock Category 1",
                color: "#4F46E5",
                icon: "home" ,
                totalSpending: 2400,
                transactionCount: 23
                
            ),
            .init(id: UUID(),
                  name: "Mock Category 2",
                  color: "#F59E0B",
                  icon: "saving",
                  totalSpending: 4200,
                  transactionCount: 33 ,
                  ),
            .init(id: UUID(),
                  name: "Mock Category 2",
                  color: "#10B981",
                  icon: "animal" ,
                  totalSpending: 5000,
                  transactionCount: 12
                  )
        ]
    }
    
    func deleteCategory(_ category: Category) throws {
        return
    }
    
    func addCategory(_ category: Category) throws -> Category {
        return category
    }
    
    func updateCategory(_ category: Category) throws {
        return
    }
    
    
}
