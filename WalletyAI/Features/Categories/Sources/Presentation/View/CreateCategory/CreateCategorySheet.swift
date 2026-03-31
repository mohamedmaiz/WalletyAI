//
//  CreateCategorySheet.swift
//  SpendInsight
//
//  Created by mac on 16/2/2026.
//

import SwiftUI

struct CreateCategorySheet: View {
    @State var text: String = ""
    @State var selectedIcon: CategoryType = .home
    @State var selectedColor: Color = .clear
    @ObservedObject var vm: CategoriesViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        Screen(background: .createCategory) {
            
            VStack (alignment: .leading){
                // Custom Large Header
                HStack{
                    Text("New Category")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .renderingMode(.template)
                            .foregroundColor(.white)
                            .frame(width: 36 , height: 36)
                    }
                    .glassEffect(
                        .clear
                            .tint(.darkElectricBlue.opacity(0.10))
                            .interactive(),
                        in: .circle
                    )
                }
                .padding(.bottom , 16)
                
                Text("Category Name")
                    .font(.system(size: 14 , weight: .medium))
                    .foregroundColor(.white.opacity(0.5))
                    .padding(.bottom , 12)
                
                GlassTextField(placeholder: "e.g Summer Vacation", text: $text)
                    .padding(.bottom , 20)
                
                Text("Category Color")
                    .font(.system(size: 14 , weight: .medium))
                    .foregroundColor(.white.opacity(0.5))
                    .padding(.bottom , 12)
                
                ColorSelectorView(selectedColor: $selectedColor)
                    .padding(.bottom , 20)
                
                Text("Category Icon")
                    .font(.system(size: 14 , weight: .medium))
                    .foregroundColor(.white.opacity(0.5))
                    .padding(.bottom , 12)
                
                CategoryIconsView(selectedIcon: $selectedIcon)
                    .padding(.bottom , 30)
                
                
                if let error = vm.categoryActionState.errorMessage {
                    Text(error)
                        .font(.system(size: 14 , weight: .semibold))
                        .foregroundStyle(.red)
                        .padding(.bottom , 12)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                AppButton(title: "Create Category") {
                    vm
                        .addCategory(
                            name: text,
                            color: selectedColor.toHex(),
                            icon: selectedIcon.rawValue
                        )
                }
                .frame(maxWidth: .infinity)
            }
            .padding(.horizontal)
        }.onChange(of: vm.categoryActionState) {
            if case .data = vm.categoryActionState {
                dismiss()
            }
            
        }
        .onDisappear{
            vm.categoryActionState = .idle
        }
    }
}

#Preview {
    let appContainer = AppContainer.preview
    CreateCategorySheet(
        vm: appContainer.makeCategoryFeature().makeCategoriesVM())
}

