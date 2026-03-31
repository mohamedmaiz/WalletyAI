//
//  CategoryType.swift
//  SpendInsight
//
//  Created by mac on 16/2/2026.
//


enum CategoryType: String, CaseIterable, Identifiable, Codable {
    case home
    case savings
    case shopping
    case animals
    case auto
    case business
    case charity
    case drinks
    case education
    case fitness
    case food
    case fun
    case gifts
    case groceries
    case health
    case insurance
    case media
    case subscriptions
    case tech
    case travel

    var id: String { rawValue }
}

