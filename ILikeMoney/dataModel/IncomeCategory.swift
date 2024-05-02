//
//  IncomeCategory.swift
//  ILikeMoney
//
//  Created by Enrico Maricar on 27/03/24.
//

import Foundation
import SwiftData

@Model
class IncomeCategory {
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
    
    static func defaultIncomeCategories() -> [IncomeCategory] {
            let categories = [
                IncomeCategory(name: "Other", icon: "other", color: "otherIncome", isSelected: false),
                IncomeCategory(name: "Salary", icon: "salary", color: "salary", isSelected: false),
                IncomeCategory(name: "Gift Received", icon: "gift", color: "gift", isSelected: false),
                IncomeCategory(name: "Investment", icon: "investment", color: "investment", isSelected: false),
                IncomeCategory(name: "Freelance", icon: "freelance", color: "freelance", isSelected: false),
                IncomeCategory(name: "Business", icon: "business", color: "business", isSelected: false),
                
            ]
            return categories
        }
}
