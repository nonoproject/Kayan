//
//  ResetPassword.swift
//  Kayan
//
//  Created by Sandal on 21/10/1442 AH.
//

import SwiftUI
import SwiftyJSON
struct ResetPassword: View {
    @State var password_BindingManager_Error:Bool=false
    @State var repassword_BindingManager_Error:Bool=false
//    @State var isForgetPass = false
    @ObservedObject var password_BindingManager = TextBindingManager(limit: 9)
    @ObservedObject var repassword_textBindingManager = TextBindingManager(limit: 9)
    @State  var  showsAlert:Bool=false
    @State  var  isLogin:Bool=false
    @State  var  message:String=""
//    @State private var  displayItem = -1
//    @State private var isForgetPasswordPass=false
//
//    @AppStorage("isLogin") var : Bool = VarUserDefault.SysGlobalData.getGlobalBool(key: VarUserDefault.SysGlobalData.isLogin)
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
//
        NavigationView{
      GeometryReader{ geo in
        NavigationLink(destination: SignIn().environment(\.horizontalSizeClass, .compact).navigationBarTitle(Text("Home"))
                        .navigationBarHidden(true), isActive: self.$isLogin) {
        }.hidden()
        VStack{
          ZStack(alignment: .bottom){
                  
                  LinearGradient(gradient: Gradient(colors: [Color.init(hex: "FCF1EF"), Color.init(hex: "BE9ECB"),Color.init(hex:"5461A7")]), startPoint: .topTrailing, endPoint: .bottomLeading)
                         .edgesIgnoringSafeArea(.vertical)
              
          HStack(spacing:30){
              VStack{
                  
              
                Image(systemName: "play.rectangle.fill").resizable().frame(width: 32, height: 30).foregroundColor(.brown).background(Color.white).cornerRadius(5).onTapGesture {
//                    self.presentationMode.wrappedValue.dismiss()
                }
                Spacer()
              }.padding([.top,.leading],50)
              Spacer()
                  
                  
                  VStack(spacing:15){
                    
                    Text("إعادة كلمة السر").padding(.top,55)
                        .font(.headline)
                      Spacer()
                     
                      HStack{
                        SecureField("xxxxxxxxx", text:  $password_BindingManager.text).textFieldStyle(CTFStyleClearBackground(width: 250, cornerRadius: 20, height: 40, showError: $password_BindingManager_Error))
                            .keyboardType(.default)
                          Spacer()
                          HStack{
                              
                              Text("كلمة المرور")
                          }.frame(width:100)
                      }.frame(width:380)

                    
                     HStack{
                        SecureField("xxxxxxxxx", text:  $repassword_textBindingManager.text).textFieldStyle(CTFStyleClearBackground(width: 250, cornerRadius: 20, height: 40, showError: $repassword_BindingManager_Error))
                           .keyboardType(.default)
                         Spacer()
                         HStack{
                             
                             Text(" إعادة كلمة المرور")
                         }.frame(width:100)
                     }.frame(width:380)
                    
                      HStack{
                        Text("تحقق").frame(width: 255,height: 40).background(Color.AppPrimaryColor).cornerRadius(10).font(.system(size: 15)).foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))).onTapGesture {
//                            isForgetPassword
                            if !FormValidation(){
                            checkForgtPassword()
                            }
                            else{
                                showsAlert=true
                            }
                        }
                          Spacer()
                      }.frame(width:380)

                    Spacer()
                  }.frame(width:250).padding(.bottom,20)
              Spacer()
            Image("kayanSide").resizable().renderingMode(.none).frame(width: 220)
              }
              
          }.alert(isPresented: self.$showsAlert) {
            Alert(title: Text(message))
          }
//        }.fullScreenCover(isPresented: $isLogin) {
//            Home().environment(\.horizontalSizeClass, .compact)
//          }
        }
      }.navigationBarTitle(Text("Home"))
      .navigationBarHidden(true)
//        }//.environment(\.horizontalSizeClass, .compact)
        }.environment(\.horizontalSizeClass, .compact)
  }//.environment(\.horizontalSizeClass, .compact)
      
//
  
    func FormValidation() -> Bool {
        password_BindingManager_Error = false
                if self.repassword_textBindingManager.text.count == 0{
                    message = ValidationMessage().getMessage(word: "fill_all_filed")
                    password_BindingManager_Error = true
                }
                else if (self.password_BindingManager.text.count < 4){
                    message = "كلمة المرور قصيرة جدا"
                    password_BindingManager_Error = true
                }
                else if (self.password_BindingManager.text != self.repassword_textBindingManager.text){
                    message = ValidationMessage().getMessage(word: "Passwordـnotـmatch")
                    password_BindingManager_Error = true
                }
                
        
        
        return (self.password_BindingManager_Error)
    }
    func checkForgtPassword(){
//        IsError=false
        
        let prams = ["UserID":VarUserDefault.SysGlobalData.getGlobalInt(key: VarUserDefault.SysGlobalData.userVarifyId) ,"NewPassword": self.password_BindingManager.text] as [String : Any]
//                let prams = ["PhoneNo": self.textBindingManager.text,"Password": password]

        //                let prams = ["PhoneNo": "+966122222223","Password": "123456"]
        RestAPI().postData(endUrl: Connection().getUrl(word: "RestChangePassword"), parameters: prams) { result in
//            showSandalLoadingIndicater=false
           let sectionR = JSON(result!)
//            print(Connection().getUrl(word: "login"))
                  print(prams)
            print(sectionR)
         
            if sectionR["responseCode"].int == 200{
                
//                displayItem = -1
////                print(sectionR["response"]["userId"].int)
                if sectionR["response"]["isActive"].boolValue {
                    VarUserDefault.SysGlobalData.setGlobal(Key: VarUserDefault.SysGlobalData.mobileNo, Val:sectionR["response"]["phoneNo"].stringValue)
                    
            VarUserDefault.SysGlobalData.setGlobal(Key: VarUserDefault.SysGlobalData.fullName, Val:sectionR["response"]["name"].stringValue)
                    
                    VarUserDefault.SysGlobalData.setGlobal(Key: VarUserDefault.SysGlobalData.userId, Val:sectionR["response"]["id"].intValue)
                    
                    
                                   VarUserDefault.SysGlobalData.setGlobal(Key: VarUserDefault.SysGlobalData.isLogin, Val:true)
                    isLogin = true
                }
                else{
                    message = ValidationMessage().getMessage(word: "UserNotActive")
                    showsAlert=true
                }
                
                
                
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
