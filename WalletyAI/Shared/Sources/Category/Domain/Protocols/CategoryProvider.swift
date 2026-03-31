//
//  CategoryProvider.swift
//  SpendInsight
//
//  Created by mac on 20/2/2026.
//

public protocol CategoryProvider {
    public func fetchCategories() throws -> [Category]?
}
