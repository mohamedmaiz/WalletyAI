//
//  CategoriesViewModel.swift
//  SpendInsight
//
//  Created by mac on 15/2/2026.
//
import Foundation
import Combine


final class CategoriesViewModel: ObservableObject {
    let addCategoryUseCase: AddCategoryUseCase
    let fetchCategoriesUseCase: FetchCategoriesUseCase
    let deleteCategoryUseCase: DeleteCategoryUseCase
    
    init(
        addCategoryUseCase: AddCategoryUseCase,
        fetchCategoriesUseCase: FetchCategoriesUseCase,
        deleteCategoryUseCase: DeleteCategoryUseCase
    ) {
        self.addCategoryUseCase = addCategoryUseCase
        self.fetchCategoriesUseCase = fetchCategoriesUseCase
        self.deleteCategoryUseCase = deleteCategoryUseCase
    }
    
    @Published var categoriesState: ViewState<[Category]> = .idle
    @Published var categoryActionState: ViewState<Bool> = .idle
}



extension CategoriesViewModel {
    func fetchCategories() {
        categoriesState = .loading
        do{
            let data = try fetchCategoriesUseCase.execute()
            
            if (data?.count ?? 0) > 0{
                categoriesState = .data(data!)
            } else {
                categoriesState = .empty
            }
        }
        catch {
            categoriesState = .error(error.localizedDescription)
        }
    }
    
    func addCategory(name: String , color: String? , icon: String?) {
        
        if name.count == 0 {
            categoryActionState = .error("Category name must be not nil")
            return
        }
        
        guard let color = color , let icon = icon else {
            categoryActionState = .error("Complete all fields")
            return
        }
        
        do{
            categoryActionState = .loading
            let category = try addCategoryUseCase.execute(name: name, icon: icon, color: color)
            if categoriesState.isData {
                var newData = categoriesState.data
                newData?.append(category)
                categoriesState = .data(newData ?? [])
            }else{
                categoriesState = .data([category])
            }
            categoryActionState = .data(true)
        }catch{
            categoryActionState = .error(error.localizedDescription)
        }
    }
    
    
    func deleteCategory(category: Category) {
        categoryActionState = .loading
        do{
            try deleteCategoryUseCase.execute(category: category)
            var data = categoriesState.data
            data?.removeAll { $0.id == category.id }
            if data != nil && (data?.count ?? 0) > 0 {
                categoriesState = .data(data ?? [])
            }else{
                categoriesState = .empty
            }
            
        }catch{
            categoryActionState = .error(error.localizedDescription)
        }
        
    }
}
