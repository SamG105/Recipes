//
//  Recipe+Struct.swift
//  Recipes
//
//  Created by Samuel Guay on 2023-05-22.
//

import SwiftUI

/// The basic thing in this app
struct Recipe: Identifiable, Codable {
    //MARK: required
    var id = UUID()

    
    
    //MARK: Fields
    var name: String
    var imageData: Data?
    /*var image: Image? {
        get {
            guard let data = imageData else { return nil }
            let uiImage: UIImage = UIImage(data: data)!
            return Image(uiImage: uiImage)
        }
        set {
            guard let value = newValue else {return}
            let uiImage = value.asUIImage()
            imageData = uiImage.pngData()
        }
    }*/
    var isFavorite: Bool
    var image: UIImage?
    var theme: Theme
    var description: String
    var notes: String = ""
    var link: URL?
    var rating: Double
    var preparationTime: time
    var cookingTime: time
    var chillingTime: time
    var portion: quantity
    var canFreeze: Bool
    
    var ingredients: [ingredient]
    var steps: [step]
    
    
    init(id: UUID = UUID(), name: String, image: UIImage, theme: Theme, description: String, notes: String = "", link: URL? = nil, rating: Double = 0, preparationTime: time, cookingTime: time, chillingTime: time, portion: quantity, canFreeze: Bool, isFavorite: Bool = false, ingredients: [ingredient], steps: [step]) {
        self.id = id
        self.name = name
        self.imageData = image.pngData()//image.asUIImage().pngData()
        self.image = image
        self.isFavorite = isFavorite
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
        static let empty = step(text: "")
    }
    
    //-MARK: Ingredients
    struct ingredient: Identifiable, Codable {
        var id: UUID = UUID()
        
        var name: String
        var isOnList = Bool()
        var massMeasurement: Measurement<UnitMass> = Measurement(value: 0, unit: .grams)
        var volumeMeasurement: Measurement<UnitVolume> = Measurement(value: 0, unit: .cups)
        var countableMeasurement: quantity = quantity(value: 0, unit: "")
        
        static let empty = ingredient(name: "")
    }
    
    //-MARK: Other
    
    struct time: Codable {
        var hours: Int = 0
        var minutes: Int = 0
    }
    struct quantity: Codable {
        var value: Int
        var unit: String
    }
    
    
    //-MARK: codable
    enum CodingKeys: String, CodingKey {
        case id, name, imageData, isFavorite, theme, description, notes, link, rating, preparationTime, cookingTime, chillingTime, portion, canFreeze, ingredients, steps
    }
    
    
    static let emptyRecipe = Recipe(name: "", image: UIImage(), theme: .cuisine, description: "", preparationTime: time(), cookingTime: time(), chillingTime: time(), portion: quantity(value: 0, unit: ""), canFreeze: false, ingredients: [], steps: [])
    
}

//-MARK: sampleData
extension Recipe {
    static let sampleData: [Recipe] = [
        Recipe(name: "Chewy Chocolate Chip Cookies (The Best)",
               image: (UIImage(named: "sample-Chocolate_Cookies") ?? UIImage(systemName: "plus.circle")) ?? UIImage(),//Image("sample-Chocolate_Cookies").asUIImage(),
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
        
        Recipe(name: "Classic Brownies",
               image: UIImage(named: "sample-Classic-Brownies") ?? UIImage(),
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

//-MARK: extentions
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

extension UnitMass: CaseIterable {
    public static var allCases: [UnitMass] {
        return [.grams, .ounces, .carats, .centigrams, .decigrams, .kilograms, .metricTons, .micrograms, .milligrams, .nanograms, .ouncesTroy, .picograms, .pounds, .shortTons, .slugs, .stones]
    }
}

extension UnitVolume: CaseIterable {
    public static var allCases: [UnitVolume] {
        return [.cups, .teaspoons, .tablespoons, .fluidOunces, .acreFeet, .bushels, .centiliters, .cubicCentimeters, .cubicDecimeters, .cubicFeet, .cubicInches, .cubicKilometers, .cubicMeters, .cubicMiles, .cubicMillimeters, .cubicYards , .deciliters, .gallons, .imperialFluidOunces, .imperialGallons, .imperialPints, .imperialQuarts, .imperialTablespoons, .imperialTeaspoons, .kiloliters, .liters, .megaliters, .metricCups, .milliliters, .pints, .quarts]
    }
}
