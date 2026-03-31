//
//  sa.swift
//  SpendInsight
//
//  Created by mac on 16/3/2026.
//
import Foundation

public struct RecurringModel: Identifiable, Equatable, Sendable {
    public var id: UUID
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
    public var occurrencesCount: Int
    public var status: RecurringStatus
    public var isSubscription: Bool
    public var note: String?
    public var categoryId: UUID? // reference to CategoryEntity if needed

    public init(
        id: UUID,
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
        occurrencesCount: Int,
        status: RecurringStatus,
        isSubscription: Bool,
        note: String?,
        categoryId: UUID?
    ) {
        self.id = id
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
        self.occurrencesCount = occurrencesCount
        self.status = status
        self.isSubscription = isSubscription
        self.note = note
        self.categoryId = categoryId
    }
}

public struct MonthDay: Codable, Equatable, Sendable {
    public let month: Int // 1-12
    public let day: Int   // 1-31
    public init(month: Int, day: Int) { self.month = month; self.day = day }
}

public struct FrequencyRule: Codable, Equatable, Sendable {
    public var daysOfWeek: [Int]?       // 1–7
    public var daysOfMonth: [Int]?      // 1–31
    public var monthDayPairs: [MonthDay]? // month/day pairs

    public init(daysOfWeek: [Int]? = nil, daysOfMonth: [Int]? = nil, monthDayPairs: [MonthDay]? = nil) {
        self.daysOfWeek = daysOfWeek
        self.daysOfMonth = daysOfMonth
        self.monthDayPairs = monthDayPairs
    }
}

public extension FrequencyRule {
    // MARK: JSON helpers
    func toJSON() -> String? {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        guard let data = try? encoder.encode(self) else { return nil }
        return String(data: data, encoding: .utf8)
    }

    static func fromJSON(_ json: String?) -> FrequencyRule? {
        guard let json = json, let data = json.data(using: .utf8) else { return nil }
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try? decoder.decode(FrequencyRule.self, from: data)
    }
}
