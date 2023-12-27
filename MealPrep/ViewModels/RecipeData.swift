//
//  RecipeData.swift
//  MealPrep
//
//  Created by Ari on 12/6/22.
//

import Foundation

class RecipeData: ObservableObject {
    @Published var recipes = Recipe.testRecipes
    
    // Computed property inside RecipeData will filter recipes by isFavorite property, so we can find the ones that have been selected as favorites.
    var favoriteRecipes: [Recipe] {
        recipes.filter { $0.isFavorite }
    }
    
    
    func recipes(for category: MainInformation.Category) -> [Recipe] {
        var filteredRecipes = [Recipe]()
        for recipe in recipes {
            if recipe.mainInformation.category == category {
                filteredRecipes.append(recipe)
            }
        }
        return filteredRecipes
    }
    
    
    func add(recipe: Recipe) {
        if recipe.isValid {
            recipes.append(recipe)
        }
    }
    
    
    func index(of recipe: Recipe) -> Int? {
        for i in recipes.indices {
            if recipes[i].id == recipe.id {
                return i
            }
        }
        return nil
    }
}
