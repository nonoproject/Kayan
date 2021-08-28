//
//  AccountSetting.swift
//  Kayan
//
//  Created by Awad sandal on 06/04/2021.
//

import SwiftUI
import SwiftyJSON
struct AccountSetting: View {
    @State var phoneNumber=""
    @State var phoneNumberError:Bool=false
    @State var user_name=""
    @State var user_nameError:Bool=false
    @State var password=""
    @State var rePasswordError:Bool=false
    @State var rePassword=""
    @State var passwordError:Bool=false
    @State var isSignUp = false
    @State  var  showsAlert:Bool=false
    @State  var  view_loading:Bool=false
    @State  var  message:String=""
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
                                Rectangle().fill(Color.AppPrimaryColor).frame(width:5,height: 12)
                                    Rectangle().fill(Color.AppPrimaryColor).frame(width:5,height: 12)
                                }.frame(width: 220).cornerRadius(20)
                                Rectangle().fill(Color.AppPrimaryColor).frame(width: 190,height: 70).overlay(
                                    VStack{
                                        Text(" إعدادت الحساب")
                                    }.foregroundColor(.black).font(.system(size: 15), weight: .bold)
                                ).cornerRadius(10)
                                Spacer()
                            }
                            Spacer()
                        }
                    }
            HStack(spacing:10){
                VStack{
                    
                
                    Image(systemName: "play.rectangle.fill").resizable().frame(width: 32, height: 30).rotationEffect(Angle(degrees: 180)).foregroundColor(.Appliver).background(Color.white).cornerRadius(5).onTapGesture {
                        self.presentationMode.wrappedValue.dismiss()
                    }
    
    Spacer()
                }.padding([.top,.leading],50)
                Spacer()
                Spacer()
                    
                    VStack(spacing:8){
                        Spacer()
                        HStack{
                            TextField("", text: $user_name).textFieldStyle(CTFStyleClearBackground(width: 350, cornerRadius: 20, height: 50,foregroundColor:.AppPrimaryColor, showError: $user_nameError)).disabled(true)
                            Spacer()
                            HStack{
                                Spacer()
                                Text("الاسم")
                            }.frame(width:130)
                        
                        }
                        
                        HStack{
                            TextField("", text: $phoneNumber).textFieldStyle(CTFStyleClearBackground(width: 350, cornerRadius: 20, height: 50,foregroundColor:.AppPrimaryColor, showError: $phoneNumberError)).disabled(true)
                            Spacer()
                            HStack{
                                Spacer()
                                Text("رقم الهاتف")
                            }.frame(width:130)
                            
                        }
                        
                        HStack{
                            
                            SecureField("", text: $password).textFieldStyle(CTFStyleClearBackground(width: 350, cornerRadius: 20, height: 50, showError: $passwordError))
                            
                            Spacer()
                            
                            HStack{
                                Spacer()
                                Text("كلمة المرور القديمة")
                            }.frame(width:130)
                            
                        }
                        HStack{
                            SecureField("", text: $rePassword).textFieldStyle(CTFStyleClearBackground(width: 350, cornerRadius: 20, height: 50, showError: $rePasswordError))
                            Spacer()
                            HStack{
                                Spacer()
                                Text("كلمة المرور الجديدة")
                            }.frame(width:130)
                        }
                        HStack{
                            Text("حفظ التغييرات").frame(width: 255,height: 40).background(Color.AppPrimaryColor).cornerRadius(10).font(.system(size: 15)).foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))).onTapGesture {
                                if passFIledValidation(){
                                    updateProfileChangePassword()
                                }
                            }
                            Spacer()
                        }
                        
                    }.frame(width:400).padding(.bottom,20).padding(.trailing,50)
                Spacer()
                Image("kayanSide").resizable().frame(width: 220,height: geo.size.height)
                }
                
            }.onAppear{
                getProfile()
                user_name = VarUserDefault.SysGlobalData.getGlobal(key: VarUserDefault.SysGlobalData.fullName)
                
            }
            .alert(isPresented: self.$showsAlert) {
                Alert(title: Text(message).font(.custom("Cairo-Black", size: 16)) )
            }
            
        }.environment(\.horizontalSizeClass, .compact).onTapGesture {
            hideKeyboard()
        }
    }
    func passFIledValidation()->Bool{
        passwordError = password.count < 4
        rePasswordError = rePassword.count < 4
        
        if rePasswordError{
            message = " الرجاء كتابة كلمة السر الجديدة "
//            showsAlert=true
            
        }
        if passwordError{
            message = " الرجاء كتابة كلمة السر القديمة "
//            showsAlert=true
            
        }
        showsAlert = passwordError || rePasswordError
        return !showsAlert
    }
    func getProfile(){
        
            print( Connection().getUrl(word: "GetCustomerInfo"))
            //        RestAPI().getData(endUrl: Connection().getUrl(word: "GetStories")+"\(id)", parameters: [:])
            RestAPI().getData(endUrl: Connection().getUrl(word: "GetCustomerInfo"), parameters: [:]){ result in
                
                let sectionR = JSON(result!)
                print(sectionR)
                if sectionR["responseCode"].int == 200{
                    phoneNumber = "0"+sectionR["response"]["phoneNo"].stringValue
                }
                
            } onError: { error in
                print(error)
            }
        }
    func updateProfileChangePassword(){
        let prams = ["UserID":VarUserDefault.SysGlobalData.getGlobalInt(key: VarUserDefault.SysGlobalData.userId),"NewPassword":rePassword,"CurrentPassword":password] as [String : Any]

            print( Connection().getUrl(word: "ChangePassword"))
        print( prams)
            
            RestAPI().postData(endUrl: Connection().getUrl(word: "ChangePassword"), parameters:prams){ result in
                
                let sectionR = JSON(result!)
                print(sectionR)
                if sectionR["responseCode"].int == 200{
                    message = "تم التعديل بنجاح"
                    showsAlert=true
//                    phoneNumber = "0"+sectionR["response"]["phoneNo"].stringValue
                }
                else{
                    message = sectionR["responseMasg"].stringValue
                    showsAlert=true
                }
                
            } onError: { error in
                print(error)
            }
        }
}
