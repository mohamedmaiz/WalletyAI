//
//  AppButtonStyle.swift
//  SpendInsight
//
//  Created by mac on 15/2/2026.
//
import SwiftUI

public struct AppButtonStyle: ButtonStyle {
    
    let variant: AppButtonVariant
    let size: AppButtonSize
    let isLoading: Bool
    let color: Color?
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 340 , height: 60)
            .background(color ?? backgroundColor(configuration: configuration))
            .cornerRadius(30)
            .scaleEffect(configuration.isPressed ? 0.96 : 1)
            .brightness(configuration.isPressed ? -0.05 : 0)
            .animation(
                .spring(response: 0.3, dampingFraction: 0.6),
                value: configuration.isPressed
            )
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(
                        Color.white.opacity(0.4),
                        lineWidth: 0.5
                    ) //
            )
        
    }
    
    private func backgroundColor(configuration: Configuration) -> Color {
        switch variant {
        case .primary:
            return .electricBlue
        case .secondary:
            return .darkBlueViolet
        case .destructive:
            return .red
        }
    }
}
