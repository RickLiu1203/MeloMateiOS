import SwiftUI

struct ParamsView: View {
    @State private var searchText: String = ""
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
             
            // Search Results Placeholder
            VStack {
                Spacer()
                Text("Set your Parameter")
                    .foregroundColor(.gray)
                    .fontWeight(.semibold)
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: 400)
            .background(Color(.white))
            .cornerRadius(10)
            .padding(.top, 4)
            .shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y: 5)
            
            Spacer()
            
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
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
            }
            .padding(.vertical, 8)
            
        }
        .padding(.horizontal, 32)
        .background(Color(.systemGray6).edgesIgnoringSafeArea(.all))
        .ignoresSafeArea(.keyboard)
        .onTapGesture {
            UIApplication.shared.endEditing() // Dismiss keyboard on tap anywhere
        }
    }
}

