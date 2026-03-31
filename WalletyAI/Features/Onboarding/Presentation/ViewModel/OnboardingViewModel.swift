//
//  OnboardingViewModel.swift
//  SpendInsight
//
//  Created by mac on 13/2/2026.
//
import Foundation
import Combine

final class OnboardingViewModel: ObservableObject {
    let fetchOnboardingUseCase: FetchOnboardingStepsUseCase
    let completeOnboardingUseCase: CompleteOnboardingUseCase
    let hasCompletedOnboardingUseCase: HasCompleteOnboardingUseCase
    init(
        fetchOnboardingUseCase: FetchOnboardingStepsUseCase,
        completeOnboardingUseCase: CompleteOnboardingUseCase,
        hasCompletedOnboardingUseCase: HasCompleteOnboardingUseCase
    ) {
        self.fetchOnboardingUseCase = fetchOnboardingUseCase
        self.completeOnboardingUseCase = completeOnboardingUseCase
        self.hasCompletedOnboardingUseCase = hasCompletedOnboardingUseCase
        self.fetchOnboardingSteps()
    }
    
    @Published var onboardingSteps: [OnboardingStep] = []
    @Published var currentStep: Int = 0
    
   
}


extension OnboardingViewModel {
    
    func hasOnboardingCompleted() -> Bool {
        hasCompletedOnboardingUseCase.execute()
    }
    
    func fetchOnboardingSteps() {
        onboardingSteps = fetchOnboardingUseCase.fetch()
    }
    
    func nextStep() {
        if currentStep < 2 {
            currentStep += 1
        }
    }
    
    func setCurrentStep(_ step: Int) {
        currentStep = step
    }
    
    func markOnboardingAsComplete() {
        completeOnboardingUseCase.execute()
    }
}
