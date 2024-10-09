//
//  ResultsView.swift
//  MeloMateiOS
//
//  Created by Rick Liu on 2024-10-09.
//

import SwiftUI

struct ResultsView: View {
    @State private var searchText: String = ""
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var shouldPopToRootView : Bool
    
    var btnBack : some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
            Text("‹ Step 2")
                .foregroundColor(.green)
                .fontWeight(.bold)
            }
        }
        .padding(.horizontal, 10)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Step 1 Title
            Text("Step 3")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.green)
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: btnBack)
                .navigationBarTitle("", displayMode: .inline)
            
            // Subtitle
            Text("Get Recommendations")
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.gray)
             
            // Search Results Placeholder
            VStack {
                Spacer()
                Text("Recommendations Will Show Here")
                    .foregroundColor(.gray)
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .background(Color(.white))
            .cornerRadius(10)
            .padding(.top, 4)
            .shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y:5)
            
            Spacer()
            
            Button (action: { self.shouldPopToRootView = false } ) {
                Text("Start Over")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.25), radius: 5, x: 0, y: 5)
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



