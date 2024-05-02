//
//  AddTransactionView.swift
//  ILikeMoney
//
//  Created by Enrico Maricar on 26/03/24.
//

import SwiftUI
import SwiftData

struct AddTransactionView: View {
    
    @State private var source = "Income"
    var sources = ["Income", "Spending"]
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.primaryBackground.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            ScrollView {
                VStack(alignment: .center) {
                    
                    HStack {
                        Text("Add Transaction").foregroundColor(.white).font(.title2).bold()
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
                        IncomeView()
                    } else {
                        SpendingView()
                    }
                    
                    
                    
                    
                }
            }
        }.navigationTitle("Add Transaction").foregroundColor(.white)
    }
}


struct IncomeView: View {
    @Environment(\.modelContext) var context
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var selectedDate = Date()
    @State private var amount: String = ""
    @State private var selectedCategory : IncomeCategory = IncomeCategory(name: "", icon: "", color: "", isSelected: false)
    @State private var note: String = ""
    let maxCharacters = 20
    @Query(sort: \IncomeCategory.name) var income : [IncomeCategory]
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Date").font(.headline).foregroundColor(.white)
                DatePicker("Select date", selection: $selectedDate, displayedComponents: .date)
                    .datePickerStyle(DefaultDatePickerStyle())
                
                
                Text("Category")
                    .font(.headline).foregroundColor(.white)
                Picker("Select category", selection: $selectedCategory) {
                    ForEach(income, id: \.self) { category in
                        Text(category.name).tag(category)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                
                
                Text("Note")
                    .font(.headline).foregroundColor(.white)
                
                ZStack(alignment: .trailing) {
                    TextField("", text: $note)
                        .placeholder(when: note.isEmpty) {
                            Text("Enter your note").foregroundColor(.gray)
                        }
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.clear)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.yellow, lineWidth: 2)
                        )
                        .accentColor(.yellow)
                        .onChange(of: note) {(oldValue: String, newValue: String) in
                                            if newValue.count > maxCharacters {
                                                note = String(newValue.prefix(maxCharacters))
                                            }
                                        }
                    Text("\(note.count)/\(maxCharacters)")
                        .foregroundColor(.gray).padding(.trailing, 16)
                }
                
                Text("Amount")
                    .font(.headline).foregroundColor(.white)
                TextField("", text: $amount)
                    .placeholder(when: amount.isEmpty) {
                        Text("Enter your amount").foregroundColor(.gray)
                    }
                    .keyboardType(.numberPad)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.clear)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.yellow, lineWidth: 2)
                    )
                    .accentColor(.yellow)

                
                Spacer()
                
                Button(action: saveData) {
                    Text("Save")
                        .foregroundColor(.primaryBackground)
                        .frame(maxWidth: .infinity)
                        .padding(8)
                        .background(Color.secondaryBackground)
                        .cornerRadius(16)
                }
                .padding(.top, 20)
            }
            .padding()
            
        }
    }
    
    private func saveData() {
        if selectedCategory.name == "" {
            selectedCategory = income[0]
        }
        let data = Money(date: selectedDate, note: note, name: selectedCategory.name
                         , icon: selectedCategory.icon, color: selectedCategory.color, amount: amount, param: 1)
        context.insert(data)
        presentationMode.wrappedValue.dismiss()
    }
}

struct SpendingView: View {
    @Environment(\.modelContext) var context
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var selectedDate = Date()
    @State private var amount: String = ""
    @State private var selectedCategory : SpendingCategory = SpendingCategory(name: "", icon: "", color: "", isSelected: false)
    @State private var note: String = ""
    let maxCharacters = 20
    @Query(sort: \SpendingCategory.name) var spending : [SpendingCategory]
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Date").font(.headline).foregroundColor(.white)
                DatePicker("Select date", selection: $selectedDate, displayedComponents: .date)
                    .datePickerStyle(DefaultDatePickerStyle())
                
                
                Text("Category")
                    .font(.headline).foregroundColor(.white)
                Picker("Select category", selection: $selectedCategory) {
                    ForEach(spending, id: \.self) { category in
                        Text(category.name).tag(category)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                
                
                Text("Note")
                    .font(.headline).foregroundColor(.white)
                
                ZStack(alignment: .trailing) {
                    TextField("", text: $note)
                        .placeholder(when: note.isEmpty) {
                            Text("Enter your note").foregroundColor(.gray)
                        }
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.clear)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.yellow, lineWidth: 2)
                        )
                        .accentColor(.yellow)
                        .onChange(of: note) {(oldValue: String, newValue: String) in
                                            if newValue.count > maxCharacters {
                                                note = String(newValue.prefix(maxCharacters))
                                            }
                                        }
                    Text("\(note.count)/\(maxCharacters)")
                        .foregroundColor(.gray).padding(.trailing, 16)
                }
                
                Text("Amount")
                    .font(.headline).foregroundColor(.white)
                TextField("", text: $amount)
                    .placeholder(when: amount.isEmpty) {
                        Text("Enter your amount").foregroundColor(.gray)
                    }
                    .keyboardType(.numberPad)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.clear)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.yellow, lineWidth: 2)
                    )
                    .accentColor(.yellow)

                
                Spacer()
                
                Button(action: saveData) {
                    Text("Save")
                        .foregroundColor(.primaryBackground)
                        .frame(maxWidth: .infinity)
                        .padding(8)
                        .background(Color.secondaryBackground)
                        .cornerRadius(16)
                }
                .padding(.top, 20)
            }
            .padding()
            
        }
    }
    
    private func saveData() {
        if selectedCategory.name == "" {
            selectedCategory = spending[0]
        }
        let data = Money(date: selectedDate, note: note, name: selectedCategory.name
                         , icon: selectedCategory.icon, color: selectedCategory.color, amount: amount, param: 2)
        context.insert(data)
        presentationMode.wrappedValue.dismiss()
    }
}

#Preview {
    AddTransactionView()
}
