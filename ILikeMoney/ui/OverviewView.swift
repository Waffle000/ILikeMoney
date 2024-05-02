//
//  OverviewView.swift
//  ILikeMoney
//
//  Created by Enrico Maricar on 24/03/24.
//

import SwiftUI
import SwiftData

struct OverviewView: View {
    @Query(sort: \Money.date, order: .reverse) var transaction : [Money]
    @Query(filter: #Predicate<Money> { $0.param == 1 }, sort: \Money.date) var income : [Money]
    @Query(filter: #Predicate<Money> { $0.param == 2 }, sort: \Money.date) var spending : [Money]
    
    let numberFormatter: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.locale = Locale(identifier: "id_ID")
            return formatter
        }()
    
    func calculateTotalAmount(from moneyList: [Money]) -> Double {
        return moneyList.reduce(0.0) { total, money in
            total + (Double(money.amount) ?? 0.0)
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .topLeading) {
                VStack {
                    Rectangle()
                        .frame(maxWidth: .infinity, maxHeight: .infinity/2)
                        .foregroundColor(Color.white)
                        .edgesIgnoringSafeArea(.top)
                    
                    Rectangle()
                        .frame(maxWidth: .infinity, maxHeight: .infinity/2)
                        .foregroundColor(Color.primaryBackground)
                        .edgesIgnoringSafeArea(.bottom)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity).edgesIgnoringSafeArea(.top)
                
                ScrollView {
                    VStack(alignment: .leading) {
                        
                        VStack(alignment: .leading) {
                            
                            HStack(alignment: .center) {
                                VStack(alignment: .leading) {
                                    ZStack {
                                        Text("Overview").font(.title).bold().padding(.bottom, 8)
                                    }.frame(maxWidth: .infinity)
                                    
                                    Text("Total Balance").font(.title3).foregroundColor(.secondaryText)
                                    Text(numberFormatter.string(from: NSNumber(value: ((calculateTotalAmount(from: income) - (calculateTotalAmount(from: spending) ))) )) ?? "").font(.title2)
                                }
                                Spacer()
                                
                                
                            }
                            
                            VStack {
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("Income").font(.body)
                                        Text("+ \(numberFormatter.string(from: NSNumber(value: (calculateTotalAmount(from: income)) )) ?? "")").font(.headline).padding(.top, 2).bold()
                                    }.padding(8)
                                    
                                    Spacer()
                                    
                                    Rectangle().fill(.primary).frame(width: 1).padding(.vertical, 8)
                                    
                                    Spacer()
                                    
                                    VStack(alignment: .leading) {
                                        Text("Spendings").font(.body)
                                        Text("- \(numberFormatter.string(from: NSNumber(value: (calculateTotalAmount(from: spending)) )) ?? "")").font(.headline).padding(.top, 2).bold()
                                    }.padding(8)
                                }
                                
                                
                            }.padding().background(.secondaryBackground).edgesIgnoringSafeArea(.top).cornerRadius(32)
                            
                            NavigationLink(destination: AddTransactionView(), label: {
                                ZStack {
                                    HStack(alignment: .center) {
                                        Image(systemName: "plus.circle.fill").foregroundColor(.primaryBackground).font(.system(size: 32))
                                        Text("Add Transaction").font(.headline).foregroundColor(.primaryText).padding(.top, 2)
                                        
                                    }
                                    
                                }
                                .padding().frame(maxWidth: .infinity).background(.secondaryBackground).edgesIgnoringSafeArea(.top).cornerRadius(16)
                            })
                            
                        }.padding().background().clipShape(
                            .rect(
                                topLeadingRadius: 0,
                                bottomLeadingRadius: 32,
                                bottomTrailingRadius: 32,
                                topTrailingRadius: 0
                            )
                        )
                        
                        Text("Recent Transaction").font(.headline).padding(.top, 16).padding(.horizontal, 16).foregroundColor(.white)
                        
                        LazyVStack {
                            ForEach(transaction) { number in
                                RecentTransactionItem(note: number.note, date: number.date, amount: number.amount, param: number.param, icon: number.icon, color: number.color)
                            }
                        }.padding(.top, 8).padding(.horizontal, 16)
                    }.frame(maxWidth: .infinity, alignment: .leading).background(Color.primaryBackground)
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
                
            }
            .background(.white)
        }
        
    }
}

#Preview {
    OverviewView()
}
