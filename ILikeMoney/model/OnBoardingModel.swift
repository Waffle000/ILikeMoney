//
//  OnBoardingModel.swift
//  ILikeMoney
//
//  Created by Enrico Maricar on 24/03/24.
//

import Foundation

struct OnBoardingModel : Identifiable, Equatable {
    let id = UUID()
    var name : String
    var description : String
    var imageUrl: String
    var tag : Int
    
    static var page : OnBoardingModel = OnBoardingModel(name: "Welcome App", description: "See where your money goes. Effortlessly track every income and expense. Simplify your finances in one place. Begin today!", imageUrl: "", tag: 0)
    
    static var pages : [OnBoardingModel] = [
    OnBoardingModel(name: "Track Your Money", description: "See where your money goes. Effortlessly track every income and expense. Simplify your finances in one place. Begin today!", imageUrl: "saving", tag: 0),
    OnBoardingModel(name: "Categorize & Understand", description: "Gain clarity with categories. Understand the categories of your spending habits and income sources for better finances. Start organizing", imageUrl: "chart", tag: 1)
    ]
}
