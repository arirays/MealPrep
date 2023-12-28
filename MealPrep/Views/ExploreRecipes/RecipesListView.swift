//
//  ContentView.swift
//  MealPrep
//
//  Created by Ari on 10/2/22.
//

import SwiftUI

struct RecipesListView: View {
    
    @EnvironmentObject var recipeData: RecipeData
    let viewStyle: ViewStyle
    
    @State private var isPresenting = false
    @State private var newRecipe = Recipe()
    
    @AppStorage("listBackgroundColor") private var listBackgroundColor = AppColor.background
    @AppStorage("listTextColor") private var listTextColor = AppColor.foreground
    
    var body: some View {
        NavigationView {
            List {
                ForEach(recipes) { recipe in
                    NavigationLink(recipe.mainInformation.name, destination: RecipeDetailView(recipe: binding(for: recipe)))
                }
                .listRowBackground(listBackgroundColor)
                .foregroundColor(listTextColor)
            }
            .navigationTitle("All recipes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        newRecipe = Recipe()
                        newRecipe.mainInformation.category = recipes.first?.mainInformation.category ?? .breakfast
                        isPresenting = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isPresenting, content: {
                NavigationView {
                    ModifyRecipeView(recipe: $newRecipe)
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Dismiss") {
                                    isPresenting = false
                                }
                            }
                            ToolbarItem(placement: .confirmationAction) {
                                if newRecipe.isValid {
//                                    if case .favorites = viewStyle {
//                                        newRecipe.isFavorite = true
//                                    }
                                    Button("Add") {
                                        recipeData.add(recipe: newRecipe)
                                        isPresenting = false
                                    }
                                }
                            }
                            }
                        }
                })
            .navigationTitle("Add a New Recipe")
            }
        }
    }


extension RecipesListView {
    
    // This enum helps us to display either all recipes from a single category or the favorite recipes.
    enum ViewStyle {
        case favorites
        case singleCategory(MainInformation.Category)
    }
    
    
    private var recipes: [Recipe] {
        switch viewStyle {
        case let .singleCategory(category):
            recipeData.recipes(for: category)
        case .favorites:
            recipeData.favoriteRecipes
        }
    }
    
    private var navigationTitle: String {
        switch viewStyle {
        case let .singleCategory(category):
            return "\(category.rawValue) Recipes"
        case .favorites:
            return "Favorite Recipes"
        }
        
    }
    
    func binding(for recipe: Recipe) -> Binding<Recipe> {
        guard let index = recipeData.index(of: recipe) else {
            fatalError("Recipe not found")
        }
        return $recipeData.recipes[index]
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RecipesListView(viewStyle: .singleCategory(.breakfast) )
                .environmentObject(RecipeData())
        }
    }
}
