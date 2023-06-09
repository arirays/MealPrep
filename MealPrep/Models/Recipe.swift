//
//  Recipe.swift
//  MealPrep
//
//  Created by Ari on 10/10/22.
//

import Foundation

struct Recipe: Identifiable {
    var id = UUID()
    
    var mainInformation: MainInformation
    var ingredients: [Ingredient]
    var directions: [Direction]
    
    init(mainInformation: MainInformation, ingredients: [Ingredient], directions:[Direction]) {
        self.mainInformation = mainInformation
        self.ingredients = ingredients
        self.directions = directions
    }
    
    //this initializer will be used later for making empty recipes that the user can edit
    init() {
        self.init(mainInformation: MainInformation(name: "", description: "", author: "", category: .breakfast),
                  ingredients: [],
                  directions: [])
    }
}


struct MainInformation {
    var name: String
    var description: String
    var author: String
    var category: Category
    //Breakfast, Lunch, Dinner, Dessert
    
    enum Category: String, CaseIterable {
        case breakfast = "Breakfast"
        case lunch = "Lunch"
        case dinner = "Dinner"
        case dessert = "Dessert"
    }
}


struct Ingredient {
    var name: String
    var quantity: Double
    var unit: Unit
    
    var description: String {
        let formattedQuantity = String(format: "%g", quantity)
        switch unit {
        case .none:
            let formattedName = quantity == 1 ? name: "\(name)s"
            return "\(formattedName) \(formattedName)"
        default:
            if quantity == 1 {
                return "1 \(unit.singularName) \(name)"
            } else {
                return "\(formattedQuantity) \(unit.rawValue) \(name)"
            }
        }
    }
    
    // Ounces, Grams, Cups, Tablespoons, Teaspoons, None
    enum Unit: String, CaseIterable {
        case oz = "Ounces"
        case g = "Grams"
        case cups = "Cups"
        case tbs = "Tablespoons"
        case tsp = "Teaspoons"
        case none = "No units"
        
        var singularName: String {
            String(rawValue.dropLast())
        }
    }
}


struct Direction {
    var description: String
    var isOptional: Bool
}
