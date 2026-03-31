//
//  CategoriesLocalDataSource.swift
//  SpendInsight
//
//  Created by mac on 14/2/2026.
//

protocol CategoriesLocalDataSource {
    func saveCategory(_ category: Category) throws
    func getCategories() throws -> [(category: CategoryEntity , transactionCount: Int , totalAmount: Double)]?
    func deleteCategory(_ category: Category) throws
    func updateCategory(_ category: Category) throws
    func deleteAllCategories() throws
}
