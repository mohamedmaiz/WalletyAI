//
//  RecurringInput.swift
//  SpendInsight
//
//  Created by mac on 16/3/2026.
//

import Foundation

public struct RecurringInput: Sendable {
    public var title: String
    public var amount: Float
    public var type: TransactionType
    public var frequency: Frequency
    public var frequencyRule: FrequencyRule?
    public var startDate: Date
    public var nextExcutionDate: Date
    public var endType: EndType
    public var endDate: Date?
    public var endCount: Int
    public var isSubscription: Bool
    public var note: String?
    public var categoryId: UUID?

    public init(
        title: String,
        amount: Float,
        type: TransactionType,
        frequency: Frequency,
        frequencyRule: FrequencyRule?,
        startDate: Date,
        nextExcutionDate: Date,
        endType: EndType,
        endDate: Date?,
        endCount: Int,
        isSubscription: Bool,
        note: String?,
        categoryId: UUID?
    ) {
        self.title = title
        self.amount = amount
        self.type = type
        self.frequency = frequency
        self.frequencyRule = frequencyRule
        self.startDate = startDate
        self.nextExcutionDate = nextExcutionDate
        self.endType = endType
        self.endDate = endDate
        self.endCount = endCount
        self.isSubscription = isSubscription
        self.note = note
        self.categoryId = categoryId
    }
}
