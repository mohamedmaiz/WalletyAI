//
//  FetchOnboardingSteps.swift
//  SpendInsight
//
//  Created by mac on 13/2/2026.
//

final class FetchOnboardingStepsUseCase {
    let repo: OnboardingRepository
    
    init(repo: OnboardingRepository) {
        self.repo = repo
    }
    
    func fetch() -> [OnboardingStep] {
        return repo.fetchOnboardingSteps()
    }
}
