//
//  CategoriesRepository.swift
//  SpendInsight
//
//  Created by mac on 14/2/2026.
//

public protocol CategoriesRepository: CategoryProvider {
    public func deleteCategory(_ category: Category) throws
    public func addCategory(_ category: Category) throws -> Category
    public func updateCategory(_ category: Category) throws
}
