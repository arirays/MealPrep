//
//  MainTabView.swift
//  MealPrep
//
//  Created by AS on 12/26/23.
//

import SwiftUI

struct MainTabView: View {
    
    // The MainTabView owns a RecipeData as @StateObject bc this View will be the initial view the user sees, it should create and own the ViewModel
    @StateObject var recipeData = RecipeData()
    
    var body: some View {
        TabView {
            RecipeCategoryGridView()
                .tabItem { Label("Recipes", systemImage: "list.dash") }
            NavigationView {
                RecipesListView(viewStyle: .favorites)
            }
            .tabItem { Label("Favorites", systemImage: "heart.fill") }
        }
        .environmentObject(recipeData)
    }
}

#Preview {
    MainTabView()
}
