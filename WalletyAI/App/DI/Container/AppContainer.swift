//
//  AppContainer.swift
//  SpendInsight
//
//  Created by mac on 21/2/2026.
//

final class AppContainer {
    
    static let preview = AppContainer(
        coreDataManaging: CoreDataStack(inMemory: true)
    )
    
    init(coreDataManaging: CoreDataManaging) {
        self.coreDataManaging = coreDataManaging
    }
    
    var coreDataManaging: CoreDataManaging

    // MARK: Shared Local Data Sources
    lazy var categoryLocal: CategoriesLocalDataSource = CategoriesLocalDataSourceImpl(
        coreDataManaging: coreDataManaging
    )
    
    lazy var transactionLocal: TransactionsLocalDataSource = TransactionsLocalDataSourceImpl(
        coreDataManaging: coreDataManaging
    )
    
    
    // MARK: Shared Repositories
    lazy var categoryRepository: CategoriesRepository = CategoriesRepositoryImpl(
        localDataSource: categoryLocal
    )
    lazy var transactionRepository: TransactionRepository = TransactionsRepositoryImpl(
        local: transactionLocal
    )
    
    
    // MARK: Category UseCases
    lazy var fetchCategoriesUseCase: FetchCategoriesUseCase = FetchCategoriesUseCase(
        repo: categoryRepository
    )
    lazy var addCategoryUseCase: AddCategoryUseCase = AddCategoryUseCase(repo: categoryRepository)
    lazy var deleteCategoryUseCase: DeleteCategoryUseCase = DeleteCategoryUseCase(repo: categoryRepository)
    
    // MARK: Transaction UseCases
    lazy var fetchTransactionUseCase: FetchTransactionsUseCaseProtocol  = FetchTransactionsUseCase(repo: transactionRepository)
    lazy var insertTransactionUseCase: InsertTransactionUseCaseProtocol = InsertTransactionUseCase(repo: transactionRepository)
    lazy var deleteTransactionUseCase: DeleteTransactionUseCaseProtocol = DeleteTransactionUseCase(
        repo: transactionRepository
    )
    lazy var updateTransactionUseCase: UpdateTransactionUseCaseProtocol = UpdateTransactionUseCase(repo: transactionRepository)
    lazy var observeTransactionsUseCase: ObserveTransactionsUseCaseProtocol = ObserveTransactionsUseCase(
        repo: transactionRepository
    )
    
    
}

extension AppContainer {
    func makeCategoryFeature() -> CategoriesDIContainer {
        CategoriesDIContainer(
            fetchCategoriesUseCase: fetchCategoriesUseCase,
            addCategoryUseCase: addCategoryUseCase,
            deleteCategoryUseCase: deleteCategoryUseCase
        )
    }
    
    func makeTransactionFeature() -> TransactionDIContainer {
        TransactionDIContainer(
            fetchTransactions: fetchTransactionUseCase,
            insertTransaction: insertTransactionUseCase,
            fetchCategories: fetchCategoriesUseCase,
            observeTransactionsUseCase: observeTransactionsUseCase,
            deleteTransactionUseCase: deleteTransactionUseCase,
            updateTransactionUseCase: updateTransactionUseCase
        )
    }
}
