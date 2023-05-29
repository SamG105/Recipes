//
//  Recipe+Struct.swift
//  Recipes
//
//  Created by Samuel Guay on 2023-05-22.
//

import SwiftUI

struct recipe: Identifiable, Codable {
    //MARK: required
    var id = UUID()
    
    
    //MARK: Fields
    var name: String
    var imageData: Data?
    var image: Image? {
        get {
            guard let data = imageData else { return nil }
            let uiImage: UIImage = UIImage(data: data)!
            return Image(uiImage: uiImage)
        }
        set {
            let uiImage = newValue.asUIImage()
            imageData = uiImage.pngData()
        }
    }
    var theme: Theme
    var description: String
    var notes: String = ""
    var link: URL?
    var rating: Double?
    var preparationTime: time
    var cookingTime: time
    var chillingTime: time
    var portion: quantity
    var canFreeze: Bool
    
    var ingredients: [ingredient]
    var steps: [step]
    
    
    init(id: UUID = UUID(), name: String, image: Image, theme: Theme, description: String, notes: String = "", link: URL? = nil, rating: Double? = nil, preparationTime: time, cookingTime: time, chillingTime: time, portion: quantity, canFreeze: Bool, ingredients: [ingredient], steps: [step]) {
        self.id = id
        self.name = name
        self.imageData = image.asUIImage().pngData()
        self.theme = theme
        self.description = description
        self.notes = notes
        self.link = link
        self.rating = rating
        self.preparationTime = preparationTime
        self.cookingTime = cookingTime
        self.chillingTime = chillingTime
        self.portion = portion
        self.canFreeze = canFreeze
        self.steps = steps
        self.ingredients = ingredients
    }
    //-MARK: Step
    ///The step of a recipe
    struct step: Identifiable, Codable {
        var id = UUID()
        var isDone = Bool()
        var text: String
    }
    
    //-MARK: Ingredients
    struct ingredient: Identifiable, Codable {
        var id: UUID = UUID()
        
        var name: String
        var isOnList = Bool()
        var massMeasurement: Measurement<UnitMass>?
        var volumeMeasurement: Measurement<UnitVolume>?
        var countableMeasurement: quantity?
    }
    
    
    struct time: Codable {
        var hours: Int?
        var minutes: Int?
    }
    struct quantity: Codable {
        var value: Int
        var unit: String
    }
}

extension recipe {
    static let sampleData: [recipe] = [
        recipe(name: "Chewy Chocolate Chip Cookies (The Best)",
               image: Image("sample-Chocolate_Cookies"),
               theme: .peanutButter,
               description: "The best chocolate cookies, from Ricardo",
               link: URL(string: "https://www.ricardocuisine.com/en/recipes/4874-chewy-chocolate-chip-cookies-the-best"),
               preparationTime: time(minutes: 15),
               cookingTime: time(minutes: 8),
               chillingTime: time(hours: 1),
               portion: quantity(value: 16, unit: "Cookies"),
               canFreeze: false,
               ingredients: [ingredient(name: "unbleached all-purpose flour", isOnList: true, massMeasurement: Measurement(value: 225, unit: .grams), volumeMeasurement: Measurement(value: 1.5, unit: .cups)),
                             ingredient(name: "baking soda", isOnList: true, volumeMeasurement: Measurement(value: 0.5, unit: .teaspoons)),
                             ingredient(name: "salt", massMeasurement: Measurement(value: 2, unit: .grams), volumeMeasurement: Measurement(value: 1, unit: .teaspoons)),
                             ingredient(name: "unsalted butter, melted", massMeasurement: Measurement(value: 170, unit: .grams), volumeMeasurement: Measurement(value: 0.75, unit: .cups)),
                             ingredient(name: "brown sugar", massMeasurement: Measurement(value: 210, unit: .grams), volumeMeasurement: Measurement(value: 1, unit: .cups)),
                             ingredient(name: "sugar", isOnList: true, volumeMeasurement: Measurement(value: 2, unit: .tablespoons)),
                             ingredient(name: "egg", countableMeasurement: quantity(value: 1, unit: "egg")),
                             ingredient(name: "egg yolk", countableMeasurement: quantity(value: 1, unit: "egg yolk")),
                             ingredient(name: "milk or semisweet chocolate, coarsely chopped", massMeasurement: Measurement(value: 195, unit: .grams), volumeMeasurement: Measurement(value: 1, unit: .fluidOunces))
                            ],
               steps: [step(text: "With the rack in the middle position, preheat the oven to 375°F (190°C). Line two or three baking sheets with parchment paper."),
                                       step(text: "In a bowl, combine the flour, baking soda and salt."),
                                       step(text: "In another bowl, combine the butter and both sugars with a wooden spoon. Add the eggs and stir until smooth. Stir in the dry ingredients and chocolate. Cover and refrigerate for 1 hour or overnight."),
                                       step(text: "Using a 3-tbsp (45 ml) ice cream scoop, spoon five to six balls of dough on each baking sheet, spacing them out evenly."),
                                       step(text: "Bake one sheet at a time for 8 to 9 minutes or until lightly browned all over. They will still be very soft in the centre. Cool completely on the baking sheet.")
                      ]
               
              ),
        
        recipe(name: "Classic Brownies",
               image: Image("sample-Classic-Brownies"),
               theme: .cake,
               description: "",
               preparationTime: time(minutes: 15),
               cookingTime: time(minutes: 35),
               chillingTime: time(hours: 2),
               portion: quantity(value: 16, unit: "Pieces"),
               canFreeze: true,
               ingredients: [
                ingredient(name: "Dark chocolate, coarsely chopped", isOnList: true, massMeasurement: Measurement(value: 170, unit: .grams), volumeMeasurement: Measurement(value: 6, unit: .fluidOunces)),
                ingredient(name: "Unsalted butter, cubed", massMeasurement: Measurement(value: 170, unit: .grams), volumeMeasurement: Measurement(value: 0.75, unit: .cups)),
                ingredient(name: "Eggs", isOnList: true, countableMeasurement: quantity(value: 2, unit: "eggs")),
                ingredient(name: "Brown sugar", isOnList: true, massMeasurement: Measurement(value: 160, unit: .grams), volumeMeasurement: Measurement(value: 3/4, unit: .cups)),
                ingredient(name: "Salt", volumeMeasurement: Measurement(value: 1/4, unit: .teaspoons)),
                ingredient(name: "Unbleached all-purpose flour", massMeasurement: Measurement(value: 75, unit: .grams), volumeMeasurement: Measurement(value: 1/2, unit: .cups))
               ],
               steps: [
                step(text: "With the rack in the middle position, preheat the oven to 350°F (180°C). Butter an 8-inch (20 cm) square baking pan and line the bottom with a sheet of parchment paper, letting it hang over two sides."),
                step(text: "In a bowl, over a double boiler or in the microwave oven, melt chocolate with butter. Let cool."),
                step(text: "In another bowl, combine eggs, brown sugar and salt with a whisk until the mixture is smooth. Add chocolate mixture and flour and stir until smooth. Pour into the prepared pan."),
                step(text: "Bake for about 23 to 25 minutes or until a toothpick inserted in the centre comes out with a few lumps and not completely clean."),
                step(text: "Let cool in the pan, about 2 hours. Remove from pan and cut into squares. Serve warm or cold.")
               ]
              )
    ]
}


extension Bool {
    func asString() -> String {
        switch self {
        case true:
            return "Yes"
        case false :
            return "No"
        }
    }
}
