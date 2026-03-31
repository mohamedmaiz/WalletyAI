//
//  TransactionDaySection.swift
//  SpendInsight
//
//  Created by mac on 14/3/2026.
//
import Foundation

struct TransactionDaySection: Identifiable{
    let id: Date // start of day
    let date: Date
    let transactions: [Transaction]
}
