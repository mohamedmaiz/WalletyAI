//
//  AppButton.swift
//  SpendInsight
//
//  Created by mac on 15/2/2026.
//
import SwiftUI

public struct AppButton: View {
    
    let title: String
    let icon: String?
    let systemIcon: String?
    let iconSize: CGFloat
    let iconColor: Color
    let variant: AppButtonVariant
    let size: AppButtonSize
    let color: Color?
    let isLoading: Bool
    let action: () -> Void
    
    init(
        title: String,
        icon: String? = nil,
        systemIcon: String? = nil,
        iconSize: CGFloat = 18,
        iconColor: Color = .white,
        variant: AppButtonVariant = .primary,
        size: AppButtonSize = .large,
        color: Color? = nil,
        isLoading: Bool = false,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.icon = icon
        self.systemIcon = systemIcon
        self.iconSize = iconSize
        self.iconColor = iconColor
        self.variant = variant
        self.size = size
        self.color = color
        self.isLoading = isLoading
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            if isLoading {
                ProgressView()
            } else {
                HStack{
                    if icon != nil {
                        Image(icon!)
                            .resizable()
                            .frame(width: iconSize, height: iconSize)
                    }else if systemIcon != nil {
                        Image(systemName: systemIcon!)
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: iconSize , height: iconSize)
                            .foregroundStyle(iconColor)
                    }
                    Text(title)
                    .font(.system(size: 18 , weight: .bold))
                    .foregroundColor(iconColor)
                }
            }
        }
        .buttonStyle(AppButtonStyle(
            variant: variant,
            size: size,
            isLoading: isLoading,
            color: color
        ))
        .disabled(isLoading)
    }
}
