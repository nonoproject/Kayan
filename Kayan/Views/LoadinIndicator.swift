//
//  LoadinIndicator.swift
//  Kayan
//
//  Created by Sandal on 01/01/1443 AH.
//

import SwiftUI
import SDWebImageSwiftUI
struct LoadinIndicator: View {
    var body: some View {
        
        AnimatedImage(name: "kayan_gif.gif").resizable()
            .frame(width: 250, height: 250, alignment: .center)
//            .background(Color.green)
    }
}

struct LoadinIndicator_Previews: PreviewProvider {
    static var previews: some View {
        LoadinIndicator()
    }
}
