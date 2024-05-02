//
//  OpenReminderView.swift
//  ILikeMoney
//
//  Created by Enrico Maricar on 28/03/24.
//

import SwiftUI

struct OpenReminderView: View {
    let notify = NotificationHandler()
    @StateObject var viewModel = ReminderViewModel()
    @State private var isTurnOn = false
    @State private var showingReminderSettings = false
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                ZStack {
                    Text("Reminder").font(.title2).bold().padding(.bottom, 8)
                }.frame(maxWidth: .infinity)
                Image("notification")
                    .resizable()
                    .padding()
                    .scaledToFit()
                    .cornerRadius(16)
                HStack {
                    Text("Enable to get notifications for financial records")
                        .font(.body)
                    Spacer()
                    
                    Toggle("", isOn: $viewModel.isEnable).onChange(of: viewModel.isEnable) { oldValue, newValue in
                        if viewModel.isEnable {
                            notify.hasNotificationPermission { granted in
                                if granted {
                                    showingReminderSettings = true
                                } else {
                                    notify.askPermission()
                                }
                            }
                        }
                     
                    }
                }.padding().background(Color.clear)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.yellow, lineWidth: 2)
                    )
                
                NavigationLink(destination: NavigationBarView(), label: {
                    Text("Get Starter").foregroundColor(.primaryBackground)
                        .frame(maxWidth: .infinity)
                        .padding(16)
                        .background(Color.secondaryBackground)
                        .cornerRadius(16)
                }).padding(.top, 32)
            }.padding().sheet(isPresented: $showingReminderSettings) {
                AlarmSettingsView(viewModel: viewModel)
            }
        }.navigationBarBackButtonHidden(true)
        
    }
}

struct ReminderSettingsView: View {
    @ObservedObject var viewModel = ReminderViewModel()
    @Environment(\.modelContext) var context
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var selectedTime = Date()
    @State private var note: String = ""
    let maxCharacters = 20
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                Color.primaryBackground.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                VStack {
                    DatePicker("Waktu Alarm", selection: $selectedTime, displayedComponents: .hourAndMinute)
                        .datePickerStyle(WheelDatePickerStyle())
                        .labelsHidden()
                        .accentColor(.white)
                    
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
                    }.padding()
                }.preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
            }
            .navigationTitle("Setting Alarm")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        let data = Alarm(time: selectedTime, note: note, isSelected: true)
                        context.insert(data)
                        viewModel.addReminder(for: data)
                        presentationMode.wrappedValue.dismiss()
                    }.foregroundColor(.secondaryBackground)
                }
            }
        }
    }
}

#Preview {
    OpenReminderView()
}
