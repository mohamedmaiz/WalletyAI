//
//  EmptyCategoryView.swift
//  SpendInsight
//
//  Created by mac on 16/2/2026.
//
import SwiftUI

struct CategoriesEmptyState : View {
    @ObservedObject var vm: CategoriesViewModel
    @Binding var showSheet : Bool
    var body: some View {
        VStack{
            Image("categoriesEmptyState")
                .resizable()
                .frame(width: 400 , height: 400)
            
            Text("No Categories Yet")
                .font(.system(size: 30 , weight: .bold))
                .foregroundStyle(.white)
                .padding(.bottom , 12)
            
            Text("Organize your finances by creating your first group. Track shared expenses, trips, or monthly bills.")
                .font(.system(size: 16 , weight: .light))
                .foregroundStyle(.white.opacity(0.5))
                .multilineTextAlignment(.center)
                .padding(.horizontal , 20)
                .padding(.bottom , 20)
            
            AppButton(title: "Create First Category" , systemIcon: "plus") {
                showSheet = true
            }
            
        }
        
    }
}
