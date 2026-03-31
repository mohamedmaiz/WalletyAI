//
//  MockFetchCategories.swift
//  SpendInsight
//
//  Created by mac on 23/2/2026.
//
import Foundation

class MockCategoryProvider: CategoryProvider {
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

    
}
