//
//  SpendingCategory.swift
//  ILikeMoney
//
//  Created by Enrico Maricar on 27/03/24.
//

import Foundation
import SwiftData

@Model
class SpendingCategory {
    var name: String
    var icon: String
    var color: String
    var isSelected: Bool = false
    
    
    init(name: String, icon: String, color: String, isSelected: Bool) {
        self.name = name
        self.icon = icon
        self.color = color
        self.isSelected = isSelected
    }
    
    static func defaultSpendingCategories() -> [SpendingCategory] {
            let categories = [
                SpendingCategory(name: "Other", icon: "other", color: "other", isSelected: false),
                SpendingCategory(name: "Bills", icon: "bills", color: "bills", isSelected: false),
                SpendingCategory(name: "Subscriptions", icon: "subscriptions", color: "subscriptions", isSelected: false),
                SpendingCategory(name: "Entertainment", icon: "entertainment", color: "entertainment", isSelected: false),
                SpendingCategory(name: "Food & Drink", icon: "food", color: "food", isSelected: false),
                SpendingCategory(name: "Groceries", icon: "groceries", color: "groceries", isSelected: false),
                SpendingCategory(name: "Health & Wellbeing", icon: "health", color: "health", isSelected: false),
                SpendingCategory(name: "Shopping", icon: "shopping", color: "shopping", isSelected: false),
                SpendingCategory(name: "Transport", icon: "transport", color: "transport", isSelected: false),
                SpendingCategory(name: "Travel", icon: "travel", color: "travel", isSelected: false),
                SpendingCategory(name: "Saving", icon: "savingCat", color: "savingCat", isSelected: false)
               
            ]
            return categories
        }
}
