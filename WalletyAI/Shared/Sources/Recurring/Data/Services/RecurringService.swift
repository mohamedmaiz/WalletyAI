////
////  d.swift
////  SpendInsight
////
////  Created by mac on 16/3/2026.
////
//
//import Foundation
//import CoreData
//
//public final class RecurringService: RecurringServiceProtocol {
//    private let context: NSManagedObjectContext
//
//    public init(context: NSManagedObjectContext) {
//        self.context = context
//    }
//
//    // MARK: - CRUD
//    public func add(input: RecurringInput) throws {
//        let entity = RecurringEntity(context: context)
//        RecurringMapper.applyCreate(input, into: entity, in: context)
//        try context.save()
//    }
//
//    public func update(id: UUID, input: RecurringInput) throws {
//        guard let entity = try fetchEntity(id: id) else { throw NSError(domain: "RecurringService", code: 404, userInfo: [NSLocalizedDescriptionKey: "Recurring not found"]) }
//        RecurringMapper.applyUpdate(input, into: entity, in: context)
//        try context.save()
//    }
//
//    public func delete(id: UUID) throws {
//        guard let entity = try fetchEntity(id: id) else { return }
//        context.delete(entity)
//        try context.save()
//    }
//
//    public func pause(id: UUID) throws {
//        guard let entity = try fetchEntity(id: id) else { return }
//        entity.status = RecurringStatus.paused.rawValue
//        try context.save()
//    }
//
//    public func resume(id: UUID) throws {
//        guard let entity = try fetchEntity(id: id) else { return }
//        entity.status = RecurringStatus.active.rawValue
//        try context.save()
//    }
//
//    public func fetchAll() throws -> [RecurringModel] {
//        let req: NSFetchRequest<RecurringEntity> = RecurringEntity.fetchRequest()
//        req.predicate = NSPredicate(format: "is_subscription == NO")
//        let items = try context.fetch(req)
//        return items.map{$0.toModel()}
//    }
//
//    public func fetchSubscriptions() throws -> [RecurringModel] {
//        let req: NSFetchRequest<RecurringEntity> = RecurringEntity.fetchRequest()
//        req.predicate = NSPredicate(format: "is_subscription == YES")
//        let items = try context.fetch(req)
//        return items.map{$0.toModel()}
//    }
//
//    // MARK: - Processing
//    public func process() throws {
//        let today = Date()
//        let req: NSFetchRequest<RecurringEntity> = RecurringEntity.fetchRequest()
//        req.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
//            NSPredicate(format: "status == %d", RecurringStatus.active.rawValue),
//            NSPredicate(format: "nextExcutionDate <= %@", today as NSDate)
//        ])
//        let recurrings = try context.fetch(req)
//
//        for recurring in recurrings {
//            guard var next = recurring.nextExcutionDate else { continue }
//            while next <= today {
//                // stopping conditions
//                if shouldStop(recurring: recurring, next: next) { break }
//
//                // create transaction
//                let txn = TransactionEntity(context: context)
//                txn.id = UUID()
//                txn.title = recurring.title
//                txn.amount = recurring.amount
//                txn.date = next
//                txn.type = recurring.type
//                txn.category = recurring.parentCategory
//                txn.recurring = recurring
//                
//                // increment counts
//                recurring.occurrencesCount += 1
//
//                // advance date
//                let rule = FrequencyRule.fromJSON(recurring.frequencyRule)
//                next = nextDate(from: next, frequency: Frequency(rawValue: recurring.frequency) ?? .daily, rule: rule)
//                recurring.nextExcutionDate = next
//            }
//        }
//
//        if context.hasChanges { try context.save() }
//    }
//
//    // MARK: - Helpers
//    private func fetchEntity(id: UUID) throws -> RecurringEntity? {
//        let req: NSFetchRequest<RecurringEntity> = RecurringEntity.fetchRequest()
//        req.fetchLimit = 1
//        req.predicate = NSPredicate(format: "id == %@", id as CVarArg)
//        return try context.fetch(req).first
//    }
//
//    private func shouldStop(recurring: RecurringEntity, next: Date) -> Bool {
//        let endType = EndType(rawValue: recurring.endType) ?? .forever
//        switch endType {
//        case .forever:
//            return false
//        case .endDate:
//            if let end = recurring.endDate { return next > end }
//            return false
//        case .count:
//            return recurring.occurrencesCount >= recurring.endCount
//        }
//    }
//
//    // Next date logic
//    public func nextDate(from date: Date, frequency: Frequency, rule: FrequencyRule?) -> Date {
//        let calendar = Calendar.current
//        switch frequency {
//        case .daily:
//            return calendar.date(byAdding: .day, value: 1, to: date) ?? date
//        case .weekly:
//            let days = (rule?.daysOfWeek ?? []).sorted()
//            return nextWeeklyDate(from: date, daysOfWeek: days)
//        case .monthly:
//            let days = (rule?.daysOfMonth ?? []).sorted()
//            return nextMonthlyDate(from: date, daysOfMonth: days)
//        case .yearly:
//            let pairs = (rule?.monthDayPairs ?? []).sorted { a, b in
//                if a.month == b.month { return a.day < b.day }
//                return a.month < b.month
//            }
//            return nextYearlyDate(from: date, pairs: pairs)
//        }
//    }
//
//    private func nextWeeklyDate(from date: Date, daysOfWeek: [Int]) -> Date {
//        let calendar = Calendar.current
//        guard !daysOfWeek.isEmpty else { return calendar.date(byAdding: .day, value: 7, to: date) ?? date }
//        let currentWeekday = calendar.component(.weekday, from: date) // 1..7
//        for offset in 1...14 { // look ahead up to 2 weeks to be safe
//            let cand = calendar.date(byAdding: .day, value: offset, to: date) ?? date
//            let wd = calendar.component(.weekday, from: cand)
//            if daysOfWeek.contains(wd) { return cand }
//        }
//        return calendar.date(byAdding: .day, value: 7, to: date) ?? date
//    }
//
//    private func nextMonthlyDate(from date: Date, daysOfMonth: [Int]) -> Date {
//        let calendar = Calendar.current
//        guard !daysOfMonth.isEmpty else { return calendar.date(byAdding: .month, value: 1, to: date) ?? date }
//        let sortedDays = daysOfMonth.sorted()
//        let day = calendar.component(.day, from: date)
//        let month = calendar.component(.month, from: date)
//        let year = calendar.component(.year, from: date)
//
//        // Try remaining days in current month
//        if let nextDay = sortedDays.first(where: { $0 > day }) {
//            var comps = DateComponents(year: year, month: month, day: min(nextDay, 28))
//            // Use nextDay but clamp if month shorter; then move forward until valid
//            if let candidate = calendar.date(from: comps) {
//                return adjustToValidDay(candidate, desiredDay: nextDay)
//            }
//        }
//        // Move to next month and pick first day
//        let nextMonthDate = calendar.date(byAdding: .month, value: 1, to: date) ?? date
//        let ny = calendar.component(.year, from: nextMonthDate)
//        let nm = calendar.component(.month, from: nextMonthDate)
//        let firstDay = sortedDays.first ?? 1
//        var comps = DateComponents(year: ny, month: nm, day: min(firstDay, 28))
//        if let candidate = calendar.date(from: comps) {
//            return adjustToValidDay(candidate, desiredDay: firstDay)
//        }
//        return nextMonthDate
//    }
//
//    private func adjustToValidDay(_ date: Date, desiredDay: Int) -> Date {
//        let calendar = Calendar.current
//        var cand = date
//        var comps = calendar.dateComponents([.year, .month, .day], from: cand)
//        let range = calendar.range(of: .day, in: .month, for: cand) ?? 1...28
//        comps.day = min(desiredDay, range.upperBound - 1)
//        cand = calendar.date(from: comps) ?? cand
//        return cand
//    }
//
//    private func nextYearlyDate(from date: Date, pairs: [MonthDay]) -> Date {
//        let calendar = Calendar.current
//        guard !pairs.isEmpty else { return calendar.date(byAdding: .year, value: 1, to: date) ?? date }
//        let year = calendar.component(.year, from: date)
//        let month = calendar.component(.month, from: date)
//        let day = calendar.component(.day, from: date)
//
//        // Try remaining pairs in current year
//        for pair in pairs {
//            if pair.month > month || (pair.month == month && pair.day > day) {
//                var comps = DateComponents(year: year, month: pair.month, day: min(pair.day, 28))
//                if let candidate = calendar.date(from: comps) {
//                    return adjustToValidDay(candidate, desiredDay: pair.day)
//                }
//            }
//        }
//        // Next year first pair
//        let nextYear = year + 1
//        let first = pairs.first!
//        var comps = DateComponents(year: nextYear, month: first.month, day: min(first.day, 28))
//        if let candidate = calendar.date(from: comps) {
//            return adjustToValidDay(candidate, desiredDay: first.day)
//        }
//        return calendar.date(byAdding: .year, value: 1, to: date) ?? date
//    }
//}
