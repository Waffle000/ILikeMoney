//
//  ReminderView.swift
//  ILikeMoney
//
//  Created by Enrico Maricar on 25/03/24.
//

import SwiftUI
import SwiftData

struct ReminderView: View {
    let notify = NotificationHandler()
    @StateObject var viewModel = ReminderViewModel()
    @State private var showingAlarmSettings = false
    
    @Query(sort: \Alarm.time) var alarm: [Alarm]
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.primaryBackground.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack(alignment: .leading) {
                HStack {
                    Text("Settings").foregroundColor(.white).font(.title2).bold().padding()
                    Spacer()
                    Button("Add") {
                        notify.hasNotificationPermission { granted in
                            if granted {
                                showingAlarmSettings = true
                            } else {
                                notify.askPermission()
                            }
                        }
                    }.foregroundColor(.white).padding(.trailing, 16)
                }
                
                LazyVStack {
                    ForEach(alarm) { number in
                        ReminderItem(viewModel: viewModel, alarm: number)
                    }
                }.padding(.top, 8).padding(.horizontal, 16)
            }
        }
        .sheet(isPresented: $showingAlarmSettings) {
            AlarmSettingsView(viewModel: viewModel)
        }
    }
}

struct AlarmSettingsView: View {
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
                        viewModel.addAlarm(for: data)
                        presentationMode.wrappedValue.dismiss()
                    }.foregroundColor(.secondaryBackground)
                }
            }
        }
    }
}

//#Preview {
//    ReminderView()
//}
