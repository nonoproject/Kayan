//
//  SendVarificationCode.swift
//  Kayan
//
//  Created by mohammed aburukbah on 17/09/1442 AH.
//

import SwiftUI
import SwiftyJSON
struct SendVarificationCode: View {
    @State private var  showSandalLoadingIndicater=false
    @AppStorage("isLogin") var isLogin: Bool =  VarUserDefault.SysGlobalData.getGlobalBool(key: VarUserDefault.SysGlobalData.isLogin)
    //////
    @Binding  var  completeSignUpPassed:Bool
    @State var path=""
@Binding var displayItem:Int
var phoneNumber:String
    @State var confirmeType:String="user"
    @State var confirmeCode:String=""
    @State var confirmeCodeError=false
    //////////////
    @State private var ErrorMessage="الكود غير صحيح"
    @State private var IsError=false
    //////////////
    
    @State private var timeRemaining = 50
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
var body: some View {
    ZStack{
        Rectangle()
        .fill(Color.gray)
        .opacity(0.8)

        VStack {
            Spacer()
            
            
            HStack {
                VStack(spacing: 20) {
                    HStack{
                        Spacer()
                        Button(action: {
                                  self.displayItem = -1
                        }, label: {
                            Image("close_button").resizable().frame(width: 16, height: 16).padding(.horizontal,20)
                        })
                        
                    }.padding(.top,20)
                    Text("للتحقق من المصادقة وتسجيل الدخول أدخل الرمز المرسل إلى رقم جوالك")
                        .multilineTextAlignment(.center)
                        .frame(width: 290,height: 75, alignment: .center)
                        .foregroundColor(.brown)
                    Text(cantry_code+" "+phoneNumber).multilineTextAlignment(.center)
                    
                    if IsError{
                        Text(ErrorMessage)
                            .fontWeight(.bold)
                            .foregroundColor(.Appliver)
                            .frame(width: 318, height: 20, alignment: .center)
//                            .opacity(IsError ? 0.7 : 0)
                            
                }
                    HStack{
                        TextField("كود التفعيل", text: self.$confirmeCode)
                            .textFieldStyle(CTFStyleClearBackground(width:290, showError: self.$confirmeCodeError))
                            .keyboardType(.phonePad)
                            .onReceive(timer) { time in
                                if self.timeRemaining > 0 {
                                    self.timeRemaining -= 1
                                }
                            }
                        
                        
                    }.frame(width: 290)
                    if !showSandalLoadingIndicater{
                    Button(action: {
                        if timeRemaining == 0 {
                            timeRemaining  = 50
                            resandActivationCode()
                        }
                        else{
                        showSandalLoadingIndicater=true
                        if FormValidation(){
                            if confirmeType=="user"{
                                verifyUser()
                            }
                            else if confirmeType == "order"{
                                verifyOrder()
                            }
//                            self.displayItem = -1
                            
                        }
                        else{
                            showSandalLoadingIndicater=false
//                            self.displayItem = -1
                        }
                    }
                    }, label: {
                        Text(timeRemaining != 0 ? "تفعيل \(timeRemaining)" :"أعد إرسال كود التحقق")
                            .frame(width: 290, height: 50, alignment: .center)
                            .background(Color.brown)
                    }).cornerRadius(20)
                    .foregroundColor(Color.white)
                    }
                    else{
                        VStack(alignment:.center){
                            
                        sandalLoadingIndicater()
                        
                        }.frame(width: 290, height: 50, alignment: .center)
                    }
                    Spacer()
                }
            }
            .frame(minWidth: 300, idealWidth: 300, maxWidth: 388, minHeight: 350, idealHeight: 150,maxHeight: 380, alignment: .top)
            .background(RoundedRectangle(cornerRadius: 20).fill(Color.white.opacity(1)))
            .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.black, lineWidth: 0.5))
            Spacer()
        }
    }.ignoresSafeArea(.all, edges: .all)
  }
    func verifyOrder(){
        let ds=Connection().getUrl(word: "ConfirmOrder")+""
        print(ds)
        
        RestAPI().getData(endUrl: ds, parameters:   [:]) { result in
               let sectionR = JSON(result!)
                print(sectionR)
                showSandalLoadingIndicater=false
                if sectionR["responseCode"].int == 200{
                    completeSignUpPassed=true
                }
                else if sectionR["responseCode"].int == 406{ // user not active
                }
                else if sectionR["responseCode"].int == 404{//VerificationCode Not Correct
                    ErrorMessage = ValidationMessage().getMessage(word: "RowngCode")
                    IsError=true
                }
            } onError: { error in
                showSandalLoadingIndicater=false
                print(error)
            }

            

        
    }
    func verifyUser(){
        print(cantry_code)
        print(phoneNumber)
//        print(Connection().getUrl(word:"verifyUser")+"/966\(StringFunction().numberStrToEnglish(numberStr:self.phoneNumber))/\(StringFunction().numberStrToEnglish(numberStr:confirmeCode))")
        
            let ds=Connection().getUrl(word:"verifyUser")+"/966\(StringFunction().numberStrToEnglish(numberStr:self.phoneNumber))/\(StringFunction().numberStrToEnglish(numberStr:confirmeCode))"
        print(ds)
        RestAPI().getData(endUrl: ds, parameters: [:]) { result in
            
           let sectionR = JSON(result!)
            print(sectionR)
            showSandalLoadingIndicater=false
            if sectionR["responseCode"].int == 200{
               
//                print(sectionR["response"]["userId"].int)
                
                if path=="is_come_form_login_operation"{
                    
                    VarUserDefault.SysGlobalData.setGlobal(Key: VarUserDefault.SysGlobalData.mobileNo, Val:sectionR["response"]["phone"].stringValue)
            VarUserDefault.SysGlobalData.setGlobal(Key: VarUserDefault.SysGlobalData.fullName, Val:sectionR["response"]["name"].stringValue)
            
            VarUserDefault.SysGlobalData.setGlobal(Key: VarUserDefault.SysGlobalData.userId, Val:sectionR["response"]["id"].intValue)
            print( VarUserDefault.SysGlobalData.getGlobalInt(key: VarUserDefault.SysGlobalData.userId))
                    isLogin = true
                }
                else {
                    VarUserDefault.SysGlobalData.setGlobal(Key: VarUserDefault.SysGlobalData.fullName, Val:sectionR["response"]["name"].stringValue)
                    
                    VarUserDefault.SysGlobalData.setGlobal(Key: VarUserDefault.SysGlobalData.userVarifyId, Val:sectionR["response"]["id"].intValue)
                    completeSignUpPassed=true
                }
                
                
            }
            else if sectionR["responseCode"].int == 407{ // user not active
                ErrorMessage = sectionR["responseMasg"].stringValue
                IsError = true
                
            }
            else if sectionR["responseCode"].int == 404{//VerificationCode Not Correct
                IsError = true
            }
        } onError: { error in
            print(error)
            showSandalLoadingIndicater=false
        }

        

    }
    func FormValidation() -> Bool {
        self.confirmeCodeError = self.confirmeCode.isEmpty ? true : false
        
        IsError = confirmeCodeError
        return (!confirmeCodeError)
    }
    func resandActivationCode(){
//        IsError=false
        
        let prams = ["PhoneNo": "966"+phoneNumber]
//                let prams = ["PhoneNo": self.textBindingManager.text,"Password": password]

        //                let prams = ["PhoneNo": "+966122222223","Password": "123456"]
        RestAPI().getData(endUrl: Connection().getUrl(word: "GetRestPassword")+"\(StringFunction().numberStrToEnglish(numberStr: phoneNumber))", parameters: [:]) { result in
//            showSandalLoadingIndicater=false
           let sectionR = JSON(result!)
//            print(Connection().getUrl(word: "login"))
                  print(prams)
            print(sectionR)
         
            if sectionR["responseCode"].int == 200{
                
//                displayItem = 1
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
//                message = " هذا المستخدم غير موجود"
//                showsAlert=true
            }
            else if sectionR["responseCode"].int == 406{//user not found
//                message = "خطاء في بيانات الحساب"
//                showsAlert=true
            }
            else{
//                message = sectionR["responseMasg"].stringValue
//                showsAlert=true
            }
            
        } onError: { error in
            print(error)
//            showSandalLoadingIndicater=false
        }

        

    }
}
