//
//  ForgetPassword.swift
//  Kayan
//
//  Created by mohammed aburukbah on 13/09/1442 AH.
//

import SwiftUI

struct ForgetPassword: View {
    @State var phoneNumber=""
    @State var phoneNumberError:Bool=false
    @State var isForgetPass = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        
      GeometryReader{ geo in
          NavigationLink(destination: SignUp().navigationBarTitle(Text("Home"))
                          .navigationBarHidden(true), isActive: self.$isForgetPass) {
              
          }.hidden()
          
//            VStack{
//                Image("fllower").resizable().frame(width: 189,height: 189)
//                Spacer()
//            }
          ZStack(alignment: .bottom){
                  
                  LinearGradient(gradient: Gradient(colors: [Color.init(hex: "FCF1EF"), Color.init(hex: "BE9ECB"),Color.init(hex:"5461A7")]), startPoint: .topTrailing, endPoint: .bottomLeading)
                         .edgesIgnoringSafeArea(.vertical)
              
          HStack(spacing:30){
              VStack{
                  
              
                Image(systemName: "play.rectangle.fill").resizable().frame(width: 32, height: 30).foregroundColor(.brown).background(Color.white).cornerRadius(5).onTapGesture {
                    self.presentationMode.wrappedValue.dismiss()
                }
                Spacer()
              }.padding([.top,.leading],50)
              Spacer()
                  
                  
                  VStack(spacing:15){
                    
                    Text("نسيت كلمة السر").padding(.top,55)
                        .font(.headline)
                      Spacer()
                     
                      HStack{
                          TextField("", text: $phoneNumber).textFieldStyle(CTFStyleClearBackground(width: 250, cornerRadius: 20, height: 40, showError: $phoneNumberError))
                          Spacer()
                          HStack{
                              
                              Text("رقم الهاتف")
                          }.frame(width:100)
                      }.frame(width:380)

                      
                      HStack{
                          Text("تحقق").frame(width: 255,height: 40).background(Color.AppPrimaryColor).cornerRadius(10).font(.system(size: 15)).foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
                          Spacer()
                      }.frame(width:380)

                    Spacer()
                  }.frame(width:250).padding(.bottom,20)
              Spacer()
            Image("kayanSide").resizable().renderingMode(.none).frame(width: 220)
              }
              
          }
          
  }.environment(\.horizontalSizeClass, .compact)
  }
}
