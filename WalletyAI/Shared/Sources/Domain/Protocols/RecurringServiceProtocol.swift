//
//  s.swift
//  SpendInsight
//
//  Created by mac on 16/3/2026.
//

import Foundation

public protocol RecurringServiceProtocol {
    func add(input: RecurringInput) throws
    func update(id: UUID, input: RecurringInput) throws
    func delete(id: UUID) throws
    func pause(id: UUID) throws
    func resume(id: UUID) throws
    func fetchAll() throws -> [RecurringModel]
    func fetchSubscriptions() throws -> [RecurringModel]
    func process() throws
}
