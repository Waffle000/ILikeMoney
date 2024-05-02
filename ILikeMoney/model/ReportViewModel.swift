//
//  ReportViewModel.swift
//  ILikeMoney
//
//  Created by Enrico Maricar on 27/03/24.
//

import Foundation
import SwiftData
import SwiftUI

class ReportViewModel: ObservableObject {
    
    @Published var transaction : [Money]
    
    init(transaction: [Money]) {
        self.transaction = transaction
    }
    
}
