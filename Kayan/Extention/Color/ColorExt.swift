//
//  ColorExt.swift
//  Kayan
//
//  Created by Awad sandal on 01/04/2021.
//

import Foundation
import SwiftUI
extension Color {
//    static let AppFontColor = Color("FontColor")
    static let AppPrimaryColor = Color("PrimaryColor")
    static let AppSecoundryColor = Color("SecondaryColor")
    static let Appliver = Color("Appliver")
//    static let gray = Color("strockColor")
////    static let black = Color("strockColor")
//    
//    static let AppShadow = Color("AppShadow")
//    static let activeColor = Color("activeColor")
//    static let Categorytab = Color("Categorytab")
//    static let activeShopColor = Color("activeShopColor")
//    static let mainBage = Color("mainBage")
    
    
//    static let AppTextFiledColor = Color("AppTextFiledColor")
}



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
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
