//
//  TransactionChange.swift
//  SpendInsight
//
//  Created by mac on 28/2/2026.
//
import Foundation

enum TransactionChange{
    case inserted(Transaction)
    case deleted(UUID)
    case updated(Transaction)
}
