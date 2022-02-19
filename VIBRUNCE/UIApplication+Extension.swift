//
//  UIApplication+Extension.swift
//  VIBRUNCE
//
//  Created by Sri Kumbham on 2/19/22.
//

import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
