//
//  Setting.swift
//  Kayan
//
//  Created by Sandal on 20/10/1442 AH.
//

import SwiftUI
import SwiftyJSON
struct Setting: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var acccount_or_setting:Bool=false
    var body: some View {
        NavigationView{
        GeometryReader{ geo in
//            NavigationLink(destination: SignUp().navigationBarTitle(Text("Home"))
//                            .navigationBarHidden(true), isActive: self.$isSignUp) {
//
//            }.hidden()
//            NavigationLink(destination: ForgetPassword().navigationBarTitle(Text("Home"))
//                            .navigationBarHidden(true), isActive: self.$isForgetPassword) {
//
//            }.hidden()
//            NavigationLink(destination: Home().navigationBarTitle(Text("Home"))
//                            .navigationBarHidden(true), isActive: self.$isHomeView) {
//
//            }.hidden()
            ZStack{
                
                LinearGradient(gradient: Gradient(colors: [Color.init(hex: "FCF1EF"), Color.init(hex: "BE9ECB"),Color.init(hex:"5461A7")]), startPoint: .topTrailing, endPoint: .bottomLeading)
                       .edgesIgnoringSafeArea(.vertical)

            HStack{
            VStack{
//                Image("fllower").resizable().frame(width: 189,height: 189)
//                Spacer()
//            }
                
                Image(systemName: "play.fill").resizable().padding(2).frame(width: 22, height: 22).background(Color.Appliver).foregroundColor(.white).cornerRadius(5).rotationEffect(Angle(degrees: 180)).onTapGesture {
                                                            self.presentationMode.wrappedValue.dismiss()
                }.padding(.leading,5).padding(.top,30)
                Spacer()
            }
                Spacer()
                VStack{
                    Spacer()
                    Image("profile").resizable().frame(width: 160, height: 160).padding(.trailing,20)
                    Text("مرحبا \(VarUserDefault.SysGlobalData.getGlobal(key: VarUserDefault.SysGlobalData.fullName))").foregroundColor(.black).font(.system(size: 22), weight: .heavy)
                    Text("نتمنى لك قراءة ممتعة ونوما هنيئا مع كيان").foregroundColor(.black).font(.system(size: 20), weight: .bold)
                    Spacer()
                                        Spacer()
                    Button(action: {
                        acccount_or_setting = true
                    }) {
                        HStack{
                            Text("إعدادت الحساب").foregroundColor(.Appliver).font(.system(size: 20), weight: .bold)
                            Image(systemName: "gear")
                        }
                    }
                    .frame(width: 255,height: 40).background(Color.init(hex: "F1E6E0").opacity(0.97))
                        .cornerRadius(10)
                    Spacer()
                }
                Spacer()
                
                Image("kayanSide").resizable().frame(width: 220,height: geo.size.height)
            }
        }.edgesIgnoringSafeArea(.all)
    }//.alert(isPresented: self.$showsAlert) {
//        Alert(title: Text(message))
//    }
        .fullScreenCover(isPresented: $acccount_or_setting, content: {
            AccountSetting()
        })
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
//    func FormValidation() -> Bool {
//
//        self.phoneNumberError = (self.textBindingManager.text.isEmpty || self.textBindingManager.text.count != 9) ? true : false
//        self.passwordError = self.password.isEmpty ? true : false
//        if phoneNumberError{
//            message="خطاء في رقم الجوال"
//            showsAlert=true
//        }
//        else if passwordError{
//            message="كلمة المرور خالية"
//            showsAlert=true
//        }
//        return (!self.phoneNumberError && !self.passwordError)
//    }
//    func checkUserSignIn(){
////        IsError=false
//
//        let prams = ["PhoneNo": StringFunction().numberStrToEnglish(numberStr: self.textBindingManager.text),"Password": password]
////                let prams = ["PhoneNo": self.textBindingManager.text,"Password": password]
//
//        //                let prams = ["PhoneNo": "+966122222223","Password": "123456"]
//        RestAPI().postData(endUrl: Connection().getUrl(word: "login"), parameters: prams) { result in
////            showSandalLoadingIndicater=false
//           let sectionR = JSON(result!)
//            print(Connection().getUrl(word: "login"))
//                  print(prams)
//            print(sectionR)
//
//            if sectionR["responseCode"].int == 200{
////
//////                print(sectionR["response"]["userId"].int)
////                VarUserDefault.SysGlobalData.setGlobal(Key: VarUserDefault.SysGlobalData.mobileNo, Val:sectionR["response"]["customer"]["phone"].stringValue)
////        VarUserDefault.SysGlobalData.setGlobal(Key: VarUserDefault.SysGlobalData.fullName, Val:sectionR["response"]["customer"]["name"].stringValue)
////
//                VarUserDefault.SysGlobalData.setGlobal(Key: VarUserDefault.SysGlobalData.userId, Val:sectionR["response"]["id"].intValue)
////        print( VarUserDefault.SysGlobalData.getGlobalInt(key: VarUserDefault.SysGlobalData.userId))
////
////               VarUserDefault.SysGlobalData.setGlobal(Key: VarUserDefault.SysGlobalData.isLogin, Val:true)
////
////                isHomeView=true
////
//                isLogin = true
//
//
//            }
//            else if sectionR["responseCode"].int == 405{ // user not active
////                displayItem=1
////                reSendVerification()
//            }
//            else if sectionR["responseCode"].int == 404{//user not found
//                message = " هذا المستخدم غير موجود"
//                showsAlert=true
//            }
//            else if sectionR["responseCode"].int == 406{//user not found
//                message = "خطاء في بيانات الحساب"
//                showsAlert=true
//            }
//            else{
//                message = sectionR["responseMasg"].stringValue
//                showsAlert=true
//            }
//
//        } onError: { error in
//            print(error)
////            showSandalLoadingIndicater=false
//        }
//
//
//
//    }
}
