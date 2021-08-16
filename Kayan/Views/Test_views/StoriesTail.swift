//
//  StoriesTail.swift
//  Kayan
//
//  Created by Sandal on 07/01/1443 AH.
//

import SwiftUI

struct StoriesTail: View {
    
    @State var isPaid:Bool
    var subscribePrice:String=""
    @State var offsetY:CGFloat=0.0
    @State var ViewOpacity:Double=0.0
    @State var isSubscribed:Bool
    var body: some View {
        HStack(spacing:10){
            Spacer()
         if isPaid{
             if !isSubscribed{
                 Image("free_story").resizable().frame(width: 70, height: 50).overlay(
         VStack{
             Spacer()
             Text("مدفوع").foregroundColor(.white).fontWeight(.heavy).font(.system(size: 12))
             
             Text(subscribePrice).foregroundColor(.white).fontWeight(.bold).font(.system(size: 11))
             Spacer()
         }.padding()
     )
         }
         }
         else{
//                                                        Spacer()
             Image("payed_story").resizable().frame(width: 70, height: 50).overlay(
         VStack{
             Spacer()
             Text("مجانية").foregroundColor(.white).fontWeight(.bold).font(.system(size: 12)).frame(width:50,height:10).padding(.top,3)
//                                                        Spacer()
             Image(systemName:"gift").font(.system(size: 12, weight: .heavy)).foregroundColor(Color(#colorLiteral(red: 0.996468246, green: 0.6681806445, blue: 0.001119376859, alpha: 1))).frame(width:20,height:10).padding(.vertical,3)
             Spacer()
         }//.frame(width:50,height:34)
             )
         }
        }.frame(width:170).offset(x:40,y:-offsetY)
     .opacity(ViewOpacity)
     .onAppear{
//         print("dsds")
//         kkkkkdsds=0
//         kkkkk=0
        
//                                                    kkkkkd=0
         withAnimation(.easeIn(duration: 0.5)) {
            offsetY+=8
         }
         withAnimation(.easeIn(duration: 1)) {
             ViewOpacity=0.9
         }
     }
}
}
