//
//  BinarySearch+Insetion.swift
//  SpendInsight
//
//  Created by mac on 1/3/2026.
//

extension Array where Element == Transaction {
    func insertionIndex(for transaction: Transaction) -> Int {
        var low = 0
        var high = count

        while low < high {
            let mid = (low + high) / 2
            if self[mid].date > transaction.date {
                low = mid + 1
            } else {
                high = mid
            }
        }
        return low
    }
}
