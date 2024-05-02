//
//  TransactionItem.swift
//  ILikeMoney
//
//  Created by Enrico Maricar on 24/03/24.
//

import SwiftUI

struct RecentTransactionItem: View {
    @State var note : String
    @State var date : Date
    @State var amount : String
    @State var param : Int
    @State var icon : String
    @State var color : String
    
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
                Circle().fill(Color.fromString(color)).frame(width: 40, height: 40).overlay(
                    Image(icon).resizable().frame(width: 24, height: 24)
                )
                
                VStack(alignment: .leading) {
                    Text(note).font(.callout).bold().foregroundColor(.white)
                    Text(dateFormatter.string(from: date)).font(.caption).foregroundColor(.white)
                }
                
                Spacer()
                
                Image(systemName: param == 1 ? "plus" : "minus").foregroundColor(param == 1 ? .greenUp : .redDown)
                Text(numberFormatter.string(from: NSNumber(value: Double(amount) ?? 0.0)) ?? "").font(.callout).foregroundStyle(param == 1 ? .greenUp : .redDown)
            }
            
            Rectangle().fill(.white).frame(height: 1).padding(.horizontal, 8).padding(.top, 8)
        }.padding(.vertical, 8)
    }
}

//#Preview {
//    RecentTransactionItem(note: "")
//}
