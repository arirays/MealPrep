//
//  RecipeCategoryGridView.swift
//  MealPrep
//
//  Created by AS on 1/23/23.
//

import SwiftUI

struct RecipeCategoryGridView: View {
    @EnvironmentObject private var recipeData: RecipeData
    
    
    var body: some View {
        let columns = [GridItem(),
                       GridItem()]
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, content: {
                    ForEach(MainInformation.Category.allCases, id: \.self) { category in
                        NavigationLink {
                            RecipesListView(viewStyle: .singleCategory(category)).environmentObject(recipeData)
                        } label: {
                            CategoryView(category: category)
                        }
                    }
                })
                .navigationTitle("Categories")
            }
        }
    }
}

struct RecipeCategoryGridView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeCategoryGridView()
    }
}

struct CategoryView: View {
    let category: MainInformation.Category
    var body: some View {
        ZStack {
            Image(category.rawValue)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .opacity(0.35)
            Text(category.rawValue)
                .font(.title)
        }
    }
}
