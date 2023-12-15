//
//  ModifyMainInformationView.swift
//  MealPrep
//
//  Created by AS on 12/13/23.
//

import SwiftUI

struct ModifyMainInformationView: View {
    @Binding var mainInformation: MainInformation
    
    
    var body: some View {
        Form {
            TextField("Recipe Name", text: $mainInformation.name)
            TextField("Author", text: $mainInformation.author)
            Section(header: Text("Description")) {
                TextEditor(text: $mainInformation.description)
        }
            Picker(selection: $mainInformation.category, label:
                HStack {
                    Text("Category")
                    Spacer()
                    Text(mainInformation.category.rawValue)
            }) {
                ForEach(MainInformation.Category.allCases, id: \.self) { category in
                    Text(category.rawValue)
                }
            }
            .pickerStyle(MenuPickerStyle())
            }
    }
}

//#Preview {
//    @State var recipe = Recipe()
//    ModifyMainInformationView(mainInformation: $recipe.mainInformation)
//    
//}
