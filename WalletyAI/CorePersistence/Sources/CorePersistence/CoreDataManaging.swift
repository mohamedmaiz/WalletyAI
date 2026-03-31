//
//  CoreDataManaging.swift
//  SpendInsight
//
//  Created by mac on 14/2/2026.
//

import CoreData

public protocol CoreDataManaging {
    var viewContext: NSManagedObjectContext { get }
    func newBackgroundContext() -> NSManagedObjectContext
    func save(context: NSManagedObjectContext) throws
}
