//
//  SaveUserOnboarding.swift
//  SpendInsight
//
//  Created by mac on 13/2/2026.
//

final class CompleteOnboardingUseCase {
    let repo: OnboardingRepository
    
    init(repo: OnboardingRepository) {
        self.repo = repo
    }
    
    func execute() {
         repo.completeOnboarding()
    }
}
