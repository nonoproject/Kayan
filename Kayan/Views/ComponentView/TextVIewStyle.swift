//
//  TextVIewStyle.swift
//  Kayan
//
//  Created by Awad sandal on 30/03/2021.
//

import SwiftUI

public struct CTFStyleClearBackground : TextFieldStyle {
    var width:CGFloat=376
    var cornerRadius:CGFloat=20
    var height:CGFloat=50
    var lineWidth:CGFloat=0.6
    
    @Binding var showError:Bool
   public func _body(configuration: TextField<Self._Label>) -> some View {
       configuration
           .foregroundColor(.blue)
           .multilineTextAlignment(.center)
           .frame(width: width, height:height)
           .background(
               RoundedRectangle(cornerRadius: 5)
               .foregroundColor(Color.white)
               .background(RoundedRectangle(cornerRadius: 5)
                            .stroke((showError ) ? Color(#colorLiteral(red: 0.8172891695, green: 0.3017711901, blue: 0.3019049658, alpha: 0.9075610017)) : Color.gray, lineWidth:showError  ? 1.5 : lineWidth)
               )
           )
       
           

   }
}

public struct TextClearForground : TextFieldStyle {
   public func _body(configuration: TextField<Self._Label>) -> some View {
       configuration
           
           .multilineTextAlignment(.center)
           .frame( height: 40)
           .background(
               RoundedRectangle(cornerRadius: 12)
               .foregroundColor(Color.white)
               .background(RoundedRectangle(cornerRadius: 12)
               .stroke(Color.gray, lineWidth: 2))
           )
       
           

   }
}




public struct TextClearBoarder : TextFieldStyle {
   public func _body(configuration: TextField<Self._Label>) -> some View {
       configuration
           .foregroundColor(.black)
           .multilineTextAlignment(.center)
           .frame( height: 40)
//            .background(
//                RoundedRectangle(cornerRadius: 12)
//                foregroundColor(Color.AppSecoundryColor)
//                .background(RoundedRectangle(cornerRadius: 12)
//                )
//            )
       
           

   }
}
