//
//  MeloMateiOSApp.swift
//  MeloMateiOS
//
//  Created by Rick Liu on 2024-10-08.
//

import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

@main
struct MeloMateiOSApp: App {
    var body: some Scene {
        WindowGroup {
            SearchView()
        }
    }
}
