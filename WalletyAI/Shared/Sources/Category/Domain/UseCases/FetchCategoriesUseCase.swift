//
//  FetchCategoriesUseCase.swift
//  SpendInsight
//
//  Created by mac on 14/2/2026.
//

final class FetchCategoriesUseCase {
    let repo: CategoryProvider
    init(repo: CategoryProvider) {
        self.repo = repo
    }
    
    func execute() throws -> [Category]? {
        return try repo.fetchCategories()
    }
}
