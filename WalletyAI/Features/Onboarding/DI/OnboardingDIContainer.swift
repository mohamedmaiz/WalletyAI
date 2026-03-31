//
//  OnboardingDIContainer.swift
//  SpendInsight
//
//  Created by mac on 13/2/2026.
//

final class OnboardingDIContainer{
    func buildOnboardingViewModel() -> OnboardingViewModel {
        let repo: OnboardingRepository = OnboardingRepositoryImpl()
        let fetchOnboardingUseCase = FetchOnboardingStepsUseCase(repo: repo)
        let completeOnboardingUseCase = CompleteOnboardingUseCase(repo: repo)
        let hasCompleteOnboardingUseCase = HasCompleteOnboardingUseCase(repo: repo)
        
        return OnboardingViewModel(
            fetchOnboardingUseCase: fetchOnboardingUseCase ,
            completeOnboardingUseCase: completeOnboardingUseCase,
            hasCompletedOnboardingUseCase: hasCompleteOnboardingUseCase
        )
    }
}
