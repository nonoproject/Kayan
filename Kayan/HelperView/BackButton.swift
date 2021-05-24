//
//  BackButton.swift
//  Kayan
//
//  Created by Sandal on 27/09/1442 AH.
//

import SwiftUI

struct BackButton: View {
    var horizontalPaddig:CGFloat=30.0
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        HStack{
            
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                
                Image(systemName: "chevron.right") // set image here
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.AppPrimaryColor)
                
            }
            Spacer()
        }.padding(.horizontal, horizontalPaddig)
        
    }
}

struct BackButton_Previews: PreviewProvider {
    static var previews: some View {
        BackButton()
    }
}
