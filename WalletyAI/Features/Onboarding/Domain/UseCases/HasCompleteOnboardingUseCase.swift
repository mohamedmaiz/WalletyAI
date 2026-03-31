//
//  HasCompleteOnboardingUseCase.swift
//  SpendInsight
//
//  Created by mac on 13/2/2026.
//

final class HasCompleteOnboardingUseCase {
    let repo: OnboardingRepository
    
    init(repo: OnboardingRepository) {
        self.repo = repo
    }
    
    func execute() -> Bool {
        return repo.hasOnboardingCompleted()
    }
}
