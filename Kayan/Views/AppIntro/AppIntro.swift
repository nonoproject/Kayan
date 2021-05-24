//
//  AppIntro.swift
//  Kayan
//
//  Created by Awad sandal on 30/03/2021.
//

import SwiftUI
import SwiftUIX
struct AppIntro: View {
    var body: some View {
        PaginationView(axis: .horizontal) {
            ForEach(0..<1, id: \.hashValue) { index in
                Image("kayanCover").resizable()
            }
        }
        
    }
}

struct AppIntro_Previews: PreviewProvider {
    static var previews: some View {
        AppIntro()
    }
}
