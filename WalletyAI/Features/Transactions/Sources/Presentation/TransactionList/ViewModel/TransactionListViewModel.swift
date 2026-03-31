//
//  TransactionViewModel.swift
//  SpendInsight
//
//  Created by mac on 24/2/2026.
//
import Combine
import Foundation

class TransactionListViewModel: ObservableObject {
    let fetchTransactionsUseCase: FetchTransactionsUseCaseProtocol
    let observeTransactionsUseCase: ObserveTransactionsUseCaseProtocol
    let deleteTransactionUseCase: DeleteTransactionUseCaseProtocol
    let updateTransactionUseCase: UpdateTransactionUseCaseProtocol
    private var observationTask: Task<Void, Never>?
    private var observation: AsyncStream<TransactionChange>?
    
    @Published var transactionState: ViewState<[Transaction]> = .idle
    @Published var deleteState: ViewState<Bool> = .idle
    
    // Group transactions by calendar day for dashboard display
    var daySections: [TransactionDaySection] {
        guard case .data(let transactions) = transactionState else { return [] }
        let calendar = Calendar.current
        let grouped = Dictionary(grouping: transactions) { (transaction: Transaction) -> Date in
            calendar.startOfDay(for: transaction.date)
        }
        let sections: [TransactionDaySection] = grouped.map { (key, value) in
            let sorted = value.sorted { $0.date > $1.date }
            return TransactionDaySection(id: key, date: key, transactions: sorted)
        }
        return sections.sorted { $0.date > $1.date }
    }

    init(
        fetchTransactionsUseCase: FetchTransactionsUseCaseProtocol,
        observeTransactionsUseCase: ObserveTransactionsUseCaseProtocol,
        deleteTransactionUseCase: DeleteTransactionUseCaseProtocol,
        updateTransactionUseCase: UpdateTransactionUseCaseProtocol
    ) {
        self.fetchTransactionsUseCase = fetchTransactionsUseCase
        self.observeTransactionsUseCase = observeTransactionsUseCase
        self.deleteTransactionUseCase = deleteTransactionUseCase
        self.updateTransactionUseCase = updateTransactionUseCase
        
        // MARK: Init Transaction List view model
        fetchTransactions()
        observationTask = Task {
           await observeTransactionChanges()
        }
        
    }
    
    deinit {
        observationTask?.cancel()
    }
    
}


extension TransactionListViewModel {
    func observeTransactionChanges() async {
        for await changes in observeTransactionsUseCase.observeTransactionChange() {
            var data = transactionState.data ?? []
            switch changes {
            case .inserted(let transaction):
                let index = data.insertionIndex(for: transaction)
                data.insert(transaction, at: index)
                data.sort { $0.date > $1.date }
                transactionState = .data(data)
            case .updated(let transaction):
                if let index = data.firstIndex(where: {$0.id == transaction.id}) {
                    data[index] = transaction
                }
                data.sort { $0.date > $1.date }
                transactionState = .data(data)
            case .deleted(let id) :
                data.removeAll(where: {$0.id == id})
                data.sort { $0.date > $1.date }
                transactionState = .data(data)
            }
        }
    }
   
    func fetchTransactions() {
        do {
            transactionState = .loading
            let transactions = try fetchTransactionsUseCase.execute(
                limit: 100,
                offset: transactionState.data?.count ?? 0
            )
            if let transactions = transactions {
                transactionState = .data(transactions)
            }else {
                transactionState = .empty
            }
            
        }catch{
            transactionState = .error(error.localizedDescription)
        }
    }
    
    func deleteTransaction(id: UUID) {
        
        do{
            deleteState = .loading
            try deleteTransactionUseCase.execute(id: id)
            deleteState = .data(true)
        }catch {
            deleteState = .error(error.localizedDescription)
        }
    }
    
    func resetDeleteState() {
        deleteState = .idle
    }
}
