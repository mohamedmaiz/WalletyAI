//
//  EditTransactionViewModel.swift
//  SpendInsight
//
//  Created by mac on 10/3/2026.
//

import Combine
import Foundation

class EditTransactionViewModel: ObservableObject{
    let fetchCategoriesUseCase: FetchCategoriesUseCase
    let UpdateTransactionUseCase: UpdateTransactionUseCaseProtocol
    private let updateTransactionValidator = UpdateTransactionValidator()
    let transaction: Transaction
    
    init(
        fetchCategoriesUseCase: FetchCategoriesUseCase,
        UpdateTransactionUseCase: UpdateTransactionUseCaseProtocol,
        transaction: Transaction
    ) {
        self.fetchCategoriesUseCase = fetchCategoriesUseCase
        self.UpdateTransactionUseCase = UpdateTransactionUseCase
        self.transaction = transaction
        self.amount = String(transaction.amount)
        self.title = transaction.title
        self.selectedCategory = transaction.categoryID
        self.transactionType = transaction.type
        self.notes = transaction.description ?? ""
        self.date = transaction.date
        fetchCategories()
    }
    
    @Published var editTransactionState: ViewState<Bool> = .idle
    
    @Published var categoriesState: ViewState<[Category]> = .idle
    @Published var amount: String
    @Published var selectedCategory: UUID?
    @Published var transactionType: TransactionType
    @Published var title: String
    @Published var notes: String
    @Published var date: Date
    
    // Parsed amount helper
    private var parsedAmount: Double {
        Double(amount.replacingOccurrences(of: ",", with: ".")) ?? 0.0
    }
    
}


extension EditTransactionViewModel {
    
    func fetchCategories() {
        guard transaction.type == .expense else { return }
        
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
    
    func editTransaction(){
        
        if let error = updateTransactionValidator.Validate(
            currentTransaction: transaction,
            title: title,
            notes: notes,
            amount: parsedAmount,
            selectedCategory: selectedCategory,
            date: date
        ) {
            editTransactionState = .error(error)
            return
        }
        
        do{
            editTransactionState = .loading
            _ = try UpdateTransactionUseCase
                .execute(
                    Transaction(
                        id: transaction.id,
                        amount: parsedAmount,
                        type: transactionType,
                        title: title,
                        description: notes,
                        date: date,
                        categoryID: selectedCategory
                    )
                )
            editTransactionState = .data(true)
        }catch{
            editTransactionState = .error(error.localizedDescription)
        }
    }
}
