import SwiftUI

struct ContentView: View {
    
    @State private var isInputViewPresented = false
    @State private var selectedButtonIndex: Int?
    @State private var inputValues: [(name: String, phoneNumber: String, date: Date)] = Array(repeating: ("", "", Date()), count: 30)
    @State private var previousInputValues: [(name: String, phoneNumber: String, date: Date)] = []
    @State private var isCancelButtonTapped = false
    @State private var showImage = false
    @State private var showConfirmationAlert = false
    
    
    var body: some View {
        
        ZStack  {
            
            //                        Color(UIColor(named: "darkBlue")!)
            
            LinearGradient(
                gradient: Gradient(colors: [
                    Color("darkBlue"),
                    Color("darkBlue2")
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .edgesIgnoringSafeArea(.all)
            
            
            VStack {
                
                Text("LungMor Bar")
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .frame(width: .none, height: .none, alignment: .topLeading)
                    .padding(.horizontal, -180)
                    .padding(.vertical, -10)
                    .padding(.top, 30)
                
                Image("pic1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
                    .onTapGesture {
                        self.showImage = true
                    }
                    .sheet(isPresented: $showImage) {
                        Image("pic1")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        //                            .padding()
                    }
                
                VStack(spacing: 10) {
                    ForEach(0..<6) { row in
                        HStack(spacing: 10) {
                            ForEach(0..<5) { column in
                                let index = row * 5 + column
                                let hasInputData = !inputValues[index].name.isEmpty || !inputValues[index].phoneNumber.isEmpty || !inputValues[index].date.description.isEmpty
                                let isInputDataCompleted = !inputValues[index].name.isEmpty && !inputValues[index].phoneNumber.isEmpty && !inputValues[index].date.description.isEmpty
                                
                                Button(action: {
                                    self.selectedButtonIndex = index
                                    self.previousInputValues = self.inputValues
                                    self.isInputViewPresented = true
                                }) {
                                    Text("\(index + 1)")
                                        .foregroundColor(Color("darkBlue"))
                                        .font(.headline)
                                        .frame(width: 58, height: 55)
                                        .background(selectedButtonIndex == index ? Color.white.opacity(0.5) : (isInputDataCompleted ? Color("Pinkky") : (hasInputData ? Color.white : Color.white)))
                                        .cornerRadius(10)
                                        .padding(1)
                                }
                                .sheet(isPresented: $isInputViewPresented) {
                                    InputView(name: $inputValues[selectedButtonIndex ?? 0].name,
                                              phoneNumber: $inputValues[selectedButtonIndex ?? 0].phoneNumber,
                                              date: $inputValues[selectedButtonIndex ?? 0].date,
                                              isPresented: $isInputViewPresented,
                                              isCancelButtonTapped: $isCancelButtonTapped, showConfirmationAlert: $showConfirmationAlert) {
                                        // When the save button is tapped, set the button color
                                        self.selectedButtonIndex.map { index in
                                            self.inputValues[index].name.isEmpty && self.inputValues[index].phoneNumber.isEmpty && self.inputValues[index].date.description.isEmpty ? nil : index
                                        }.map {
                                            self.selectedButtonIndex = $0
                                            self.isInputViewPresented = false
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                .padding(01)
                Text("หมายเหตุ: โต๊ะที่จองแล้วจะขึ้นสีชมพู")
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .frame(width: .none, height: .none)
                    .padding(.horizontal, 0)
                    .padding(.vertical, 10)
            }
        }
    }
    
    struct InputView: View {
        @State private var selectedImage: String?
        @State private var selectedDate = Date()
        @Binding var name: String
        @Binding var phoneNumber: String
        @Binding var date: Date
        @Binding var isPresented: Bool
        @Binding var isCancelButtonTapped: Bool
        @Binding var showConfirmationAlert: Bool
        let onSave: () -> Void
        
        var body: some View {
            NavigationView {
                List {
                    Section(header: Text("Reservation Page")
                            .font(.system(size: 20))
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.black)
                            .padding(.bottom, 10)) {
                            }
                    // Header image
                    Section(header: Image("Logo")
                        .resizable()
                        .frame(width: 294, height: 135)) {
                            // No content needed
                        }
                    
                    // Name input field
                    Section(header: Text("Name")) {
                        TextField("Name", text: $name)
                    }
                    
                    // Phone number input field
                    Section(header: Text("Phone Number")) {
                        TextField("Phone Number", text: $phoneNumber)
                            .keyboardType(.numberPad)
                            .onReceive(phoneNumber.publisher.collect()) { digits in
                                let filtered = digits.filter { "0123456789".contains($0) }
                                phoneNumber = String(filtered.prefix(10))
                            }
                    }
                    
                    // Date picker
                    Section(header: Text("Date")) {
                        DatePicker("Date", selection: $selectedDate, in: Date()...Date().addingTimeInterval(60*60*24*7), displayedComponents: [.date])
                            .environment(\.locale, Locale(identifier: "en"))
//                           .onAppear {
//                                let day = Calendar.current.component(.weekday, from: selectedDate)
//                                let daysToAdd = day == 1 ? 1 : day <= 2 ? 2 - day : 9 - day
//                                let nextMonday = Calendar.current.date(byAdding: .day, value: daysToAdd, to: selectedDate)!
//                                selectedDate = nextMonday
//                            }
//                            .onChange(of: selectedDate) { value in
//                                let day = Calendar.current.component(.weekday, from: value)
//                                if day != 2 { // 2 is Monday
//                                    let daysToAdd = day > 2 ? 9 - day : 2 - day
//                                    let nextMonday = Calendar.current.date(byAdding: .day, value: daysToAdd, to: value)!
//                                    selectedDate = nextMonday
//                                }
//                            }
//                            .onReceive($selectedDate.publisher.collect()) { Dates in
//                                guard let date = Dates.first else { return }
//                                let day = Calendar.current.component(.weekday, from: date)
//                                if day != 2 {
//                                    let daysToAdd = day > 2 ? 9 - day : 2 - day
//                                    let nextMonday = Calendar.current.date(byAdding: .day, value: daysToAdd, to: date)!
//                                    selectedDate = nextMonday
//                                }
//                            }
                    }
                    
                    // Save and cancel buttons
                    Section {
                        HStack {
                            Spacer()
                            
                            // Save button
                            Button(action: {
                                let isInputDataCompleted = !name.isEmpty && !phoneNumber.isEmpty && !date.description.isEmpty
                                if isInputDataCompleted {
                                    onSave()
                                }
                            }) {
                                Text("Reserve a table")
                                    .font(.headline)
                                    .buttonStyle(.bordered)
                                    .frame(width: 158, height: 44)
                                    .foregroundColor(.white)
                            }
                            .background(Color("darkBlue"))
                            .cornerRadius(10)
                            .padding()
                            .disabled(name.isEmpty && phoneNumber.isEmpty && date.description.isEmpty)
                            
                            Spacer()
                            
                            
                            Button(action: {
                                // Cancel button
                                isCancelButtonTapped = true
                                isPresented = false
                                
                            }) {
                                Text("cancel")
                                    .font(.headline)
                                    .buttonStyle(.bordered)
                                    .frame(width: 120, height: 44)
                                    .foregroundColor(.black)
                            }
                            .background(Color.white)
                            .cornerRadius(10)
                            .padding()
                            Spacer()
                            
                            }; {
                               Text("Cancel reservation1")
                                    .font(.headline)
                                    .buttonStyle(.bordered)
                                    .frame(width: 278, height: 44)
                                    .foregroundColor(.white)
                                    .alert(isPresented:$showConfirmationAlert) {
                                        Alert(title: Text("Cancel reservation"), message: Text("Are you sure you want to cancel all information?"), primaryButton: .destructive(Text("Cancel"), action: {
                                                self.name = ""
                                                self.phoneNumber = ""
                                                self.date = Date()
                                }), secondaryButton: .cancel(Text("Cancel")))
                                    }
                            }()
                                    .background(Color("darkBlue"))
                                    .cornerRadius(10)
                                    .padding()
                                    .disabled(name.isEmpty && phoneNumber.isEmpty && date.description.isEmpty)
                                                               
                                Spacer()
                                

                        }
                        
                        .listRowBackground(Color.blue.opacity(0))
                    }
                }
                
                
                //                            .padding(.top)
                //                            .navigationBarTitle(Text(""))
                //                            .navigationBarItems(trailing: Button(action: {
                //                                   isCancelButtonTapped = true
                //                                   isPresented = false
                //                               }, label: {
                //                                   Text("Cancel")
                //                               }))
            }
            //                        .padding()
            //                        .listRowBackground(Color.yellow)
            //                        .background(Color.yellow.edgesIgnoringSafeArea(.all))
        }
    }
    
    
    struct SwiftUIView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }

