//
//  ReportView.swift
//  ILikeMoney
//
//  Created by Enrico Maricar on 25/03/24.
//

import SwiftUI
import Charts
import SwiftData


struct ReportView: View {
    @State private var source = "Income"
    var sources = ["Income", "Spending"]
    var body: some View {
        
        ZStack(alignment: .topLeading) {
            Color.primaryBackground.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            ScrollView {
                VStack(alignment: .center) {
                    
                    HStack {
                        ZStack {
                            Text("Report").foregroundColor(.white).font(.title2).bold()
                        }.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                        Spacer()
                    }.padding()
                    
                    
                    Picker("What is your favorite color?", selection: $source) {
                        ForEach(sources, id: \.self) {
                            Text($0)
                        }
                    }
                    .background(.secondaryBackground)
                    .cornerRadius(8)
                    .padding()
                    .pickerStyle(.segmented)
                    
                    if source == "Income" {
                        IncomeReportView()
                    } else {
                        SpendingReportView()
                    }
                }
            }
        }
    }
    
}

struct IncomeReportView: View {
    @Query(filter: #Predicate<Money> { $0.param == 1 }, sort: \Money.date) var transaction : [Money]

    struct TransactionSummary: Identifiable {
        let id: UUID
        var category: String
        var count: Int
        var color: String
        
        init(category: String, count: Int, color: String) {
            self.id = UUID()
            self.category = category
            self.count = count
            self.color = color
        }
    }

    var body: some View {
        VStack {
            HStack {
                Image(systemName: "arrowtriangle.left").foregroundColor(.white)
                
                Spacer()
                
                Text("February 2024").foregroundColor(.white)
                
                Spacer()
                
                Image(systemName: "arrowtriangle.right").foregroundColor(.white)
            }.padding()
            
            Chart(Dictionary(grouping: transaction) { $0.name }.map { (category, transactionsInCategory) -> TransactionSummary in
                TransactionSummary(category: category, count: transactionsInCategory.count, color: transactionsInCategory.first?.color ?? "")
            }) { product in
                SectorMark(
                    angle: .value(
                        Text(verbatim: product.category),
                        product.count
                    ),
                    innerRadius: .ratio(0.6),
                    angularInset: 8
                )
                .foregroundStyle(Color.fromString(product.color))
            }.frame(width: 240, height: 240).padding(.top, 16).padding(.bottom, 32).chartLegend(.hidden)
            
            
            ZStack(alignment: .topLeading) {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Income Transaction").font(.headline).foregroundColor(.primaryText)
                        Spacer()
                    }.padding(.horizontal, 16).padding(.top, 16)
                    
                    LazyVStack {
                        ForEach(Dictionary(grouping: transaction) { $0.name }.keys.sorted(), id: \.self) { key in
                            CategoryTransactionItem(groupedTransactions: Dictionary(grouping: transaction) { $0.name }, key: key)
                        }
                    }
                    .padding(.top, 8).padding(.horizontal, 16)
                    
                }
            }.frame(maxWidth: .infinity, maxHeight: .infinity).background(.white).clipShape(
                .rect(
                    topLeadingRadius: 32,
                    bottomLeadingRadius: 0,
                    bottomTrailingRadius: 0,
                    topTrailingRadius: 32
                )
            )
        }
    }
}

struct SpendingReportView: View {
    @Query(filter: #Predicate<Money> { $0.param == 2 }, sort: \Money.date) var transaction : [Money]
    var groupedTransactions: [String: [Money]] {
        Dictionary(grouping: transaction) { $0.name }
        }
    
    struct TransactionSummary : Identifiable{
        var id: UUID
        
        var category: String
        var count: Int
        var color: String
        
        init(category: String, count: Int, color: String) {
                self.id = UUID()
                self.category = category
                self.count = count
                self.color = color
            }
    }

    struct TransactionManager {
        var transactions: [Money]
        
        func summarizeTransactionsByCategory() -> [TransactionSummary] {
            let groupedTransactions = Dictionary(grouping: transactions) { $0.name}
            let summaries = groupedTransactions.map { (category, transactionsInCategory) -> TransactionSummary in
                let color = transactionsInCategory.first?.color ?? ""
                return TransactionSummary(category: category, count: transactionsInCategory.count, color: color)
            }
            return summaries.sorted { $0.category < $1.category }
        }
    }
    
    var chartTransaction : [TransactionSummary] {
        TransactionManager(transactions: transaction).summarizeTransactionsByCategory()
    }
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "arrowtriangle.left").foregroundColor(.white)
                
                Spacer()
                
                Text("February 2024").foregroundColor(.white)
                
                Spacer()
                
                Image(systemName: "arrowtriangle.right").foregroundColor(.white)
            }.padding()
            
            Chart(chartTransaction) { product in
                SectorMark(
                    angle: .value(
                        Text(verbatim: product.category),
                        product.count
                    ),
                    innerRadius: .ratio(0.6),
                    angularInset: 8
                )
                .foregroundStyle(Color.fromString(product.color))
            }.frame(width: 240, height: 240).padding(.top, 16).padding(.bottom, 32).chartLegend(.hidden)
            
            
            ZStack(alignment: .topLeading) {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Income Transaction").font(.headline).foregroundColor(.primaryText)
                        Spacer()
                    }.padding(.horizontal, 16).padding(.top, 16)
                    
                    LazyVStack {
                        ForEach(groupedTransactions.keys.sorted(), id: \.self) { key in
                            CategoryTransactionItem(groupedTransactions: groupedTransactions, key: key)
                        }
                    }
                    .padding(.top, 8).padding(.horizontal, 16)
                    
                }
            }.frame(maxWidth: .infinity, maxHeight: .infinity).background(.white).clipShape(
                .rect(
                    topLeadingRadius: 32,
                    bottomLeadingRadius: 0,
                    bottomTrailingRadius: 0,
                    topTrailingRadius: 32
                )
            )
        }
    }
}

#Preview {
    ReportView()
}
