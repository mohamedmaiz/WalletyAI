//
//  UpdateTransactionValidator.swift
//  SpendInsight
//
//  Created by mac on 10/3/2026.
//

import Foundation

struct UpdateTransactionValidator {
    
    func Validate(currentTransaction: Transaction ,title: String , notes: String , amount: Double , selectedCategory: UUID? , date: Date ) -> String? {
        
        if title.trimmingCharacters(in: .whitespaces).isEmpty {
            return TransactionValidationError.emptyTitle.errorDescription
        }
        
        if amount <= 0 {
            return TransactionValidationError.invalidAmount.errorDescription
        }
        
        if date > Date() {
            return TransactionValidationError.futureDateNotAllowed.errorDescription
        }
        
        // TODO: Ensure TransactionValidationError.noChangesDetected is defined to represent unchanged update data
        // Ensure new data differs from current transaction
        let trimmedTitle = title.trimmingCharacters(in: .whitespaces)
        let trimmedNotes = notes.trimmingCharacters(in: .whitespaces)
        let sameTitle = trimmedTitle == currentTransaction.title.trimmingCharacters(in: .whitespaces)
        let sameNotes = trimmedNotes == (currentTransaction.description ?? "").trimmingCharacters(
            in: .whitespaces
        )
        let sameAmount = amount == currentTransaction.amount
        let sameCategory = selectedCategory == currentTransaction.categoryID
        let sameDate = Calendar.current.isDate(date, inSameDayAs: currentTransaction.date)
        if sameTitle && sameNotes && sameAmount && sameCategory && sameDate {
            return TransactionValidationError.noChangesDetected.errorDescription
        }
        
        return nil
        
    }
}

