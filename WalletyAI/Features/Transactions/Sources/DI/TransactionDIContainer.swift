//
//  TransactionDIContainer.swift
//  SpendInsight
//
//  Created by mac on 20/2/2026.
//

class TransactionDIContainer {
    let fetchTransactions: FetchTransactionsUseCaseProtocol
    let insertTransaction: InsertTransactionUseCaseProtocol
    let fetchCategories: FetchCategoriesUseCase
    let observeTransactionsUseCase: ObserveTransactionsUseCaseProtocol
    let deleteTransactionUseCase: DeleteTransactionUseCaseProtocol
    let updateTransactionUseCase: UpdateTransactionUseCaseProtocol
    
    init(
        fetchTransactions: FetchTransactionsUseCaseProtocol,
        insertTransaction: InsertTransactionUseCaseProtocol,
        fetchCategories: FetchCategoriesUseCase,
        observeTransactionsUseCase: ObserveTransactionsUseCaseProtocol,
        deleteTransactionUseCase: DeleteTransactionUseCaseProtocol,
        updateTransactionUseCase: UpdateTransactionUseCaseProtocol
    ) {
        self.fetchTransactions = fetchTransactions
        self.insertTransaction = insertTransaction
        self.fetchCategories = fetchCategories
        self.observeTransactionsUseCase = observeTransactionsUseCase
        self.deleteTransactionUseCase = deleteTransactionUseCase
        self.updateTransactionUseCase = updateTransactionUseCase
    }
    
    // MARK: build View Models
    func  makeTransactionVM() -> TransactionListViewModel {
        TransactionListViewModel(
            fetchTransactionsUseCase: fetchTransactions ,
            observeTransactionsUseCase: observeTransactionsUseCase,
            deleteTransactionUseCase: deleteTransactionUseCase,
            updateTransactionUseCase: updateTransactionUseCase
        )
    }
    
    func  makeAddTransactionVM() -> AddTransactionViewModel {
        AddTransactionViewModel(
            insertTransactionUseCase: insertTransaction,
            fetchCategoriesUseCase: fetchCategories,
        )
    }
    
    func  makeEditTransactionVM(transaction: Transaction) -> EditTransactionViewModel {
        EditTransactionViewModel(
            fetchCategoriesUseCase: fetchCategories,
            UpdateTransactionUseCase: updateTransactionUseCase,
            transaction: transaction
        )
    }
    
    func makeDeleteTransactionHandler() -> DeleteTransactionHandler {
        DeleteTransactionHandler(
            deleteTransactionUseCase: deleteTransactionUseCase
        )
    }
    
}


