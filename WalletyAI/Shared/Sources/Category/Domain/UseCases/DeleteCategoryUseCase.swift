//
//  DeleteCategoryUseCase.swift
//  SpendInsight
//
//  Created by mac on 14/2/2026.
//

final class DeleteCategoryUseCase {
    let repo: CategoriesRepository
    init(repo: CategoriesRepository) {
        self.repo = repo
    }
    
    func execute(category: Category) throws {
        try repo.deleteCategory(category)
    }
}
