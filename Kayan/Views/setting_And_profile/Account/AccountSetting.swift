//
//  AccountSetting.swift
//  Kayan
//
//  Created by Awad sandal on 06/04/2021.
//

import SwiftUI

struct AccountSetting: View {
    @State var phoneNumber=""
    @State var phoneNumberError:Bool=false
    @State var isSignUp = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
          
        GeometryReader{ geo in
            NavigationLink(destination: SignUp().navigationBarTitle(Text("Home"))
                            .navigationBarHidden(true), isActive: self.$isSignUp) {
                
            }.hidden()
            
//            VStack{
//                Image("fllower").resizable().frame(width: 189,height: 189)
//                Spacer()
//            }
            ZStack(alignment: .bottom){
                    
                    LinearGradient(gradient: Gradient(colors: [Color.init(hex: "FCF1EF"), Color.init(hex: "BE9ECB"),Color.init(hex:"5461A7")]), startPoint: .topTrailing, endPoint: .bottomLeading)
                           .edgesIgnoringSafeArea(.vertical)
                
                    VStack{
                        HStack{
                            Spacer()
                            VStack(spacing:0){
                                HStack(spacing:100){
                                Rectangle().fill(Color.AppPrimaryColor).frame(width:5,height: 17)
                                    Rectangle().fill(Color.AppPrimaryColor).frame(width:5,height: 17)
                            }.frame(width: 220)
                                Rectangle().fill(Color.AppPrimaryColor).frame(width: 220,height: 80).overlay(
                                    VStack{
                                        Text(" إعدادت الحساب")
                                    }.foregroundColor(.black).font(.system(size: 15), weight: .bold)
                                )
                                Spacer()
                            }
                            Spacer()
                        }
                    }
            HStack(spacing:30){
                VStack{
                    
                
                    Image(systemName: "play.rectangle.fill").resizable().frame(width: 32, height: 30).rotationEffect(Angle(degrees: 180)).foregroundColor(.Appliver).background(Color.white).cornerRadius(5).onTapGesture {
                        self.presentationMode.wrappedValue.dismiss()
                    }
    
    Spacer()
                }.padding([.top,.leading],50)
                Spacer()
                    
                    
                    VStack(spacing:15){
                        Spacer()
                        HStack{
                            TextField("", text: $phoneNumber).textFieldStyle(CTFStyleClearBackground(width: 250, cornerRadius: 20, height: 40, showError: $phoneNumberError))
                            Spacer()
                            HStack{
                                Spacer()
                                Text("الاسم")
                            }.frame(width:130)
                        }
                        
                        HStack{
                            TextField("", text: $phoneNumber).textFieldStyle(CTFStyleClearBackground(width: 250, cornerRadius: 20, height: 40, showError: $phoneNumberError))
                            Spacer()
                            HStack{
                                Spacer()
                                Text("رقم الهاتف")
                            }.frame(width:130)
                        }
                        
                        HStack{
                            
                            SecureField("", text: $phoneNumber).textFieldStyle(CTFStyleClearBackground(width: 250, cornerRadius: 20, height: 40, showError: $phoneNumberError))
                            
                            Spacer()
                            
                            HStack{
                                Spacer()
                                Text("كلمة المرور القديمة")
                            }.frame(width:130)
                            
                        }
                        HStack{
                            SecureField("", text: $phoneNumber).textFieldStyle(CTFStyleClearBackground(width: 250, cornerRadius: 20, height: 40, showError: $phoneNumberError))
                            Spacer()
                            HStack{
                                Spacer()
                                Text("كلمة المرور الجديدة")
                            }.frame(width:130)
                        }
                        HStack{
                            Text("حفظ التغييرات").frame(width: 255,height: 40).background(Color.AppPrimaryColor).cornerRadius(10).font(.system(size: 15)).foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
                            Spacer()
                        }
                        
                    }.frame(width:400).padding(.bottom,20)
                Spacer()
                Image("kayanSide").resizable().frame(width: 220,height: geo.size.height)
                }
                
            }
            
    }.environment(\.horizontalSizeClass, .compact)
    }
}
