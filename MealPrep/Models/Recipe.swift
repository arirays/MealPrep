//
//  Recipe.swift
//  MealPrep
//
//  Created by Ari on 10/10/22.
//

import Foundation

struct Recipe: Identifiable, Codable {
    var id = UUID()
    
    var mainInformation: MainInformation
    var ingredients: [Ingredient]
    var directions: [Direction]
    var isFavorite = false
    
    
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
    
    var isValid: Bool {
        mainInformation.isValid && !ingredients.isEmpty && !directions.isEmpty
    }
    
    func index(of direction: Direction, excludingOptionalDirections: Bool) -> Int? {
        let directions = directions.filter { excludingOptionalDirections ? !$0.isOptional : true }
        let index = directions.firstIndex { $0.description == direction.description }
        return index
    }
    
}


struct MainInformation: Codable {
    var name: String
    var description: String
    var author: String
    var category: Category
    //Breakfast, Lunch, Dinner, Dessert
    
    enum Category: String, CaseIterable, Codable {
        case breakfast = "Breakfast"
        case lunch = "Lunch"
        case dinner = "Dinner"
        case dessert = "Dessert"
    }
    
    var isValid: Bool {
        !name.isEmpty && !description.isEmpty && !author.isEmpty
    }
}


struct Ingredient: RecipeComponent {
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
    enum Unit: String, CaseIterable, Codable {
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
    
    
    init(name: String, quantity: Double, unit: Unit) {
        self.name = name
        self.quantity = quantity
        self.unit = unit
    }
    
    init() {
        self.init(name: "", quantity: 1.0, unit: .none)
    }
}


struct Direction: RecipeComponent {
    
    var description: String
    var isOptional: Bool
    
    init(description: String, isOptional: Bool) {
        self.description = description
        self.isOptional = isOptional
    }
    
    init() {
        self.init(description: "", isOptional: false)
    }
}
