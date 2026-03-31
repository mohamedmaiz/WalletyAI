//
//  Background+GradientEffect.swift
//  SpendInsight
//
//  Created by mac on 13/2/2026.
//

import SwiftUI

public enum BackgroundType {
    case defaultBackground
    case primaryScreen
    case securityScreen
    case passCodeScreen
    case createCategory
    case incomeScreen
    case expenseScreen
    
}

public struct Screen<Content: View>: View {
    private let background: BackgroundType
    private let content: Content
    
    public init(
        background: BackgroundType = .defaultBackground,
            @ViewBuilder content: () -> Content
        ) {
            self.background = background
            self.content = content()
        }
        
        public var body: some View {
            ZStack {
                switch background {
                case .defaultBackground:
                    PrimaryBackground()
                case .primaryScreen:
                    Color.background.ignoresSafeArea()
                case .securityScreen:
                    SecurityBackground()
                case .passCodeScreen:
                    Color.background.ignoresSafeArea()
                case .createCategory:
                    Color.background2.ignoresSafeArea()
                case .incomeScreen:
                    IncomeBackground()
                case .expenseScreen:
                    ExpenseBackground()
                }
                content
            }
        }
    }


public struct PrimaryBackground: View {
    var body: some View {
        ZStack{
            Color.background
                .ignoresSafeArea()
                .overlay(alignment: .topLeading) {
                    Circle()
                        .fill(
                            RadialGradient(
                                gradient: Gradient(
                                    colors: [.darkBlueViolet , .clear]
                                ),
                                center: .center,
                                startRadius: 0,
                                endRadius: 180
                            )
                        )
                        .offset(x:-100, y: -100)
                        .blur(radius: 30)
                }
                .overlay(alignment: .bottomTrailing) {
                    Circle()
                        .fill(
                            RadialGradient(
                                gradient: Gradient(
                                    colors: [.darkViolet , .clear]
                                ),
                                center: .center,
                                startRadius: 0,
                                endRadius: 160
                            )
                        )
                        .offset(x: 100, y: -130)
                        .blur(radius: 30)
                    
                }
                .overlay(alignment: .bottomTrailing) {
                    Circle()
                        .fill(
                            RadialGradient(
                                gradient: Gradient(
                                    colors: [.electricBlue , .clear]
                                ),
                                center: .center,
                                startRadius: 0,
                                endRadius: 220
                            )
                        )
                        .offset(x: 60, y: 140)
                        .blur(radius: 30)
                    
                }
        }
    }
}

public struct SecurityBackground: View {
   var body: some View {
       ZStack{
           Color.background
               .ignoresSafeArea()
               .overlay(alignment: .topLeading) {
                   Circle()
                       .fill(
                           RadialGradient(
                               gradient: Gradient(
                                   colors: [.electricBlue , .clear]
                               ),
                               center: .center,
                               startRadius: 0,
                               endRadius: 200
                           )
                       )
                       .offset(x:-100, y: -100)
                       .blur(radius: 30)
               }
               .overlay(alignment: .bottomTrailing) {
                   Circle()
                       .fill(
                           RadialGradient(
                               gradient: Gradient(
                                   colors: [.electricBlue.opacity(0.4) , .clear]
                               ),
                               center: .center,
                               startRadius: 0,
                               endRadius: 220
                           )
                       )
                       .offset(x: 100, y: 100)
                       .blur(radius: 30)
                   
               }
       }
   }
}

public struct ExpenseBackground: View {
   var body: some View {
       ZStack{
           Color.background
               .ignoresSafeArea()
               .overlay(alignment: .topLeading) {
                   Circle()
                       .fill(
                           RadialGradient(
                               gradient: Gradient(
                                colors: [.darkViolet , .clear]
                               ),
                               center: .center,
                               startRadius: 0,
                               endRadius: 200
                           )
                       )
                       .offset(x:-100, y: -100)
                       .blur(radius: 30)
               }
               .overlay(alignment: .bottomTrailing) {
                   Circle()
                       .fill(
                           RadialGradient(
                               gradient: Gradient(
                                colors: [.darkViolet.opacity(0.4) , .clear]
                               ),
                               center: .center,
                               startRadius: 0,
                               endRadius: 220
                           )
                       )
                       .offset(x: 100, y: 100)
                       .blur(radius: 30)
                   
               }
       }
   }
}

public struct IncomeBackground: View {
   var body: some View {
       ZStack{
           Color.background
               .ignoresSafeArea()
               .overlay(alignment: .topLeading) {
                   Circle()
                       .fill(
                           RadialGradient(
                               gradient: Gradient(
                                colors: [.successGreen.opacity(0.6) , .clear]
                               ),
                               center: .center,
                               startRadius: 0,
                               endRadius: 200
                           )
                       )
                       .offset(x:-100, y: -100)
                       .blur(radius: 30)
               }
               .overlay(alignment: .bottomTrailing) {
                   Circle()
                       .fill(
                           RadialGradient(
                               gradient: Gradient(
                                   colors: [.successGreen.opacity(0.4) , .clear]
                               ),
                               center: .center,
                               startRadius: 0,
                               endRadius: 220
                           )
                       )
                       .offset(x: 100, y: 100)
                       .blur(radius: 30)
                   
               }
       }
   }
}
