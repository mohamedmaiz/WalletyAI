//
//  OnboardingStepsRepository.swift
//  SpendInsight
//
//  Created by mac on 13/2/2026.
//

protocol OnboardingRepository {
    func fetchOnboardingSteps() -> [OnboardingStep]
    func completeOnboarding() -> Void
    func hasOnboardingCompleted() -> Bool
}
