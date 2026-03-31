//
//  UpdateTransactionSheet.swift
//  SpendInsight
//
//  Created by mac on 7/3/2026.
//

import SwiftUI


struct EditTransactionSheet: View {
    @StateObject var vm: EditTransactionViewModel
    @State private var showingDatePicker: Bool = false
    @State private var showingAmountKeypad: Bool = false
    @FocusState private var isFocused: Bool
    
    var body: some View {
        
        Screen(
            background: vm.transactionType == .expense ? .expenseScreen : .incomeScreen
        ){
            VStack(alignment: .leading){
                
                SheetHeaderView(
                    title: "Edit Transaction",
                    icon: "chevron.left",
                    action: {}
                )
                .padding(.bottom, 20)
                
                Text("AMOUNT")
                    .font(.system(size: 12 , weight: .semibold))
                    .foregroundStyle(.blueGray)
                    .padding(.bottom , 6)
                
                HStack{
                    Text(
                        "$"
                    )
                    .font(.system(size: 22 , weight: .bold))
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(.primary)
                    .padding(.trailing , 4)
                    
                    Text(
                        "\(vm.amount)"
                    )
                    .font(.system(size: 24 , weight: .bold))
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(.white)
                }
                .frame(maxWidth: .infinity , minHeight: 60 , maxHeight: 60)
                
                .padding(.horizontal , 16)
                .background(.white.opacity(0.05))
                .cornerRadius(30)
                .overlay {
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(.white.opacity(0.1))
                }
                .onTapGesture {
                    isFocused = false
                    showingAmountKeypad = true
                }
                
                if (vm.transactionType == .expense){
                    CategoryPickerView(
                        categories: $vm.categoriesState,
                        selectedCategory: $vm.selectedCategory,
                        leadingPadding: 0
                    )
                    .padding(.top , 8)
                }
                
                Text("WHAT WAS IT FOR?")
                    .font(.system(size: 12 , weight: .semibold))
                    .foregroundStyle(.blueGray)
                    .padding(.top , 12)
                    .padding(.bottom , 6)
                
                TextField(
                    "",
                    text: $vm.title,
                    prompt: Text("e.g. Coffe..")
                        .foregroundStyle(.blueGray.opacity(0.8))
                )
                .submitLabel(.done)
                .focused($isFocused)
                .frame(maxWidth: .infinity , minHeight: 60 , maxHeight: 60)
                .foregroundStyle(.white)
                .padding(.horizontal , 16)
                .background(.white.opacity(0.05))
                .cornerRadius(30)
                .overlay {
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(.white.opacity(0.1))
                }
                
                Text("NOTES")
                    .font(.system(size: 12 , weight: .semibold))
                    .foregroundStyle(.blueGray)
                    .padding(.top , 12)
                    .padding(.bottom , 6)
                
                TextField("", text: $vm.notes  ,prompt: Text("e.g. buying coffee for friends").foregroundStyle(.blueGray.opacity(0.8)) , axis: .vertical)
                    .submitLabel(.done)
                    .focused($isFocused)
                    .lineLimit(3)
                    .frame(maxWidth: .infinity , minHeight: 80 , maxHeight: 80)
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(.white)
                    .padding(.horizontal , 16)
                    .background(.white.opacity(0.05))
                    .cornerRadius(30)
                    .overlay {
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(.white.opacity(0.1))
                    }
                
                Text("DATE & TIME")
                    .font(.system(size: 12 , weight: .semibold))
                    .foregroundStyle(.blueGray)
                    .padding(.top , 12)
                    .padding(.bottom , 6)
                DatePickerView(
                    date: $vm.date,
                    showingDatePicker: $showingDatePicker
                )
                
                Spacer()
                if let errorMessage = vm.editTransactionState.errorMessage {
                    Text(errorMessage)
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundStyle(.red)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.horizontal, 30)
                        .padding(.bottom, 4)
                }
                AppButton(title: "Save Transaction") {
                    
                }
                
            }
            .padding(.horizontal , 20)
            .safeAreaPadding(.vertical)
            
            
            
        }
        .onTapGesture {
                    isFocused = false
                }
        .sheet(isPresented: $showingDatePicker) {
            DatePickerSheet(date: $vm.date, showingDatePicker: $showingDatePicker)
        }
        .sheet(isPresented: $showingAmountKeypad) {
            VStack(spacing: 12) {
                // Header / handle
                RoundedRectangle(cornerRadius: 3)
                    .fill(Color.white.opacity(0.3))
                    .frame(width: 40, height: 6)
                    .padding(.top, 8)

                    KeyboardContainerView(text: $vm.amount)
                    .padding(.bottom, 20)
            }
            .presentationBackground(.clear)
            .padding(.horizontal, 20)
            .presentationDetents([.height(300), .medium])
            .presentationDragIndicator(.hidden)
            
        }
        
    }
}

#Preview {
    let appContainer = AppContainer.preview
    EditTransactionSheet(
        vm: appContainer
            .makeTransactionFeature()
            .makeEditTransactionVM(
                transaction: .init(
                    id: UUID(),
                    amount: 200,
                    type: .expense,
                    title: "Preview Title",
                    description: "Preview Description",
                    date: Date()
                )
            )
    )
}

