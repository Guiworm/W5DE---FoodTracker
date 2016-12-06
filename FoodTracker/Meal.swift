//
//  Meal.swift
//  FoodTracker
//
//  Created by Jane Appleseed on 5/26/15.
//  Copyright © 2015 Apple Inc. All rights reserved.
//  See LICENSE.txt for this sample’s licensing information.
//

import UIKit

class Meal: NSObject, NSCoding {
    // MARK: Properties
    
    var name: String
    var photo: UIImage?
    var rating: Int
	var calories: Int
	var mealDescription: String
    
    // MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meals")
    
    // MARK: Types
    
    struct PropertyKey {
        static let nameKey = "name"
        static let photoKey = "photo"
        static let ratingKey = "rating"
		static let caloriesKey = "calories"
		static let mealDescriptionKey = "mealDescription"

    }

    // MARK: Initialization
    
	init?(name: String, photo: UIImage?, rating: Int, calories: Int, mealDescription: String) {
        // Initialize stored properties.
        self.name = name
        self.photo = photo
        self.rating = rating
		self.calories = calories
		self.mealDescription = mealDescription
        
        super.init()
        
        // Initialization should fail if there is no name or if the rating is negative.
        if name.isEmpty || rating < 0 {
            return nil
        }
    }
    
    // MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.nameKey)
        aCoder.encode(photo, forKey: PropertyKey.photoKey)
        aCoder.encode(rating, forKey: PropertyKey.ratingKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: PropertyKey.nameKey) as! String
        
        // Because photo is an optional property of Meal, use conditional cast.
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photoKey) as? UIImage
        
        let rating = aDecoder.decodeInteger(forKey: PropertyKey.ratingKey)
		
		let calories = aDecoder.decodeInteger(forKey: PropertyKey.caloriesKey)
		
		let mealDescription = aDecoder.decodeObject(forKey: PropertyKey.mealDescriptionKey) as! String

		
        // Must call designated initializer.
        self.init(name: name, photo: photo, rating: rating, calories: calories, mealDescription: mealDescription)
    }

}
