//
//  Authentication.swift
//  VIBRUNCE
//
//  Created by Sri Kumbham on 2/19/22.
//

import SwiftUI

class Authentication: ObservableObject {
    @Published var isValidated = false
    
    func updateValidation(success: Bool) {
        withAnimation {
            isValidated = success
        }
    }
}
