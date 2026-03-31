//
//  TransactionError.swift
//  SpendInsight
//
//  Created by mac on 1/3/2026.
//

import Foundation

enum TransactionValidationError: LocalizedError, Equatable {
    case emptyTitle
    case invalidAmount
    case futureDateNotAllowed
    case missingCategory
    case noChangesDetected

    var errorDescription: String? {
        switch self {
        case .emptyTitle:
            return "Title cannot be empty"
        case .invalidAmount:
            return "Amount must be greater than zero"
        case .futureDateNotAllowed:
            return "Date cannot be in the future"
        case .missingCategory:
            return "Please select a category"
        case .noChangesDetected:
            return "No changes detected to update."
        }
    }
}
