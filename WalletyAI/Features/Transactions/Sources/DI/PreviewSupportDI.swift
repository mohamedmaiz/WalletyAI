//
//  PreviewSupport.swift
//  SpendInsight
//
//  Created by mac on 14/3/2026.
//

extension TransactionDIContainer{
    // MARK: Preview Support View Models
    func makePreviewTransactionVM() -> TransactionListViewModel {
        let transactionRepo = MockTransactionRepository()
        return TransactionListViewModel(
            fetchTransactionsUseCase: FetchTransactionsUseCase(
                repo: transactionRepo
            ),
            observeTransactionsUseCase: ObserveTransactionsUseCase(
                repo: transactionRepo
            ),
            deleteTransactionUseCase: DeleteTransactionUseCase(
                repo: transactionRepo
            ),
            updateTransactionUseCase: UpdateTransactionUseCase(
                repo: transactionRepo
            )
        )
    }
    
    func makePreviewAddTransactionVM() -> AddTransactionViewModel {
        let transactionRepo = MockTransactionRepository()
        let categoryProvider = MockCategoryProvider()
        return AddTransactionViewModel(
            insertTransactionUseCase: InsertTransactionUseCase(
                repo: transactionRepo
            ),
            fetchCategoriesUseCase: FetchCategoriesUseCase(
                repo: categoryProvider
            )
        )
    }
}
