//
//  ChooseReminderView.swift
//  ILikeMoney
//
//  Created by Enrico Maricar on 24/03/24.
//

import SwiftUI
import SwiftData

struct ChooseCategoryView: View {
    @Environment(\.modelContext) var context
    @State var incomeCategories = IncomeCategory.defaultIncomeCategories()
    @State var spendingCategories = SpendingCategory.defaultSpendingCategories()
    
    @Query(sort: \IncomeCategory.name) var income : [IncomeCategory]
    @Query(sort: \SpendingCategory.name) var spending : [SpendingCategory]
    
    @State var chooseIncomeCategories : [IncomeCategory] = []
    @State var chooseSpendingCategories : [SpendingCategory] = []
    
    @State private var isNavigationTriggered = false
    
    @State private var isSelected: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Lets categorize your income and expenses").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).bold()
                ScrollView {
                    VStack(alignment: .leading) {
                        Text("Choose your category income").padding(.top, 16)
                        FlowLayout(incomeCategories) { tag in
                            Button(action: {
                                tag.isSelected.toggle()
                                if tag.isSelected {
                                    context.insert(tag)
                                } else {
                                    context.delete(tag)
                                }
                            }, label: {
                                HStack {
                                    Image("\(tag.icon)").resizable().frame(width: 24, height: 24)
                                    Text(tag.name).bold()
                                }.foregroundColor(.black)
                                    .padding(8)
                                    .background(tag.isSelected ? Color.greenWhite : Color.clear)
                                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(.gray, lineWidth: 1.5))
                                
                                    
                            })
                        }
                        
                        Text("Choose your category spending").padding(.top, 16)
                        ScrollView {
                            FlowLayout(spendingCategories) { tag in
                                Button(action: {
                                    tag.isSelected.toggle()
                                    if tag.isSelected {
                                        context.insert(tag)
                                    } else {
                                        context.delete(tag)
                                    }
                                }, label: {
                                    HStack {
                                        Image("\(tag.icon)").resizable().frame(width: 24, height: 24)
                                        Text(tag.name).bold()
                                    }.foregroundColor(.black)
                                        .padding(8)
                                        .background(tag.isSelected ? Color.redWhite : Color.clear)
                                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(.gray, lineWidth: 1.5))
                                    
                                        
                                })
                            }
                        }
                    }
                    
                }

                
                NavigationLink(destination: OpenReminderView(), label: {
                    Text("Next").foregroundColor(.primaryBackground)
                        .frame(maxWidth: .infinity)
                        .padding(16)
                        .background(Color.secondaryBackground)
                        .cornerRadius(16)
                })
            }.padding()
        }.navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ChooseCategoryView()
}
