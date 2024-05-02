//
//  Alarm.swift
//  ILikeMoney
//
//  Created by Enrico Maricar on 27/03/24.
//

import Foundation
import SwiftData

@Model
class Alarm {
    var id: String = UUID().uuidString
    var time: Date
    var note: String
    var isSelected: Bool
    
    init(time: Date, note: String, isSelected: Bool) {
        self.id = UUID().uuidString
        self.time = time
        self.note = note
        self.isSelected = isSelected
    }
}
