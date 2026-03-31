//
//  InsertTransactionValidator.swift
//  SpendInsight
//
//  Created by mac on 1/3/2026.
//
import Foundation

struct InsertTransactionValidator {
    
    func Validate(title: String , amount: Double , date: Date ) -> String? {
        
        if title.trimmingCharacters(in: .whitespaces).isEmpty {
            return TransactionValidationError.emptyTitle.errorDescription
        }
        
        if amount <= 0 {
            return TransactionValidationError.invalidAmount.errorDescription
        }
        
        if date > Date() {
            return TransactionValidationError.futureDateNotAllowed.errorDescription
        }
        
        return nil
        
    }
}

