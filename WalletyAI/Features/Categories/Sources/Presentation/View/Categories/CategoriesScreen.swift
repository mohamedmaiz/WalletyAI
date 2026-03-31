//
//  CategoriesScreen.swift
//  SpendInsight
//
//  Created by mac on 15/2/2026.
//

import SwiftUI


struct CategoriesScreen : View {
    @StateObject var vm: CategoriesViewModel
    @State private var showSheet = false
    
    @State private var pressingCategoryId: UUID?
    @State private var selectedCategory: Category?
    @State private var selectedFrame: CGRect = .zero
    @State private var showMenu = false
    
    
    
    var body: some View {
        NavigationView {
            Screen(background: .primaryScreen) {
                ZStack{
                    switch vm.categoriesState {
                    case .data(let categories):
                        ScrollView {
                            LazyVStack{
                                ForEach(categories) { category in
                                    CategoryCardView(category: category)
                                        .scaleEffect(pressingCategoryId == category.id ? 0.96 : 1)
                                        .animation(.easeInOut(duration: 0.15), value: pressingCategoryId)
                                        .onLongPressGesture(
                                            minimumDuration: 0.4,
                                            maximumDistance: 12,
                                            pressing: { isPressing in
                                                if isPressing {
                                                    pressingCategoryId = category.id
                                                } else if pressingCategoryId == category.id {
                                                    pressingCategoryId = nil
                                                }
                                            },
                                            perform: {
                                                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                                                withAnimation(.spring(response: 0.35, dampingFraction: 0.7)) {
                                                    selectedCategory = category
                                                    showMenu = true
                                                }
                                            }
                                        )
                                }
                            }
                        }
                        .refreshable {
                            vm.fetchCategories()
                        }
                    case .loading: CategoriesEmptyState(vm: vm , showSheet: $showSheet)
                    case .empty: CategoriesEmptyState(vm: vm , showSheet: $showSheet)
                    case .idle: EmptyView()
                    default: EmptyView()
                    }
                    
                    
                }
                .onViewDidLoad{
                    vm.fetchCategories()
                }
                .safeAreaPadding()
                .sheet(isPresented: $showSheet) {
                    CreateCategorySheet(vm: vm)
                        .presentationDetents([.height(650)]) // 👈 exact height
                        .presentationDragIndicator(.visible)
                    
                }
                .blur(radius: showMenu ? 8 : 0)
                .animation(.easeInOut(duration: 0.2), value: showMenu)
                
                if showMenu {
                    menuOverlay
                }
            }
            .toolbarTitleDisplayMode(.inlineLarge)
            .navigationBarTitle(
                Text("Categories")
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)
            )
            .toolbar {
                Button(action: {
                    showSheet = true
                }) {
                    Image(systemName: "plus")
                        .renderingMode(.template)
                        .foregroundColor(.electricBlue)
                }
            }
        }
        
    }
    
    var menuOverlay: some View {
        ZStack {
            
            Color.black.opacity(0.25)
                .ignoresSafeArea()
                .transition(.opacity)
                .onTapGesture {
                    dismissMenu()
                }
            
            VStack(spacing: 14) {
                
                if let category = selectedCategory {
                    
                    // Lifted card
                    CategoryCardView(category: category)
                        .scaleEffect(1.05)
                        .shadow(color: .black.opacity(0.25),
                                radius: 25,
                                y: 12)
                        .transition(.scale.combined(with: .opacity))
                }
                
                // Menu
                VStack(spacing: 0) {
                    //                    Button {
                    //                    } label: {
                    //                        menuRow(title: "Edit", icon: "pencil")
                    //                    }
                    //
                    //                    Divider()
                    Button(role: .destructive) {
                        vm.deleteCategory(category: selectedCategory!)
                        dismissMenu()
                    } label: {
                        menuRow(title: "Delete", icon: "trash")
                    }
                    
                }
                .background(
                    .ultraThinMaterial
                        .opacity(0.2)
                )
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(radius: 30)
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
            .padding(.horizontal, 24)
        }
    }
    
    
    func menuRow(title: String, icon: String) -> some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 16, weight: .semibold))
            
            Text(title)
                .font(.system(size: 15, weight: .medium))
            
            Spacer()
        }
        .padding()
    }
    
    func dismissMenu() {
        withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) {
            showMenu = false
            selectedCategory = nil
        }
    }
    
    
    
    
    
}

struct CategoryCardView: View {
    var category: Category
    
    var body: some View {
        HStack{
            Image(category.icon)
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .frame(width: 22, height: 22)
                .foregroundStyle(Color(hex:category.color))
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: 54 , height: 54)
                        .foregroundStyle(Color(hex:category.color).opacity(0.2))
                )
                .padding(.trailing , 20)
            VStack(alignment: .leading){
                Text(category.name)
                    .font(.system(size: 18 , weight: .bold))
                    .foregroundStyle(.white)
                HStack {
                    Image("transaction")
                        .resizable()
                        .frame(width: 12, height: 14)
                    
                    
                    Text("\(category.transactionCount) Transactions")
                        .font(.system(size: 14 , weight: .medium))
                        .foregroundStyle(.white.opacity(0.4))
                }
            }
            Spacer()
        }
        .padding(.horizontal , 30)
        .frame( maxWidth: .infinity, minHeight: 90, maxHeight: 90)
        .background(Color(hex: "#1F1A2B"))
        .clipShape(RoundedRectangle(cornerRadius: 20))
       
        
    }
}


#Preview{
    Screen(background: .primaryScreen) {
        CategoryCardView(
            category: Category(
                id: UUID(),
                name: "Test",
                color: "#FFF454",
                icon: "home",
                totalSpending: 0,
                transactionCount: 0
            )
        )
    }
}
//#Preview{
//    let appContainer = AppContainer.preview
//    CategoriesScreen(vm: appContainer.makeCategoryFeature().makeCategoriesVM())
//}

