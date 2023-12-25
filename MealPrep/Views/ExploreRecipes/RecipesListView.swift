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
    
    @State private var isPresenting = false
    @State private var newRecipe = Recipe()
    
    private let listBackgroundColor = AppColor.background
    private let listTextColor = AppColor.foreground
    
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
    
    private var recipes: [Recipe] {
        recipeData.recipes(for: category)
    }
    
    private var navigationTitle: String {
        "\(category.rawValue) Recipes"
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
            RecipesListView(category: .breakfast)
                .environmentObject(RecipeData())
        }
    }
}
