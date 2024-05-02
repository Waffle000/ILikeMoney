//
//  Extension.swift
//  ILikeMoney
//
//  Created by Enrico Maricar on 26/03/24.
//

import Foundation
import SwiftUI

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

extension Color {
    static func spendingFromString(_ colorString: String) -> Color {
        switch colorString.lowercased() {
        case "bills":
            return .spending
        case "subscriptions":
            return .spending1
        case "entertainment":
            return .spending2
        case "food":
            return .spending3
        case "groceries":
            return .spending4
        case "health":
            return .spending5
        case "shopping":
            return .spending6
        case "transport":
            return .spending7
        case "travel":
            return .spending8
        case "savingCat":
            return .spending9
        default:
            return .spending10
        }
    }
}

extension Color {
    static func fromString(_ colorString: String) -> Color {
        switch colorString.lowercased() {
        case "bills":
            return .spending
        case "subscriptions":
            return .spending1
        case "entertainment":
            return .spending2
        case "food":
            return .spending3
        case "groceries":
            return .spending4
        case "health":
            return .spending5
        case "shopping":
            return .spending6
        case "transport":
            return .spending7
        case "travel":
            return .spending8
        case "savingCat":
            return .spending9
        case "other":
            return .spending10
        case "otherIncome":
            return .income
        case "salary":
            return .income1
        case "gift received":
            return .income2
        case "investment":
            return .income3
        case "freelance":
            return .income4
        case "business":
            return .income5
        default:
            return .income6
        }
    }
}
