//
//  customFount.swift
//  Kayan
//
//  Created by Sandal on 17/11/1442 AH.
//

import SwiftUI

struct customFountCR : ViewModifier {
        func body(content: Content) -> some View {
            content
                .font(.custom("Cairo-Regular", size: 20))
        }
    }
struct customFountCB : ViewModifier {
        func body(content: Content) -> some View {
            content
                .font(.custom("Cairo-Black", size: 16))
        }
    }

