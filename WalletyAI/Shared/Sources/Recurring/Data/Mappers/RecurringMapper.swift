//
//  sd.swift
//  SpendInsight
//
//  Created by mac on 16/3/2026.
//
import Foundation
import CoreData

extension RecurringEntity {
    // Entity -> Model
    func toModel() -> RecurringModel {
        let frequency = Frequency(rawValue: frequency) ?? .daily
        let endType = EndType(rawValue: endType) ?? .forever
        let status = RecurringStatus(rawValue: status) ?? .active
        let type = TransactionType(rawValue: type) ?? .expense
        let rule = FrequencyRule.fromJSON(frequencyRule)
        let categoryId = (parentCategory?.value(forKey: "id") as? UUID)
        return RecurringModel(
            id: id ?? UUID(),
            title: title ?? "",
            amount: amount,
            type: type,
            frequency: frequency,
            frequencyRule: rule,
            startDate: startDate ?? Date(),
            nextExcutionDate: nextExcutionDate ?? Date(),
            endType: endType,
            endDate: endDate,
            endCount: Int(endCount),
            occurrencesCount: Int(occurrencesCount),
            status: status,
            isSubscription: is_subscription,
            note: note,
            categoryId: categoryId
        )
    }
    
    func applyCreate(_ input: RecurringInput, into entity: RecurringEntity, in context: NSManagedObjectContext) {
        entity.id = UUID()
        entity.title = input.title
        entity.amount = input.amount
        entity.type = input.type.rawValue
        entity.frequency = input.frequency.rawValue
        entity.frequencyRule = input.frequencyRule?.toJSON()
        entity.startDate = input.startDate
        entity.nextExcutionDate = input.nextExcutionDate
        entity.endType = input.endType.rawValue
        entity.endDate = input.endDate
        entity.endCount = Int16(input.endCount)
        entity.occurrencesCount = 0
        entity.status = RecurringStatus.active.rawValue
        entity.is_subscription = input.isSubscription
        entity.note = input.note
        if let catId = input.categoryId {
            // Resolve CategoryEntity by id if model has one
            let fetch = NSFetchRequest<NSManagedObject>(entityName: "CategoryEntity")
            fetch.predicate = NSPredicate(format: "id == %@", catId as CVarArg)
            fetch.fetchLimit = 1
            if let cat = try? context.fetch(fetch).first as? CategoryEntity {
                entity.parentCategory = cat
            }
        }
    }
    
    // Input -> Entity (update)
    func applyUpdate(_ input: RecurringInput, into entity: RecurringEntity, in context: NSManagedObjectContext) {
        entity.title = input.title
        entity.amount = input.amount
        entity.type = input.type.rawValue
        entity.frequency = input.frequency.rawValue
        entity.frequencyRule = input.frequencyRule?.toJSON()
        entity.startDate = input.startDate
        entity.nextExcutionDate = input.nextExcutionDate
        entity.endType = input.endType.rawValue
        entity.endDate = input.endDate
        entity.endCount = Int16(input.endCount)
        entity.is_subscription = input.isSubscription
        entity.note = input.note
        if let catId = input.categoryId {
            let fetch = NSFetchRequest<NSManagedObject>(entityName: "CategoryEntity")
            fetch.predicate = NSPredicate(format: "id == %@", catId as CVarArg)
            fetch.fetchLimit = 1
            if let cat = try? context.fetch(fetch).first as? CategoryEntity {
                entity.parentCategory = cat
            }
        }
    }
}
