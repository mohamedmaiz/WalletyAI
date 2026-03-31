//
//  CategoriesRepositoryImpl.swift
//  SpendInsight
//
//  Created by mac on 15/2/2026.
//

final class CategoriesRepositoryImpl: CategoriesRepository {
    let localDataSource: CategoriesLocalDataSource
    
    init(localDataSource: CategoriesLocalDataSource) {
        self.localDataSource = localDataSource
    }
    
    func fetchCategories() throws -> [Category]? {
        return try localDataSource
            .getCategories()?
            .map{(entity , transactionCount , totalAmount) in
                entity
                .toDomain(
                    transactionCount: transactionCount,
                    totalAmount: totalAmount
                )}.compactMap({ category in
                    category != nil ? category : nil
                })
    }

    func deleteCategory(_ category: Category) throws {
        try localDataSource.deleteCategory(category)
    }

    func addCategory(_ category: Category) throws -> Category{
        try localDataSource.saveCategory(category)
        return category
        
    }

    func updateCategory(_ category: Category) throws {
        
    }
    
}
