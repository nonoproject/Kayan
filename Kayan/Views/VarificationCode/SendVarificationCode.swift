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
    @State private var ErrorMessage="123456"
    @State private var IsError=false
    //////////////
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
                            Image("Vectorclose").resizable().frame(width: 16, height: 16).padding(.horizontal,20)
                        })
                        
                    }.padding(.top,20)
                    Text("للتحقق من المصادقة وتسجيل الدخول أدخل الرمز المرسل الي رقم جوالك")
                        .multilineTextAlignment(.center)
                        .frame(width: 290,height: 75, alignment: .center)
                        .foregroundColor(.brown)
                    Text(phoneNumber).multilineTextAlignment(.center)
                    
                    if IsError{
                        Text(ErrorMessage)
                            .fontWeight(.medium)
                            .foregroundColor(.AppPrimaryColor)
                            .frame(width: 318, height: 20, alignment: .center)
                            .opacity(IsError ? 0.7 : 0)
                            
                }
                    HStack{
                        TextField("كود التفعيل", text: self.$confirmeCode)
                            .textFieldStyle(CTFStyleClearBackground(width:290, showError: self.$confirmeCodeError))
                            .keyboardType(.phonePad)
                            
                        
                    }.frame(width: 290)
                    if !showSandalLoadingIndicater{
                    Button(action: {
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
                    }, label: {
                        Text("تفعيل")
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
    }
  }
    func verifyOrder(){
        var ds=Connection().getUrl(word: "ConfirmOrder")+""
        print(ds)
        
        RestAPI().getData(endUrl: ds, parameters:   [:]) { result in
               let sectionR = JSON(result!)
                print(sectionR)
                showSandalLoadingIndicater=false
                if sectionR["responseCode"].int == 200{
                    completeSignUpPassed=true
                }
                else if sectionR["responseCode"].int == 406{ // user not active
                }
                else if sectionR["responseCode"].int == 404{//VerificationCode Not Correct
                    ErrorMessage="كود التفعيل غير ضحيح"
                    IsError=true
                }
            } onError: { error in
                showSandalLoadingIndicater=false
                print(error)
            }

            

        
    }
    func verifyUser(){
        print(Connection().getUrl(word:"verifyUser")+"/\(StringFunction().numberStrToEnglish(numberStr:self.phoneNumber))/\(StringFunction().numberStrToEnglish(numberStr:confirmeCode))")
        
            let ds=Connection().getUrl(word:"verifyUser")+"/\(StringFunction().numberStrToEnglish(numberStr:self.phoneNumber))/\(StringFunction().numberStrToEnglish(numberStr:confirmeCode))"
        RestAPI().getData(endUrl: ds, parameters: [:]) { result in
            
           let sectionR = JSON(result!)
            print(sectionR)
            showSandalLoadingIndicater=false
            if sectionR["responseCode"].int == 200{
                
                VarUserDefault.SysGlobalData.setGlobal(Key: VarUserDefault.SysGlobalData.mobileNo, Val:sectionR["response"]["phone"].stringValue)
        VarUserDefault.SysGlobalData.setGlobal(Key: VarUserDefault.SysGlobalData.fullName, Val:sectionR["response"]["name"].stringValue)
        
        VarUserDefault.SysGlobalData.setGlobal(Key: VarUserDefault.SysGlobalData.userId, Val:sectionR["response"]["id"].intValue)
        print( VarUserDefault.SysGlobalData.getGlobalInt(key: VarUserDefault.SysGlobalData.userId))
//                print(sectionR["response"]["userId"].int)
                
                if path=="is_come_form_login_operation"{
                    isLogin = true
                }
                else{
                    
                }
                
                
            }
            else if sectionR["responseCode"].int == 406{ // user not active
                
            }
            else if sectionR["responseCode"].int == 404{//VerificationCode Not Correct
                                
            }
        } onError: { error in
            print(error)
            showSandalLoadingIndicater=false
        }

        

    }
    func FormValidation() -> Bool {
        self.confirmeCodeError = self.confirmeCode.isEmpty ? true : false
        
        return (!confirmeCodeError)
    }
}
