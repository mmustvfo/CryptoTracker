//
//  UIApplication.swift
//  CtyptoTracker
//
//  Created by Mustafo on 04/06/21.
//

import Foundation
import SwiftUI


extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
