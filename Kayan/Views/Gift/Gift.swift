//
//  Gift.swift
//  Kayan
//
//  Created by Awad sandal on 05/04/2021.
//

import SwiftUI

struct Gift: View {
    @State var phoneNumber=""
    @State var phoneNumberError:Bool=false
    
    @State var name:String=""
    @State var checked:Bool=false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        
      GeometryReader{ geo in
        ZStack{
            VStack{
          HStack{
            VStack{
                
                Image(systemName: "play.fill").resizable().padding(5).frame(width: 32, height: 32).background(Color.Appliver).foregroundColor(.white).cornerRadius(5).rotationEffect(Angle(degrees: 180)).onTapGesture {
                                                            self.presentationMode.wrappedValue.dismiss()
                }.padding(.leading,5)
                Spacer()
            }.padding(20)
            Spacer()
              VStack{
                  VStack(spacing:0){
                      HStack(spacing:90){
                      
                      Rectangle().fill(Color.AppPrimaryColor).frame(width:3,height: 12)
                      
                      Rectangle().fill(Color.AppPrimaryColor).frame(width:2,height: 12)
                          
                  }.frame(width: 220)
                      Rectangle().fill(Color.AppPrimaryColor).frame(width: 220,height: 70).overlay(
                          VStack{
                              Text("هديتي لك")
                          }.foregroundColor(.brown).font(.system(size: 17), weight: .heavy)
                      ).cornerRadius(10)
                      Spacer()
                  }
                  Spacer()
                  
                  Spacer()
              }
            Spacer()
          }
                VStack{
                    ZStack{
                        LinearGradient(gradient: Gradient(colors: [Color.init(hex:"F167BF"), Color.init(hex: "3068BD")]), startPoint: .topTrailing, endPoint: .bottomLeading)
                               .edgesIgnoringSafeArea(.vertical)
                               
                        VStack{
                            HStack{
                                VStack{
                                    HStack{
                                        Spacer()
                                        Text("طريقة الدفع").frame(width: 120)
                                        Spacer()
                                    }.padding(.top)
                                    
                                    VStack(spacing:20){
                                        Spacer()
                                            
                                        HStack{
                                            Spacer()
                                           
                                                            Button(action: {
                                                                withAnimation{
                                                                checked = true
                                                            }
                                                            }, label: {
                                                                ZStack{
                                                                    Circle()
                                                                        .frame(width: 24, height: 24)
                                                                        .foregroundColor(checked ?  .AppPrimaryColor : .gray )


                                                                    Circle()
                                                                        .frame(width: 20, height: 20)
                                                                        .foregroundColor(.white)

                                                                    Circle().frame(width: 16, height: 16).foregroundColor(checked ?  .AppPrimaryColor : Color.white.opacity(0.5))

                                                                }
                                                            })
                                            Spacer()
                                            Text("فيزا كــارد").frame(width: 120,alignment: .trailing)
                                            Image("visa").resizable().frame(width: 35, height: 35)

                                        }
                                        
                                        HStack{
                                            Spacer()
                                            Button(action: {
                                                withAnimation{
                                                checked = false
                                                }
                                            }, label: {
                                                ZStack{
                                                    Circle()
                                                        .frame(width: 24, height: 24)
                                                        .foregroundColor(!checked ?  .AppPrimaryColor : .gray)
                                                    
                                                    
                                                    Circle()
                                                        .frame(width: 20, height: 20)
                                                        .foregroundColor(.white)
                                                        
                                                    Circle().frame(width: 16, height: 16).foregroundColor(!checked ?  .AppPrimaryColor : Color.white.opacity(0.5))

                                                }
                                            })
                                            Spacer()
                                            Text("باي بال").frame(width: 120,alignment: .trailing)
                                            
                                            Image("paypal").resizable().frame(width: 35, height: 35)
                                            
                                        }
                                        Spacer()
                                    }
                                
                                }
                                
                                
                                Divider().foregroundColor(.black).padding(.horizontal,20)
                                
                                
                                VStack{
                                    
                                    HStack{
                                        TextField("sad", text: $phoneNumber).textFieldStyle(CTFStyleClearBackground(width: 200, cornerRadius: 20, height: 40, showError: $phoneNumberError))
                                        
                                        Text("الإسم").frame(width: 90)
                                        
                                    }
                                HStack{
                                    TextField("+249922121720", text: $phoneNumber).textFieldStyle(CTFStyleClearBackground(width: 200, cornerRadius: 20, height: 40, showError: $phoneNumberError))
                                    
                                    Text("رقم الهاتف").frame(width: 90)
                                }
                                    HStack{
                                        Spacer()
                                        HStack{
                                            Spacer()
                                            Text("32").frame(width: 50,height: 30).background(Color.AppPrimaryColor).padding(5).cornerRadius(8)
                                        }.frame(width:200)
                                        Text("سعر القصة").frame(width: 90)
                                    }
                                }
                                

                            }
                            HStack{
                                Spacer()
                                
                                            Button(action: {
                                                
                                            }, label: {
                                                Text("إهداء الان").frame(width: 255,height: 40).background(Color.AppPrimaryColor).cornerRadius(10).font(.system(size: 15)).foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
                                            })
                             
                                Spacer()
                            }.padding(.bottom,30)
                        }
                    }
                }.frame(width: 600).cornerRadius(20).padding(.bottom,20)
                
            }
        }
    }
}
}

struct Gift_Previews: PreviewProvider {
    static var previews: some View {
        Gift()
    }
}
