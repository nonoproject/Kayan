//
//  ForgetPassword.swift
//  Kayan
//
//  Created by mohammed aburukbah on 13/09/1442 AH.
//

import SwiftUI
import SwiftyJSON
struct ForgetPassword: View {
//    @State var phoneNumber=""
    @State var phoneNumberError:Bool=false
    @State var isForgetPass = false
    @ObservedObject var textBindingManager = TextBindingManager(limit: 9)
    @State  var  showsAlert:Bool=false
    @State  var  message:String=""
    @State private var  displayItem = -1
    @State private var isForgetPasswordPass=false
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        NavigationView{
      GeometryReader{ geo in
          NavigationLink(destination: SignUp().navigationBarTitle(Text("Home"))
                          .navigationBarHidden(true), isActive: self.$isForgetPass) {
              
          }.hidden()
        NavigationLink(destination: ResetPassword().navigationBarTitle(Text("Home"))
                        .navigationBarHidden(true), isActive: self.$isForgetPasswordPass) {
            
        }.hidden()
//        NavigationLink(destination: ResetPassword().navigationBarTitle(Text("Home"))
//                        .navigationBarHidden(true), isActive: self.$isForgetPasswordPass) {
////
//        }.hidden()
////
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
                        .modifier(customFountCR())
                      Spacer()
                     
                      HStack{
                          TextField("5xxxxxxxx", text:  $textBindingManager.text).textFieldStyle(CTFStyleClearBackground(width: 250, cornerRadius: 20, height: 40, showError: $phoneNumberError))
                            .keyboardType(.numberPad)
                            .overlay(
                                HStack{
                                    Text(cantry_code)
                                        .frame(width: 40, height: 30, alignment:.center)
                                        .padding(.horizontal,10)
                                    Spacer()
                                    Image(systemName: "candybarphone").frame(width: 40, height: 30, alignment: .center).padding(.horizontal,10)
                                }
                            )
                          Spacer()
                          HStack{
                              
                              Text("رقم الهاتف")
                          }.frame(width:100)
                      }.frame(width:380)

                      
                      HStack{
                        Text("تحقق").frame(width: 255,height: 40).background(Color.AppPrimaryColor).cornerRadius(10).foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))).onTapGesture {
//                            isForgetPassword
                            if FormValidation(){
                            checkForgtPassword()
                            }
                        }
                          Spacer()
                      }.frame(width:380)

                    Spacer()
                  }.frame(width:250).padding(.bottom,20)
              Spacer()
            Image("kayanSide").resizable().renderingMode(.none).frame(width: 220)
              }
              
            if (displayItem != -1) {
            SendVarificationCode(completeSignUpPassed: $isForgetPasswordPass, path:"is_come_form_forget_password_operation", displayItem: $displayItem, phoneNumber: StringFunction().numberStrToEnglish(numberStr:self.textBindingManager.text))
                       
               }
            
          }
          
  }.navigationBarTitle(Text("Home")).navigationBarHidden(true)
            //.environment(\.horizontalSizeClass, .compact)
//      .fullScreenCover(isPresented: $isForgetPasswordPass, content: {
//        ResetPassword().environment(\.horizontalSizeClass, .compact).navigationBarTitle(Text("Home"))
//                                .navigationBarHidden(true) .onTapGesture {
//                                    self.hideKeyboard()
//                        //
//                                  }
//
//      })
        }
                                        
    .environment(\.horizontalSizeClass, .compact)
      .alert(isPresented: self.$showsAlert) {
          Alert(title: Text(message))
      }
        
  }
    func FormValidation() -> Bool {
        
        self.phoneNumberError = (self.textBindingManager.text.isEmpty || self.textBindingManager.text.count != 9) ? true : false
        
        if phoneNumberError{
            message="خطاء في رقم الجوال"
            showsAlert=true
        }
       
        return (!self.phoneNumberError)
    }
    func checkForgtPassword(){
//        IsError=false
        
        let prams = ["PhoneNo": "966"+StringFunction().numberStrToEnglish(numberStr: self.textBindingManager.text)]
//                let prams = ["PhoneNo": self.textBindingManager.text,"Password": password]

        //                let prams = ["PhoneNo": "+966122222223","Password": "123456"]
        RestAPI().getData(endUrl: Connection().getUrl(word: "GetRestPassword")+"\(StringFunction().numberStrToEnglish(numberStr: self.textBindingManager.text))", parameters: [:]) { result in
//            showSandalLoadingIndicater=false
           let sectionR = JSON(result!)
//            print(Connection().getUrl(word: "login"))
                  print(prams)
            print(sectionR)
         
            if sectionR["responseCode"].int == 200{
                
                displayItem = 1
////                print(sectionR["response"]["userId"].int)
//                VarUserDefault.SysGlobalData.setGlobal(Key: VarUserDefault.SysGlobalData.mobileNo, Val:sectionR["response"]["customer"]["phone"].stringValue)
//        VarUserDefault.SysGlobalData.setGlobal(Key: VarUserDefault.SysGlobalData.fullName, Val:sectionR["response"]["username"].stringValue)
////
//                VarUserDefault.SysGlobalData.setGlobal(Key: VarUserDefault.SysGlobalData.userId, Val:sectionR["response"]["userId"].intValue)
//        print( VarUserDefault.SysGlobalData.getGlobalInt(key: VarUserDefault.SysGlobalData.userId))
//
//               VarUserDefault.SysGlobalData.setGlobal(Key: VarUserDefault.SysGlobalData.isLogin, Val:true)
//
//                isHomeView=true
//
//                isLogin = true
            
                
            }
            else if sectionR["responseCode"].int == 405{ // user not active
//                displayItem=1
//                reSendVerification()
            }
            else if sectionR["responseCode"].int == 404{//user not found
                message = " هذا المستخدم غير موجود"
                showsAlert=true
            }
            else if sectionR["responseCode"].int == 406{//user not found
                message = "خطاء في بيانات الحساب"
                showsAlert=true
            }
            else{
                message = sectionR["responseMasg"].stringValue
                showsAlert=true
            }
            
        } onError: { error in
            print(error)
//            showSandalLoadingIndicater=false
        }

        

    }
}
