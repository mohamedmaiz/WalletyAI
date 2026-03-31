//
//  CategoriesDIContainer.swift
//  SpendInsight
//
//  Created by mac on 15/2/2026.
//

class CategoriesDIContainer {
    private let fetchCategoriesUseCase: FetchCategoriesUseCase
    private let  addCategoryUseCase: AddCategoryUseCase
    private let  deleteCategoryUseCase: DeleteCategoryUseCase
    
    init(
        fetchCategoriesUseCase: FetchCategoriesUseCase,
        addCategoryUseCase: AddCategoryUseCase,
        deleteCategoryUseCase: DeleteCategoryUseCase
    ) {
        self.fetchCategoriesUseCase = fetchCategoriesUseCase
        self.addCategoryUseCase = addCategoryUseCase
        self.deleteCategoryUseCase = deleteCategoryUseCase
    }
    
    func makeCategoriesVM() -> CategoriesViewModel {
        let vm = CategoriesViewModel(
            addCategoryUseCase: addCategoryUseCase,
            fetchCategoriesUseCase: fetchCategoriesUseCase,
            deleteCategoryUseCase: deleteCategoryUseCase
        )
        return vm
    }
    
}
