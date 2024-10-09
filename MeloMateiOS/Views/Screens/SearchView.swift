//
//  SearchView.swift
//  MeloMateiOS
//
//  Created by Rick Liu on 2024-10-08.
//

import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}


struct SearchView: View {
    @State private var searchText: String = ""
    @State var isActive : Bool = false
    
    struct SuperTextField: View {
        
        var placeholder: Text
        @Binding var text: String
        var editingChanged: (Bool)->() = { _ in }
        var commit: ()->() = { }
        
        var body: some View {
            ZStack(alignment: .leading) {
                if text.isEmpty { placeholder }
                TextField("", text: $text, onEditingChanged: editingChanged, onCommit: commit)
            }
        }
        
    }
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading, spacing: 8) {
                // Step 1 Title
                Text("Step 1")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.green)
                    .padding(.top, 20)
                    .navigationTitle("Step 1")
                    .navigationBarHidden(true)
                
                // Subtitle
                Text("Search For Tracks")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                
                // Search Bar
                SuperTextField(placeholder: Text("Search for a Track...").foregroundColor(.gray).fontWeight(.semibold), text: $searchText)
                    .padding(16)
                    .padding(.horizontal, 6)
                    .background(Color(.white))
                    .cornerRadius(10)
                    .foregroundColor(Color.gray)
                    .fontWeight(.semibold)
                
                // Search Results Placeholder
                VStack {
                    Spacer()
                    Text("Search Results Will Show Up Here")
                        .foregroundColor(.gray)
                        .fontWeight(.semibold)
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .background(Color(.white))
                .cornerRadius(10)
                .padding(.top, 4)
                
                NavigationLink(
                    destination: ParamsView(rootIsActive: self.$isActive),
                    isActive: self.$isActive){
                    Text("Go to Step 2")
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
            .background(Color(hex: "#f1f5f9").edgesIgnoringSafeArea(.all))
            .ignoresSafeArea(.keyboard)
            .onTapGesture {
                UIApplication.shared.endEditing() // Dismiss keyboard on tap anywhere
            }
        }
    }
}


struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
