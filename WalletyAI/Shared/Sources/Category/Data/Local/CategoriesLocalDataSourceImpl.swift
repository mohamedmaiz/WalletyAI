//
//  CategoriesLocalDataSourceImpl.swift
//  SpendInsight
//
//  Created by mac on 14/2/2026.
//
import CoreData

final class CategoriesLocalDataSourceImpl: CategoriesLocalDataSource {
    let coreDataManaging: CoreDataManaging
    
    init(coreDataManaging: CoreDataManaging) {
        self.coreDataManaging = coreDataManaging
    }
    
    
    func saveCategory(_ category: Category) throws {
        let entity = CategoryEntity(context: coreDataManaging.viewContext)
        entity.id = UUID()
        entity.name = category.name
        entity.color = category.color
        entity.icon = category.icon
        
        try? coreDataManaging.viewContext.save()
        
    }
    
    func getCategories() throws -> [(category: CategoryEntity , transactionCount: Int , totalAmount: Double)]? {
        
        // fetch all Categories
        let request = NSFetchRequest<CategoryEntity>(
            entityName: "CategoryEntity"
        )
        
        let categories = try coreDataManaging.viewContext.fetch(request)
        
        let transactionCountExpression = NSExpressionDescription()
        transactionCountExpression.name = "transactionCount"
        transactionCountExpression.expression = NSExpression(
            forFunction: "count:",
            arguments: [NSExpression(forKeyPath: "id")]
        )
        transactionCountExpression.expressionResultType = .integer32AttributeType
        
        let totalSpendingExpression = NSExpressionDescription()
        totalSpendingExpression.name = "totalSpending"
        totalSpendingExpression.expression = NSExpression(
            forFunction: "sum:",
            arguments: [NSExpression(forKeyPath: "amount")]
        )
        totalSpendingExpression.expressionResultType = .doubleAttributeType
        
        let aggregationRequest = NSFetchRequest<NSDictionary>(entityName: "TransactionEntity")
        aggregationRequest.resultType = .dictionaryResultType
        
        aggregationRequest.propertiesToFetch = [
            "category",
            transactionCountExpression,
            totalSpendingExpression
        ]
        
        aggregationRequest.propertiesToGroupBy = ["category"]
        
        let aggregationResults = try coreDataManaging.viewContext.fetch(aggregationRequest)
        
        // -----------------------------
        // 5️⃣ Convert aggregation to dictionary
        // -----------------------------
        var statsMap: [NSManagedObjectID: (count: Int, total: Double)] = [:]
        
        for item in aggregationResults {
            
            guard let school = item["category"] as? CategoryEntity else {
                continue
            }
            
            let count = item["transactionCount"] as? Int ?? 0
            let total = item["totalSpending"] as? Double ?? 0
            
            statsMap[school.objectID] = (count, total)
        }
        
        
        
        
        var finalResults: [(category: CategoryEntity , transactionCount: Int , totalAmount: Double)] = []
        
        for category in categories {
            let id = category.objectID
            let data = statsMap[id] ?? (0, 0.0)
            finalResults.append((category, data.count, data.total))
        }
        return finalResults
        
    }
    
    func deleteCategory(_ category: Category) throws {
        let request: NSFetchRequest<CategoryEntity> = CategoryEntity.fetchRequest()
        request.predicate = NSPredicate(
            format: "id == %@",
            category.id as CVarArg
        )
        request.fetchLimit = 1 // only fetch 1 row
        
        if let entityToDelete = try? coreDataManaging.viewContext.fetch(request).first {
            coreDataManaging.viewContext.delete(entityToDelete)
            try coreDataManaging.viewContext.save()
        }
        
    }
    
    func updateCategory(_ category: Category) throws {
        
    }
    
    func deleteAllCategories() throws {
        
    }
}
