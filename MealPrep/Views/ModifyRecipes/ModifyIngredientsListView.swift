//
//  ModifyIngredientsListView.swift
//  MealPrep
//
//  Created by AS on 12/15/23.
//

import SwiftUI

struct ModifyIngredientsListView: View {
    @Binding var ingredients: [Ingredient]
    @State var newIngredient = Ingredient()
    
    
    var body: some View {
        VStack {
            
            let addIngredientView = ModifyIngredientView(ingredient: $newIngredient) { ingredient in
                ingredients.append(ingredient)
                newIngredient = Ingredient()
            }.navigationTitle("Add Ingredient")
            
            if ingredients.isEmpty {
                Spacer()
                NavigationLink("Add the first ingredient", destination: addIngredientView)
                Spacer()
            } else {
                List {
                    ForEach(ingredients.indices, id: \.self) { index in
                        let ingredient = ingredients[index]
                        Text(ingredient.description)
                    }
                    NavigationLink("Add another ingredient", destination: addIngredientView)
                        .buttonStyle(PlainButtonStyle())
                }
            }
        }
    }
}

struct ModifyIngredientsView_Previews: PreviewProvider {
    @State static var emptyIngredients = [Ingredient]()
    static var previews: some View {
        NavigationView {
            ModifyIngredientsListView(ingredients: $emptyIngredients)
        }
    }
}
