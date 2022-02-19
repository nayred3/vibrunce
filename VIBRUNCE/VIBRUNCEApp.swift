//
//  VIBRUNCEApp.swift
//  VIBRUNCE
//
//  Created by Sri Kumbham on 2/15/22.
//

import SwiftUI

@main
struct VIBRUNCEApp: App {
    @StateObject var authentication = Authentication()
    var body: some Scene {
        WindowGroup {
            if authentication.isValidated {
                ContentView()
                    .environmentObject(authentication)
            } else {
                LoginViewPage()
                    .environmentObject(authentication)
            }
        }
    }
}
