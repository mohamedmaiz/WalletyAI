//
//  TransactionsRepositoryImpl.swift
//  SpendInsight
//
//  Created by mac on 20/2/2026.
//
import Foundation

final class TransactionsRepositoryImpl: TransactionRepository {
    
    private let local: TransactionsLocalDataSource
    private var continuationStore = ContinuationStore()
    
    
    init(local: TransactionsLocalDataSource) {
        self.local = local
    }
    
  
    
   
    
    func observeTransactionChange() -> AsyncStream<TransactionChange> {
        AsyncStream { continuation in
            
            let id = UUID()
            
            Task {
                await continuationStore.add(continuation, id: id)
            }
            
            continuation.onTermination = { _ in
                Task {
                    await self.continuationStore.remove(id: id)
                }
            }
        }
    }
    
    func fetchTransactions(limit: Int, offset: Int) throws -> [Transaction]? {
        return try local
            .fetchTransactions(limit: limit, offset: offset)
            .map{$0.toDomain()}
            .compactMap({ transaction in
            transaction != nil ? transaction : nil
        })
    }

    func addNewTransaction(transaction: Transaction ) throws -> Transaction {
       let entity = try local
            .addNewTransaction(
                transaction: transaction
            )
        Task{
            if let entity = entity.toDomain()  {
                await continuationStore.yield(.inserted(entity))
            }else{
                throw NSError(domain: "Error", code: 0, userInfo: nil)
            }
            
        }
        return transaction
    }

    func deleteTransaction(id: UUID) throws {
        try local.deleteTransaction(transactionID: id)
        Task{
            await continuationStore.yield(.deleted(id))
        }
    }

    func updateTransaction(transaction: Transaction) throws {
       let entity =  try local
            .updateTransaction(
                transaction: transaction
            )
        Task{
            if let entity = entity.toDomain()  {
                await continuationStore.yield(.updated(entity))
            }else{
                throw NSError(domain: "Error", code: 0, userInfo: nil)
            }
            
        }
        
    }

    
}


actor ContinuationStore {
    
    private var continuations: [UUID: AsyncStream<TransactionChange>.Continuation] = [:]
    
    func add(_ continuation: AsyncStream<TransactionChange>.Continuation, id: UUID) {
        continuations[id] = continuation
    }
    
    func remove(id: UUID) {
        continuations.removeValue(forKey: id)
    }
    
    func yield(_ change: TransactionChange) {
        for continuation in continuations.values {
            continuation.yield(change)
        }
    }
}
