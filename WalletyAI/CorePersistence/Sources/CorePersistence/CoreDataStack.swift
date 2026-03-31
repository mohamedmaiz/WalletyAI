//
//  CoreDataStack.swift
//  SpendInsight
//
//  Created by mac on 14/2/2026.
//

import CoreData

public final class CoreDataStack: CoreDataManaging {
    
    public static let shared = CoreDataStack()
    
    public let persistentContainer: NSPersistentContainer
    
    public var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    // MARK: - Init
    public init(inMemory: Bool = false) {
        persistentContainer = NSPersistentContainer(name: "SpendInsight")
        
        if inMemory {
            persistentContainer.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Core Data store failed: \(error)")
            }
        }
        
        persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    // MARK: - preview SUPPORT
    static var preview: CoreDataStack = {
        let controller = CoreDataStack(inMemory: true)
        let context = controller.viewContext
        return controller
    }()
    
    // MARK: - Contexts
    public func newBackgroundContext() -> NSManagedObjectContext {
        persistentContainer.newBackgroundContext()
    }
    
    // MARK: - Save
    public func save(context: NSManagedObjectContext) throws {
        if context.hasChanges {
            try context.save()
        }
    }
}
