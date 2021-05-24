//
//  SignIn.swift
//  Kayan
//
//  Created by Awad sandal on 30/03/2021.
//

import SwiftUI

import SwiftyJSON
struct SignIn: View {
    @State var password=""
    @State var passwordError:Bool=false
    @State var phoneNumber=""
    @State var phoneNumberError:Bool=false
    @State var isSignUp = false
    @State var isHomeView = false
    @State var isForgetPassword = false
    
//    @State private var ErrorMessage="123456"
//    @State private var IsError=false
//    @State private var  isForgetPassword=false
    @State  var  showsAlert:Bool=false
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
                                    Text("كيان")
                                    Text("قصص يغفو عليها الاطفال")
                                }.foregroundColor(.black).font(.system(size: 15), weight: .bold)
                            )
                            Spacer()
                        }
                        Spacer()
                    }
                }
            HStack{
//            VStack{
//                Image("fllower").resizable().frame(width: 189,height: 189)
//                Spacer()
//            }
                Spacer()
                VStack{
                    Spacer()
                    
                    VStack{
                        Spacer()
                        HStack{
                            TextField(" أدخل رقم الهاتف", text: $textBindingManager.text, onEditingChanged: onEditingChanged(_:), onCommit: onCommit)
                                .textFieldStyle(CTFStyleClearBackground(width: 250, cornerRadius: 20, height: 40, showError: $phoneNumberError))
                            Spacer()
                            Text("رقم الهاتف")
                        }
                        Spacer()
                        HStack{
                            SecureField("", text: $password).textFieldStyle(CTFStyleClearBackground(width: 250, cornerRadius: 20, height: 40, showError: $passwordError))
                            Spacer()
                            Text("كلمة المرور")
                            
                        }
                        HStack{
                            Button(action: {
                                isForgetPassword=true
                            }, label: {
                                Text("هل نسيت كلمة المرور؟").foregroundColor(.black)
                            })
                            
                            Spacer()
                        }
                        Spacer()
                        Text("هيا بنا").frame(width: 255,height: 40).background(Color.init(hex: "F1E6E0").opacity(0.97))
                            .cornerRadius(10).font(.system(size: 15)).foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))).onTapGesture {
                                if FormValidation(){
                                checkUserSignIn()
                                }
                            }
                        Spacer()
                        HStack{
                            Spacer()
                            Button(action: {
                                isSignUp=true
                            }, label: {
                                Text("إنشاء حساب جديد").foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
                            })
                            
                        }
                        Spacer()
                    }.frame(width:370,height: 250).padding(.bottom,30)
//                    Spacer()
                }
                Spacer()
                Image("kayanSide").resizable().frame(width: 220,height: geo.size.height)
            }
        }
    }.alert(isPresented: self.$showsAlert) {
        Alert(title: Text(message))
    }
        .navigationBarTitle(Text("Home"))
        .navigationBarHidden(true)
        }.environment(\.horizontalSizeClass, .compact)
        
    }
    func onCommit() {
        
           print("commit")
       }
       func onEditingChanged(_ changed: Bool) {
           print(changed)
       }
    func FormValidation() -> Bool {
        
        self.phoneNumberError = (self.textBindingManager.text.isEmpty || self.textBindingManager.text.count != 9) ? true : false
        self.passwordError = self.password.isEmpty ? true : false
        if phoneNumberError{
            message="خطاء في رقم الجوال"
            showsAlert=true
        }
        else if passwordError{
            message="كلمة المرور خالية"
            showsAlert=true
        }
        return (!self.phoneNumberError && !self.passwordError)
    }
    func checkUserSignIn(){
//        IsError=false
        
        let prams = ["PhoneNo": StringFunction().numberStrToEnglish(numberStr: self.textBindingManager.text),"Password": password]
//                let prams = ["PhoneNo": self.textBindingManager.text,"Password": password]

        //                let prams = ["PhoneNo": "+966122222223","Password": "123456"]
        RestAPI().postData(endUrl: Connection().getUrl(word: "login"), parameters: prams) { result in
//            showSandalLoadingIndicater=false
           let sectionR = JSON(result!)
            print(Connection().getUrl(word: "login"))
                  print(prams)
            print(sectionR)
         
            if sectionR["responseCode"].int == 200{
//
////                print(sectionR["response"]["userId"].int)
//                VarUserDefault.SysGlobalData.setGlobal(Key: VarUserDefault.SysGlobalData.mobileNo, Val:sectionR["response"]["customer"]["phone"].stringValue)
//        VarUserDefault.SysGlobalData.setGlobal(Key: VarUserDefault.SysGlobalData.fullName, Val:sectionR["response"]["customer"]["name"].stringValue)
//
//        VarUserDefault.SysGlobalData.setGlobal(Key: VarUserDefault.SysGlobalData.userId, Val:sectionR["response"]["customer"]["id"].intValue)
//        print( VarUserDefault.SysGlobalData.getGlobalInt(key: VarUserDefault.SysGlobalData.userId))
//
//               VarUserDefault.SysGlobalData.setGlobal(Key: VarUserDefault.SysGlobalData.isLogin, Val:true)
//
//                isHomeView=true
//
                isLogin = true
            
                
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
            
        } onError: { error in
            print(error)
//            showSandalLoadingIndicater=false
        }

        

    }
}

extension View {
    func phoneOnlyStackNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return AnyView(self.navigationViewStyle(StackNavigationViewStyle()))
        } else {
            return AnyView(self)
        }
    }
}