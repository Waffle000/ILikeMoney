//
//  TransactionItem.swift
//  ILikeMoney
//
//  Created by Enrico Maricar on 25/03/24.
//

import SwiftUI

struct TransactionItem: View {
    @State var note: String
    @State var date: Date
    @State var param: Int
    @State var amount: String
    
    let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            formatter.timeStyle = .short
            return formatter
        }()
    
    let numberFormatter: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.locale = Locale(identifier: "id_ID")
            return formatter
        }()
    
    var body: some View {
        VStack {
            HStack {
                
                VStack(alignment: .leading) {
                    Text(note).font(.callout).bold().foregroundColor(.primaryText)
                    Text(dateFormatter.string(from: date)).font(.caption).foregroundColor(.primaryText)
                }
                
                Spacer()
                
                Image(systemName: param == 1 ? "plus" : "minus").foregroundColor(.primaryText)
                Text(numberFormatter.string(from: NSNumber(value: Double(amount) ?? 0.0)) ?? "").font(.callout).foregroundStyle(.primaryText)
            }
            
            Rectangle().fill(.primaryText).frame(height: 1).padding(.horizontal, 8).padding(.top, 8)
        }.padding(.vertical, 8)
    }
}

//#Preview {
//    TransactionItem()
//}
