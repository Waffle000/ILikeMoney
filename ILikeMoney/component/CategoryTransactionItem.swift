//
//  CategoryTransactionItem.swift
//  ILikeMoney
//
//  Created by Enrico Maricar on 26/03/24.
//

import SwiftUI

struct CategoryTransactionItem: View {
    @State var groupedTransactions : [String: [Money]]
    @State var key : String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Circle().frame(width: 40, height: 40).foregroundColor(Color.fromString((groupedTransactions[key] ?? [])[0].color))
                
                Text((groupedTransactions[key] ?? [])[0].name)
                Spacer()
            }
            
            LazyVStack {
                ForEach(groupedTransactions[key] ?? []) { transaction in
                    TransactionItem(note: transaction.note, date: transaction.date, param: transaction.param, amount: transaction.amount)
                    
                }
            }.padding(.horizontal, 16)
            
        }.padding(.vertical, 16)
    }
}

//#Preview {
//    CategoryTransactionItem()
//}
