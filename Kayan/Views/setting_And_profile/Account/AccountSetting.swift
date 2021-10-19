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
//            NavigationLink(destination: SignUp().navigationBarTitle(Text("Home"))
//                            .navigationBarHidden(true), isActive: self.$isSignUp) {
//
//            }.hidden()
            
//            VStack{
//                Image("fllower").resizable().frame(width: 189,height: 189)
//                Spacer()
//            }
            ZStack(){
                    
                    LinearGradient(gradient: Gradient(colors: [Color.init(hex: "FCF1EF"), Color.init(hex: "BE9ECB"),Color.init(hex:"5461A7")]), startPoint: .topTrailing, endPoint: .bottomLeading)
                           .edgesIgnoringSafeArea(.vertical)
                        HStack{
                            Spacer()
                            VStack(spacing:0){
                                HStack(spacing:UIScreen.screenWidth/9.14){
                                    Rectangle().fill(Color.AppPrimaryColor).frame(width:5,height: 12)
                                    Rectangle().fill(Color.AppPrimaryColor).frame(width:5,height: 12)
                                }.frame(width: UIScreen.screenWidth/3.245).cornerRadius(20)
                                Rectangle().fill(Color.AppPrimaryColor).frame(width: UIScreen.screenWidth/6.16,height: UIScreen.screenHeight/6.914).overlay(
                                    VStack{
                                        Text(" إعدادت الحساب")
                                    }.foregroundColor(.black)
                                    //.font(.system(size: 15), weight: .bold)
                                    .font(.custom("Cairo-Black", size: UIScreen.screenHeight/27))
                                ).cornerRadius(10)
                                Spacer()
                            }
                            Spacer()
                            Spacer()
                        }
                        .onAppear{
                            print(UIScreen.screenWidth)
                            print(UIScreen.screenHeight)
                        }
                    
            HStack(spacing:10){
                VStack{


                    Image(systemName: "play.rectangle.fill").resizable().frame(width: 32, height: 30).rotationEffect(Angle(degrees: 180)).foregroundColor(.Appliver).background(Color.white).cornerRadius(5).onTapGesture {
                        self.presentationMode.wrappedValue.dismiss()
                    }

    Spacer()
                }.padding([.top,.leading],25)
////                Spacer()
////                Spacer()
//
                    VStack(spacing:5){
                        Spacer()
                        Spacer()
                        Spacer()
                        HStack{
                            TextField("", text: $user_name).textFieldStyle(CTFStyleClearBackground(width: UIScreen.screenWidth/2.5, cornerRadius: 20, height: 50,foregroundColor:.AppPrimaryColor, showError: $user_nameError)).disabled(true)
                            Spacer()
                            HStack{
                                Spacer()
                                Text("الاسم")
                            }.frame(width:UIScreen.screenWidth/4)

                        }

                        HStack{
                            TextField("", text: $phoneNumber).textFieldStyle(CTFStyleClearBackground(width: UIScreen.screenWidth/2.5, cornerRadius: 20, height: UIScreen.screenHeight/8.28,foregroundColor:.AppPrimaryColor, showError: $phoneNumberError)).disabled(true)
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
                                Spacer()
                                Text("رقم الهاتف")
                            }.frame(width:UIScreen.screenWidth/4)

                        }
                        VStack(spacing:8){
                        HStack{

                            SecureField("", text: $password).textFieldStyle(CTFStyleClearBackground(width: UIScreen.screenWidth/2.5, cornerRadius: 20, height:  UIScreen.screenHeight/8.28, showError: $passwordError))

                            Spacer()

                            HStack{
                                Spacer()
                                Text("كلمة المرور القديمة")
                            }.frame(width:UIScreen.screenWidth/4)

                        }
                        HStack{
                            SecureField("", text: $rePassword).textFieldStyle(CTFStyleClearBackground(width: UIScreen.screenWidth/2.5, cornerRadius: 20, height:  UIScreen.screenHeight/8.28, showError: $rePasswordError))
                            Spacer()
                            HStack{
                                Spacer()
                                Text("كلمة المرور الجديدة")
                            }.frame(width:UIScreen.screenWidth/4)
                        }
                        HStack{
                            Text("حفظ التغييرات").frame(width: UIScreen.screenWidth/3,height: 40).background(Color.AppPrimaryColor).cornerRadius(10).foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))).onTapGesture {
                                if passFIledValidation(){
                                    updateProfileChangePassword()
                                }
                            }
                            Spacer()
                        }
                    }
//Spacer()
                    }.frame(width:UIScreen.screenWidth/1.6).padding(.bottom,20).padding(.trailing,50)
                Spacer()
                Image("kayanSide").resizable().frame(width: UIScreen.screenWidth/3,height: UIScreen.screenHeight)
                }
            }.onAppear{
                getProfile()
                user_name = VarUserDefault.SysGlobalData.getGlobal(key: VarUserDefault.SysGlobalData.fullName)
                phoneNumber = VarUserDefault.SysGlobalData.getGlobal(key: VarUserDefault.SysGlobalData.mobileNo)
            }
            .alert(isPresented: self.$showsAlert) {
                Alert(title: Text(message).font(.custom("Cairo-Black", size: 16)) )
            }
        }.environment(\.horizontalSizeClass, .compact).onTapGesture {
            hideKeyboard()
        }
    }
    func isValidPassword() -> Bool {
            let passwordRegex = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~`’]{8,}$"
            return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
        }
    func passFIledValidation()->Bool{
        passwordError = false
        rePasswordError = false
        passwordError = password.count < 4
        rePasswordError = rePassword.count < 4
        
        if  !isValidPassword(){
            passwordError = true
            message="كلمة المرور لم تستوفي معاير الحماية المطلوبة "
        }
        if rePasswordError{
            passwordError = true
            message = " الرجاء كتابة كلمة السر الجديدة "
//            showsAlert=true
            
        }
        if passwordError{
            passwordError = true
            message = " الرجاء كتابة كلمة السر القديمة "
//            showsAlert=true
            
        }
        
//        if password != rePassword{
//            passwordError = true
//            message =   "لايوجد تطابق في كلمة المرور"
//        }
        print (passwordError)
        print (rePasswordError)
        print(!isValidPassword())
        print(passwordError || rePasswordError || !isValidPassword())
        showsAlert = passwordError || rePasswordError || !isValidPassword()
        return !showsAlert
    }
    func getProfile(){
            print( Connection().getUrl(word: "GetCustomerInfo"))
            //        RestAPI().getData(endUrl: Connection().getUrl(word: "GetStories")+"\(id)", parameters: [:])
            RestAPI().getData(endUrl: Connection().getUrl(word: "GetCustomerInfo"), parameters: [:]){ result in
                let sectionR = JSON(result!)
                print(sectionR)
                if sectionR["responseCode"].int == 200{
                    phoneNumber = String(sectionR["response"]["phoneNo"].stringValue.dropFirst(3))
//                    print(sectionR["response"]["phoneNo"].stringValue.fi(3))
//                    print(sectionR["response"]["phoneNo"].stringValue.dropLast()(3))
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
