//
//  HideKeyboard.swift
//  Kayan
//
//  Created by mohammed aburukbah on 21/09/1442 AH.
//



import SwiftUI
#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
