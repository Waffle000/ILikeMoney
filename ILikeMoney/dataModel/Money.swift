//
//  Money.swift
//  ILikeMoney
//
//  Created by Enrico Maricar on 27/03/24.
//

import Foundation
import SwiftData

@Model
class Money {
    var date: Date
    var note: String
    var name: String
    var icon: String
    var color: String
    var amount: String
    var param: Int
    
    
    init(date: Date, note: String, name: String, icon: String, color: String, amount: String, param: Int) {
        self.date = date
        self.note = note
        self.name = name
        self.icon = icon
        self.color = color
        self.amount = amount
        self.param = param
    }
}


