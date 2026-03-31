//
//  OnboardingRepositoryImpl.swift
//  SpendInsight
//
//  Created by mac on 13/2/2026.
//

import Foundation

final class OnboardingRepositoryImpl: OnboardingRepository {
    func fetchOnboardingSteps() -> [OnboardingStep] {
        return [
            .init(title: "Master Your Wealth", imageName: "wallet", description: "Track, save, and grow your assets with crystal clarity."),
            .init(title: "Smart Expenses", imageName: "card", description: "Automatically categorize your daily spending"),
            .init(title: "Growth Insights", imageName: "walletGrowth", description: "Visualize your path to financial freedom.")
        ]
    }

    func completeOnboarding() {
        UserDefaults.standard.set(true, forKey: "onboardingCompleted")
    }

    func hasOnboardingCompleted() -> Bool {
        return UserDefaults.standard.bool(forKey: "onboardingCompleted")
    }
}
