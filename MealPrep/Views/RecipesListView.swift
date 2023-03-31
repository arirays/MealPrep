//
//  ContentView.swift
//  MealPrep
//
//  Created by Ari on 10/2/22.
//

import SwiftUI

struct RecipesListView: View {
    
    @EnvironmentObject var recipeData: RecipeData
    let category: MainInformation.Category
    
//    @StateObject var recipeData = RecipeData()
    
    private let listBackgroundColor = AppColor.background
    private let listTextColor = AppColor.foreground
    
    var body: some View {
        List {
            ForEach(recipes) { recipe in
                NavigationLink(recipe.mainInformation.name, destination: RecipeDetailView(recipe: recipe))
            }
            .listRowBackground(listBackgroundColor)
            .foregroundColor(listTextColor)
        }
        .navigationTitle("All recipes")
    }
}

extension RecipesListView {
    
    private var recipes: [Recipe] {
        recipeData.recipes(for: category)
    }
    
    private var navigationTitle: String {
        "\(category.rawValue) Recipes"
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RecipesListView(category: .breakfast)
                .environmentObject(RecipeData())
        }
    }
}
