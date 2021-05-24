//
//  VarificationCode.swift
//  Kayan
//
//  Created by mohammed aburukbah on 13/09/1442 AH.
//

import SwiftUI

struct VarificationCode: View {
    @State var ActiveCode=""
    @State var ActiveCodeError:Bool=false
    @State var isActiveCodePass = false
    @State var timeRemaining=50
    var body: some View {
        
      GeometryReader{ geo in
//          NavigationLink(destination: SignUp().navigationBarTitle(Text("Home"))
//                          .navigationBarHidden(true), isActive: self.$isActiveCodePass) {
//
//          }.hidden()
          
          ZStack(alignment: .bottom){
                  
                  LinearGradient(gradient: Gradient(colors: [Color.init(hex: "FCF1EF"), Color.init(hex: "BE9ECB"),Color.init(hex:"5461A7")]), startPoint: .topTrailing, endPoint: .bottomLeading)
                         .edgesIgnoringSafeArea(.vertical)
              
          HStack(spacing:30){
              VStack{
                  
              
                  Image(systemName: "play.rectangle.fill").resizable().frame(width: 32, height: 30).foregroundColor(.brown).background(Color.white).cornerRadius(5)
  
  Spacer()
              }.padding([.top,.leading],50)
              Spacer()
                  
                  
                  VStack(spacing:15){
                    
                    Text(" أدخل رمز التحقق ").padding(.top,55)
                        .font(.headline)
                      Spacer()
                     
                      HStack{
                          TextField("", text: $ActiveCode).textFieldStyle(CTFStyleClearBackground(width: 250, cornerRadius: 20, height: 40, showError: $ActiveCodeError))
                          Spacer()
                          HStack{
                              
                              Text("رقم الهاتف")
                          }.frame(width:100)
                      }.frame(width:380)

                    VStack(spacing:15){
                      HStack{
                          Text("تحقق").frame(width: 255,height: 40).background(Color.AppPrimaryColor).cornerRadius(10).font(.system(size: 15)).foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
                          Spacer()
                      }.frame(width:380)
                        Text("ستنتهي صلاحية كود التفعيل بعد \(timeRemaining)").foregroundColor(Color.init(hex: "293780")).padding(.vertical)
                        Text("إعادة إرسال الرمز").font(.subheadline).fontWeight(.semibold)
                    }
                    Spacer()
                  }.frame(width:250).padding(.bottom,20)
              Spacer()
            Image("kayanSide").resizable().renderingMode(.none).frame(width: 220)
              }
              
          }
          
  }.environment(\.horizontalSizeClass, .compact)
  }
}
