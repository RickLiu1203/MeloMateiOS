import SwiftUI

struct ParamsView: View {
    @State private var searchText: String = ""
    @State private var speed = 50.0
    @State private var isEditing = false
    @State private var selectedAction = "None"
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var rootIsActive : Bool
    
    var btnBack : some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
            Text("‹ Step 1")
                .foregroundColor(.green)
                .fontWeight(.bold)
            }
        }
        .padding(.horizontal, 10)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Step 2 Title
            Text("Step 2")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.green)
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: btnBack)
                .navigationBarTitle("", displayMode: .inline)
            
            // Subtitle
            Text("Set Your Parameter")
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.gray)
            
            Picker("Actions", selection: $selectedAction) {
                Text("Popularity").tag("Duplicate")
                    .foregroundColor(.green)
                    .fontWeight(.semibold)
                Text("Energy").tag("Rename")
                    .foregroundColor(.green)
                    .fontWeight(.semibold)
                Text("Danceability").tag("Delete")
                    .foregroundColor(.green)
                    .fontWeight(.semibold)
            }
                .frame(maxWidth: .infinity, maxHeight: 100)
                .pickerStyle(.wheel)
                .background(Color.white) // Set background to white
                .cornerRadius(10)
            
            Text("Adjust the Slider")
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.gray)

             
            // Search Results Placeholder
            VStack {
                Slider(
                        value: $speed,
                        in: 0...5,
                        step: 1
                    ) {
                        Text("Speed")
                    } minimumValueLabel: {
                        Text("0")
                    } maximumValueLabel: {
                        Text("5")
                    } onEditingChanged: { editing in
                        isEditing = editing
                    }
                    .accentColor(.green)
                    .padding(.vertical, 16)
                    .padding(.horizontal, 20)
                    .cornerRadius(8)
            }
            .frame(maxWidth: .infinity)
            .background(Color(.white))
            .cornerRadius(10)
            .padding(.top, 4)
            
            Spacer()
            
            VStack {
                Spacer()
                Text("Disclaimer text")
                    .foregroundColor(.gray)
                    .fontWeight(.semibold)
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: 100)
            .background(Color(.white))
            .cornerRadius(10)
            .padding(.top, 4)
            
            // NavigationLink to Step 3
            NavigationLink(destination: ResultsView(shouldPopToRootView: self.$rootIsActive)) {
                Text("Go to Step 3")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .cornerRadius(10)
            }
            .padding(.vertical, 8)
            
        }
        .padding(.horizontal, 32)
        .background(Color(hex: "#f1f5f9").edgesIgnoringSafeArea(.all))
        .ignoresSafeArea(.keyboard)
        .onTapGesture {
            UIApplication.shared.endEditing() // Dismiss keyboard on tap anywhere
        }
    }
}

