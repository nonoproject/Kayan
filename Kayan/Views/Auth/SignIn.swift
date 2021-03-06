//
//  SignIn.swift
//  Kayan
//
//  Created by Awad sandal on 30/03/2021.
//

import SwiftUI

import SwiftyJSON
struct SignIn: View {
    @State var password=default_password
    @State var passwordError:Bool=false
    @State var phoneNumber=default_phone_number
    @State var phoneNumberError:Bool=false
    @State var isSignUp = false
    @State var isHomeView = false
    @State var isForgetPassword = false
    @State private var  displayItem = -1
//    @State private var ErrorMessage="123456"
//    @State private var IsError=false
//    @State private var  isForgetPassword=false
    @State  var  showsAlert:Bool=false
    @State  var  view_loading:Bool=false
    @State  var  message:String=""
    @ObservedObject var textBindingManager = TextBindingManager(limit: 9)
    @AppStorage("isLogin") var isLogin: Bool = VarUserDefault.SysGlobalData.getGlobalBool(key: VarUserDefault.SysGlobalData.isLogin)
    var body: some View {
        NavigationView{
        GeometryReader{ geo in
            NavigationLink(destination: SignUp().navigationBarTitle(Text("Home"))
                            .navigationBarHidden(true), isActive: self.$isSignUp) {
            }.hidden()
            NavigationLink(destination: ForgetPassword().navigationBarTitle(Text("Home"))
                            .navigationBarHidden(true), isActive: self.$isForgetPassword) {
            }.hidden()
            NavigationLink(destination: Home().navigationBarTitle(Text("Home"))
                            .navigationBarHidden(true), isActive: self.$isHomeView) {
            }.hidden()
            ZStack{
                
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
                                    Text("????????")
                                    Text("?????? ???????? ?????????? ??????????????")
                                }.foregroundColor(.black).modifier(customFountCB())
                            )
                            Spacer()
                        }
                        Spacer()
                    }
                
                Spacer()
                VStack{
                Spacer()
            HStack{
                Spacer()
                VStack{
                    Spacer()
                    
                    VStack{
//                        Spacer()
                        HStack{
                            TextField("5xxxxxxxx", text: $textBindingManager.text, onEditingChanged: onEditingChanged(_:), onCommit: onCommit)
                                .textFieldStyle(CTFStyleClearBackground(width: 250, cornerRadius: 20, height: 40, showError: $phoneNumberError))
                                .modifier(customFountCB())
                                .foregroundColor(.Appliver)
                                .overlay(
                                    HStack{
                                        Text(cantry_code)
                                            .frame(width: 40, height: 30, alignment:.center)
                                            .padding(.horizontal,10)
                                        Spacer()
                                        Image(systemName: "candybarphone").frame(width: 40, height: 30, alignment: .center).padding(.horizontal,10)
                                    }
                                )
                                .keyboardType(.phonePad)
                            Spacer()
                            Text("?????? ????????????")
                        }.modifier(customFountCB())
                        Spacer()
                        HStack{
                            SecureField("", text: $password).textFieldStyle(CTFStyleClearBackground(width: 250, cornerRadius: 20, height: 40, showError: $passwordError)).modifier(customFountCB())
                                .foregroundColor(.Appliver)

                            Spacer()
                            Text("???????? ????????????")
                            
                        }.modifier(customFountCB())
                        HStack{
                            Button(action: {
                                isForgetPassword=true
                            }, label: {
                                Text("???? ???????? ???????? ??????????????").foregroundColor(.black).modifier(customFountCB())
                            })
                            
                            Spacer()
                        }
                        Spacer()
                        Text("?????? ??????").frame(width: 255,height: 40).background(Color.init(hex: "F1E6E0").opacity(0.97))
                            .cornerRadius(10).modifier(customFountCB()).foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))).onTapGesture {
                                if FormValidation(){
                                    view_loading = true
                                checkUserSignIn()
                                }
                            }
                        
                        Spacer()
                        HStack{
                            Spacer()
                            Button(action: {
                                isSignUp=true
                            }, label: {
                                Text("?????????? ???????? ????????").foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))).modifier(customFountCB())
                            })
                            
                        }
                        Spacer()
                    }.frame(width:370,height: 250).padding(.bottom,30)
                    Spacer()
                }
                Spacer()
                
            }.padding(.trailing,UIScreen.screenWidth*0.3)
                Spacer()
                }
//
                }
                HStack{
                
                    Spacer()
                    Image("kayanSide").resizable().frame(width: UIScreen.screenWidth*0.3,height: UIScreen.screenHeight)
                }
                
                
                
                if (displayItem != -1) {
                    SendVarificationCode(completeSignUpPassed: $isLogin, path:"is_come_form_login_operation", displayItem: $displayItem, phoneNumber: StringFunction().numberStrToEnglish(numberStr:textBindingManager.text))
             
                                        }
                             if view_loading{
                                 ZStack{
                                     Color.Appliver
                                         .opacity(0.66)
                             LoadinIndicator()
                                     
                                 }.edgesIgnoringSafeArea(.all)
                             
                         }
                
                
                
                
                
                
                
        }.edgesIgnoringSafeArea(.all)
    }.alert(isPresented: self.$showsAlert) {
        Alert(title: Text(message).font(.custom("Cairo-Black", size: 16)) )
    }
        .navigationBarTitle(Text("Home"))
        .navigationBarHidden(true)
        }.environment(\.horizontalSizeClass, .compact)
        .edgesIgnoringSafeArea(.all)
    }
    func onCommit() {
        
           print("commit")
       }
       func onEditingChanged(_ changed: Bool) {
           print(changed)
       }
    func FormValidation() -> Bool {
        
        self.phoneNumberError = (self.textBindingManager.text.isEmpty || self.textBindingManager.text.count != 9 || !self.textBindingManager.text.hasPrefix("5") ) ? true : false
        self.passwordError = self.password.isEmpty ? true : false
        if phoneNumberError{
            message="???????? ???? ?????? ????????????"
            showsAlert=true
        }
        else if passwordError{
            message="???????? ???????????? ??????????"
            showsAlert=true
        }
        return (!self.phoneNumberError && !self.passwordError)
    }
    func checkUserSignIn(){
//        IsError=false
        
        let prams = ["PhoneNo": "966"+StringFunction().numberStrToEnglish(numberStr: self.textBindingManager.text),"Password": password]
//                let prams = ["PhoneNo": self.textBindingManager.text,"Password": password]

        //                let prams = ["PhoneNo": "+966122222223","Password": "123456"]
        RestAPI().postData(endUrl: Connection().getUrl(word: "login"), parameters: prams) { result in
//            showSandalLoadingIndicater=false
           let sectionR = JSON(result!)
            print(Connection().getUrl(word: "login"))
                  print(prams)
            print(sectionR)
            view_loading=false
            if sectionR["responseCode"].int == 200{
                if sectionR["response"]["isVerfiy"].boolValue{
                
//
////                print(sectionR["response"]["userId"].int)
//                VarUserDefault.SysGlobalData.setGlobal(Key: VarUserDefault.SysGlobalData.mobileNo, Val:sectionR["response"]["customer"]["phone"].stringValue)
        VarUserDefault.SysGlobalData.setGlobal(Key: VarUserDefault.SysGlobalData.fullName, Val:sectionR["response"]["name"].stringValue)
                VarUserDefault.SysGlobalData.setGlobal(Key: VarUserDefault.SysGlobalData.userId, Val:sectionR["response"]["id"].intValue)
//        print( VarUserDefault.SysGlobalData.getGlobalInt(key: VarUserDefault.SysGlobalData.userId))
//
//               VarUserDefault.SysGlobalData.setGlobal(Key: VarUserDefault.SysGlobalData.isLogin, Val:true)
//
//                isHomeView=true
//
                isLogin = true
            
                }
                else{
                    
                    displayItem = 2
                }
            }
            else if sectionR["responseCode"].int == 405{ // user not active
//                displayItem=1
//                reSendVerification()
            }
            else if sectionR["responseCode"].int == 404{//user not found
                message = " ?????? ???????????????? ?????? ??????????"
                showsAlert=true
            }
            else if sectionR["responseCode"].int == 406{//user not found
                message = "???????? ???? ???????????? ????????????"
                showsAlert=true
            }
            else{
                message = sectionR["responseMasg"].stringValue
                showsAlert=true
            }
            
        } onError: { error in
            print(error)
            view_loading=false
//            showSandalLoadingIndicater=false
        }

        

    }
    
}

