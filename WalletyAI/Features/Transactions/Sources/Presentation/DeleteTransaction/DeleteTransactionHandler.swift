//
//  DeleteTransactionViewModel.swift
//  SpendInsight
//
//  Created by mac on 10/3/2026.
//
import Combine
import Foundation

class DeleteTransactionHandler: ObservableObject {
    let deleteTransactionUseCase: DeleteTransactionUseCaseProtocol
    @Published var state: ViewState<Bool> = .idle
    
    private var cachedTransaction: Transaction?
    
    init(
        deleteTransactionUseCase: DeleteTransactionUseCaseProtocol
    ) {
        self.deleteTransactionUseCase = deleteTransactionUseCase
    }
}

extension DeleteTransactionHandler {
    func onDelete(transaction: Transaction) {
         do {
             state = .loading
             cachedTransaction = transaction
             try deleteTransactionUseCase.execute(id: transaction.id)
             state = .data(true)
         } catch{
             state = .error(error.localizedDescription)
         }
    }
    
    func clearState() {
        cachedTransaction = nil
        state = .idle
    }
}
