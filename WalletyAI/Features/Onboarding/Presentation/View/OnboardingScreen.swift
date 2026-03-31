//
//  OnboardingScreen.swift
//  SpendInsight
//
//  Created by mac on 13/2/2026.
//

import SwiftUI

struct OnboardingScreen: View {
    @StateObject var vm: OnboardingViewModel
    
    var body: some View {
        Screen(background: .defaultBackground) {
            VStack{
                Spacer()
                Image(vm.onboardingSteps[vm.currentStep].imageName)
                    .padding(.bottom , 40)
                
                Text(
                    vm
                        .onboardingSteps[vm.currentStep].title
                        .split(separator: " ")
                        .dropLast().joined(separator: " ")
                )
                .font(.system(size: 38 , weight: .black))
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .padding(.horizontal , 20)
                
                Text(
                    vm
                        .onboardingSteps[vm.currentStep].title
                        .split(separator: " ")
                        .last ?? ""
                )
                .font(.system(size: 38 , weight: .black))
                .multilineTextAlignment(.center)
                .foregroundStyle(LinearGradient(
                    colors: [Color(hex: "60A5FA"), Color(hex: "C084FC")],
                    startPoint: .leading,
                    endPoint: .trailing
                ))
                .padding(.horizontal , 20)
                .padding(.bottom, 20)
                
                Text(
                    vm
                        .onboardingSteps[vm.currentStep].description
                )
                .font(.system(size: 18 , weight: .medium))
                .multilineTextAlignment(.center)
                .foregroundColor(.blueGray)
                .padding(.horizontal , 40)
                Spacer()
                HStack{
                    ForEach(0..<3, id: \.self) { index in
                        Capsule()
                            .fill(
                                index == vm.currentStep ? Color.blue : Color.gray
                                    .opacity(0.3)
                            )
                            .frame(
                                width: index == vm.currentStep ? 30 : 8,
                                height: 8
                            )
                            .animation(.spring(response: 0.4, dampingFraction: 0.7), value: vm.currentStep)
                            .onTapGesture {
                                vm.setCurrentStep(index)
                            }
                        
                    }
                }
                .padding(.bottom , 30)
                
                Button( action: {
                    vm.nextStep()
                } ) {
                    Text("Next")
                        .font(.system(size: 18 , weight: .bold))
                        .foregroundColor(.white)
                        .frame(width: 300 , height: 60)
                    
                        .background(Color.electricBlue.opacity(0.15))
                        .cornerRadius(30)
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(
                                    Color.white.opacity(0.4),
                                    lineWidth: 0.5
                                ) //
                        )
                }
                .padding(.horizontal , 60)
                .safeAreaPadding(.bottom)
                
                
                
                
            }
        }
    }
}


#Preview {
    OnboardingScreen(vm: OnboardingDIContainer()
        .buildOnboardingViewModel())
}
