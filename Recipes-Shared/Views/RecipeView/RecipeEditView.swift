//
//  RecipeEditView.swift
//  Recipes
//
//  Created by Samuel Guay on 2023-07-07.
//

import SwiftUI

struct RecipeEditView: View {
    @Binding var recipe: Recipe
    @State var shouldShowImagePicker = false
    
    var body: some View {
        Form {
            // MARK: Title
            TextField("Title", text: $recipe.name, axis: .vertical)
                .font(.system(.title3, design: .rounded, weight: .medium))
            
            // MARK: Image
            HStack {
                Spacer()
                Button {
                    shouldShowImagePicker.toggle()
                } label: {
                    VStack {
                        if let image = recipe.image {
                            Image(uiImage: image)
                                .resizable()
                                .frame(width: 150, height: 150)
                                .scaledToFill()
                                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 10), style: .circular))
                        } else {
                            Image(systemName: "photo.on.rectangle.angled")
                                .font(.system(size: 64))
                                .padding(10)
                                .background {
                                    RoundedRectangle(cornerRadius: 25.0)
                                        .stroke(lineWidth: 4.0)
                                }
                        }
                    }
                    .padding()
                    .foregroundColor(Color(.label))
                }
                Spacer()
            }
            //MARK: Rating
            HStack {
                
                Stepper(value: $recipe.rating,in: 0...1, step: 0.2) {
                    RatingView(rating: recipe.rating)
                }
                
            }
            // MARK: times
            timePicker(title: "Preparation", H: $recipe.preparationTime.hours, Min: $recipe.preparationTime.minutes)
            timePicker(title: "Cooking", H: $recipe.cookingTime.hours, Min: $recipe.cookingTime.minutes)
            
            timePicker(title: "Chilling", H: $recipe.chillingTime.hours, Min: $recipe.chillingTime.minutes)
            
            //MARK: Portion
            HStack {
                Text("Portion")
                TextField("Number", value: $recipe.portion.value, format: .number)
                    .multilineTextAlignment(.trailing)
                TextField("Measurement", text: $recipe.portion.unit)
            }
            // MARK: Theme
            Picker("Theme", selection: $recipe.theme) {
                ForEach(Theme.allCases) { theme in
                    Text(theme.name)
                        .tag(theme)
                        .padding(.horizontal)
                        .frame(width: 250)
                        .background(theme.mainColor)
                        .foregroundColor(theme.accentColor)
                        .cornerRadius(10)
                }
            }
            .pickerStyle(.wheel)
            //MARK: Description
            TextField("Enter the description here", text: $recipe.description, axis: .vertical)
            
            // MARK: Ingredients
            Section("Ingredients") {
                ForEach($recipe.ingredients) {$ingr in
                    withAnimation(.snappy) {
                        IngredientEditorView(ingr: $ingr)
                            .swipeActions(edge: .trailing) {
                                Button {
                                    recipe.ingredients.removeAll(where: {$0.id == $ingr.wrappedValue.id})
                                } label: {
                                    Image(systemName: "x.circle.fill")
                                        .foregroundColor(.red)
                                }
                            }
                    }
                }
                
                Button {
                    withAnimation(.bouncy(extraBounce: 10.5)) {
                        recipe.ingredients.append(Recipe.ingredient(name: "", isEditing: true))
                    }
                } label: {
                    HStack {
                        Spacer()
                        Image(systemName: "plus")
                        Spacer()
                    }
                }
            }
            
            Section("Steps") {
                ForEach($recipe.steps) {$step in
                    HStack {
                        Text(stepIndex(step: $step.wrappedValue), format: .number)
                        TextField("Step", text: $step.text, axis: .vertical)
                    }
                    .swipeActions(edge: .trailing) {
                        Button {
                            recipe.steps.removeAll(where: {$0.id == $step.wrappedValue.id})
                        } label: {
                            Image(systemName: "x.circle.fill")
                                .foregroundColor(.red)
                        }
                    }
                }
                Button {
                    withAnimation(.bouncy(extraBounce: 10.5)) {
                        recipe.steps.append(Recipe.step(text: ""))
                    }
                } label: {
                    HStack {
                        Spacer()
                        Image(systemName: "plus")
                        Spacer()
                    }
                }
            }
        }
        .fullScreenCover(isPresented: $shouldShowImagePicker) {
            ImagePicker(image: $recipe.image)
        }
    }
    @ViewBuilder
    func IngredientEditorView(ingr: Binding<Recipe.ingredient>) -> some View {
        if ingr.wrappedValue.isEditing {
            IngredientEditPopup(ingredient: ingr) {
                recipe.ingredients.removeAll(where: {$0.id == ingr.wrappedValue.id})
            }
                //.ignoresSafeArea()
        } else {
            HStack {
                if ingr.wrappedValue.countableMeasurement.value != 0 {
                    Text("\(ingr.wrappedValue.countableMeasurement.value)")
                }
                
                if ingr.wrappedValue.massMeasurement.value != 0{
                    Text("\(ingr.wrappedValue.massMeasurement.value.formatted()) \(ingr.wrappedValue.massMeasurement.unit.symbol)")
                }
                if ingr.wrappedValue.volumeMeasurement.value != 0 {
                    Text("\(ingr.wrappedValue.volumeMeasurement.value.formatted()) \(ingr.wrappedValue.volumeMeasurement.unit.symbol)")
                }
                Spacer()
                Text(ingr.wrappedValue.name)
            }
            .onTapGesture {
                ingr.wrappedValue.isEditing.toggle()
                print("tapped \(ingr.wrappedValue.name)")
            }
        }
    }
    
    func stepIndex(step: Recipe.step) -> Int {
        let index = recipe.steps.firstIndex(where: {$0.id == step.id}) ?? 0
        let finalIndex = index + 1
        return finalIndex
    }
}

struct RecipeEditView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RecipeEditView(recipe: .constant(Recipe.sampleData[0]))
            RecipeEditView(recipe: .constant(Recipe.emptyRecipe))
        }
    }
}

