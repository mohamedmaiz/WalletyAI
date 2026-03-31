//
//  TransactionsLocalDataSourceImpl.swift
//  SpendInsight
//
//  Created by mac on 20/2/2026.
//

import CoreData
import Foundation

class TransactionsLocalDataSourceImpl: TransactionsLocalDataSource {
    let coreDataManaging: CoreDataManaging
    init(coreDataManaging: CoreDataManaging) {
        self.coreDataManaging = coreDataManaging
    }
    
    func fetchTransactions(limit: Int, offset: Int) throws -> [TransactionEntity] {
        let request = NSFetchRequest<TransactionEntity>(entityName: "TransactionEntity")
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        request.fetchLimit = limit
        request.fetchOffset = offset
        let transactions = try coreDataManaging.viewContext.fetch(request)
        return transactions
    }

    func addNewTransaction(transaction: Transaction) throws -> TransactionEntity {
        
        var category: CategoryEntity!
        if transaction.categoryID != nil {
            // Fetch category entity
            let request: NSFetchRequest<CategoryEntity> = CategoryEntity.fetchRequest()
            request.predicate = NSPredicate(
                format: "id == %@",
                transaction.categoryID! as CVarArg
            )
            request.fetchLimit = 1
            
            category = try? coreDataManaging.viewContext.fetch(request).first
        }
        
        let entity = TransactionEntity(context: coreDataManaging.viewContext)
        entity.id = UUID()
        entity.title = transaction.title
        entity.amount = transaction.amount
        entity.date = transaction.date
        entity.dsc = transaction.description
        entity.type = transaction.type == TransactionType.expense ? 0 : 1
        entity.category = category
        
        try coreDataManaging.viewContext.save()
        return entity
    }

    

    func updateTransaction(transaction: Transaction) throws -> TransactionEntity {
        // Fetch existing transaction by id
        let request: NSFetchRequest<TransactionEntity> = TransactionEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", transaction.id as CVarArg)
        request.fetchLimit = 1

        guard let existing = try coreDataManaging.viewContext.fetch(request).first else {
            throw NSError(domain: "TransactionsLocalDataSourceImpl", code: 404, userInfo: [NSLocalizedDescriptionKey: "Transaction not found"]) 
        }

        // Update fields
        existing.title = transaction.title
        existing.amount = transaction.amount
        existing.date = transaction.date
        existing.dsc = transaction.description
        existing.type = transaction.type == TransactionType.expense ? 0 : 1

        // Update category if provided, or clear if nil explicitly passed
        if let categoryID = transaction.categoryID {
            let catRequest: NSFetchRequest<CategoryEntity> = CategoryEntity.fetchRequest()
            catRequest.predicate = NSPredicate(format: "id == %@", categoryID as CVarArg)
            catRequest.fetchLimit = 1
            let category = try coreDataManaging.viewContext.fetch(catRequest).first
            existing.category = category
        } else {
            existing.category = nil
        }

        try coreDataManaging.viewContext.save()
        return existing
    }

    func deleteTransaction(transactionID: UUID) throws {
        let request: NSFetchRequest<TransactionEntity> = TransactionEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", transactionID as CVarArg)
        request.fetchLimit = 1

        guard let entity = try coreDataManaging.viewContext.fetch(request).first else {
            throw NSError(domain: "TransactionsLocalDataSourceImpl", code: 404, userInfo: [NSLocalizedDescriptionKey: "Transaction not found"]) 
        }

        coreDataManaging.viewContext.delete(entity)
        try coreDataManaging.viewContext.save()
    }
    
}
