//
//  SignUp.swift
//  Kayan
//
//  Created by Awad sandal on 01/04/2021.
//

import SwiftUI
import SwiftyJSON
struct SignUp: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var  checked:Int = -1 // 0=null "2" : "1"
    @State  var  view_loading:Bool=false
//        HStack{
//
//            Button(action: {
//                    self.presentationMode.wrappedValue.dismiss()
//                    }) {
//                        HStack {
//                        Image("ic_back") // set image here
//                            .aspectRatio(contentMode: .fit)
//                            .foregroundColor(.white)
//                            Text("Go back")
//                        }
//            }
//        }
    @State private var fullname=""
    @State private var fullnameError=false
    @State private var phoneNumber=""
    @State private var phoneNumberError=false
    @State private var countryCode=""
    @State private var countryCodeError=false
//    @State private var PassWord="123456"
        @State private var PassWord=""
    @State private var PassWordError=false
    @State private var RePassWord=""
    @State private var RePassWordError=false
    @State private var ErrorMessage=""
    
    //////////
    @State private var  displayItem = -1
    @State private var  SignUpPassed=false
    @State private var  showSandalLoadingIndicater=false
    @State  var  showsAlert:Bool=false
    @State  var  message:String=""
        @State var isSigIn = false
        var body: some View {
            NavigationView{
        GeometryReader{ geo in
            NavigationLink(destination: Home().navigationBarTitle(Text("Home"))
                            .navigationBarHidden(true), isActive: self.$SignUpPassed) {
            }.hidden()
            NavigationLink(destination: SignIn().navigationBarTitle(Text("Home"))
                            .navigationBarHidden(true), isActive: self.$isSigIn) {
            }.hidden()
            ZStack{
                
                LinearGradient(gradient: Gradient(colors: [Color.init(hex: "FCF1EF"), Color.init(hex: "BE9ECB"),Color.init(hex:"5461A7")]), startPoint: .topTrailing, endPoint: .bottomLeading)
                       .edgesIgnoringSafeArea(.vertical)
            HStack{
//            VStack{
//                Image("fllower").resizable().frame(width: 189,height: 189)
                Spacer()
//            }
                VStack{

                    Spacer()
//                    VStack{
                        
                        VStack(spacing:10){
                            Spacer()
                        HStack{
                            TextField("اسم المستخدم", text: $fullname).textFieldStyle(CTFStyleClearBackground(width: 250, cornerRadius: 20, height: 40, showError: $phoneNumberError))
                            Spacer()
                            Text("الاسم")
                        }
//                        Spacer()
                        HStack{
                            TextField("5xxxxxxxx", text: $phoneNumber).textFieldStyle(CTFStyleClearBackground(width: 250, cornerRadius: 20, height: 40, showError: $phoneNumberError))
                                .keyboardType(.phonePad)
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
                            Text("رقم الهاتف")
                        }
//                        Spacer()
                        HStack{
                            SecureField("*****", text: $PassWord).textFieldStyle(CTFStyleClearBackground(width: 250, cornerRadius: 20, height: 40, showError: $PassWordError))
                            Spacer()
                            Text("كلمة المرور")
                            
                        }
                            HStack{
                                SecureField("*****", text: $RePassWord).textFieldStyle(CTFStyleClearBackground(width: 250, cornerRadius: 20, height: 40, showError: $RePassWordError))
                                Spacer()
                                Text(" إعادة كلمة المرور")
                                
                            }
//                        }
//                        Spacer()
                        HStack(spacing:20){
                            Spacer()
                                
                            HStack{
                               
                                                Button(action: {
                                                    withAnimation{
                                                    checked = 1
                                                }
                                                }, label: {
                                                    ZStack{
                                                        Circle()
                                                            .frame(width: 24, height: 24)
                                                            .foregroundColor(checked == 1 ?  Color.init(hex: "C7C4C4") : .gray )


                                                        Circle()
                                                            .frame(width: 20, height: 20)
                                                            .foregroundColor(.white)

                                                        Circle().frame(width: 16, height: 16).foregroundColor(checked == 1 ?  Color.init(hex: "C7C4C4") : Color.white.opacity(0.5))

                                                    }
                                                })
                                Image("female").resizable().frame(width: 38, height: 42)

                            }
                            Spacer().maxWidth(25)
                            HStack{
                                
                                Button(action: {
                                    withAnimation{
                                    checked = 0
                                    }
                                }, label: {
                                    ZStack{
                                        Circle()
                                            .frame(width: 24, height: 24)
                                            .foregroundColor(checked == 0 ?  Color.init(hex: "C7C4C4") : .gray)
                                        
                                        Circle()
                                            .frame(width: 20, height: 20)
                                            .foregroundColor(.white)
                                            
                                        Circle().frame(width: 16, height: 16).foregroundColor(checked == 0 ?  Color.init(hex: "C7C4C4") : Color.white.opacity(0.5))

                                    }
                                })
                                Image("male").resizable().frame(width: 42, height: 42)
                                
                            }

                            Spacer()
                            VStack(spacing:-5) {
                                Text("\"إختياري\"").foregroundColor(.white).font(.custom("Cairo-Black", size: 11)).offset(x: -20)
                            Text("الجنس")
                            }
                            
                        }
                        
//                        Spacer()
                            if !showSandalLoadingIndicater{
                                Button(action: {
                                    view_loading=true
                                    if FormValidation(){
                                        checkUserSignUp()
                                    }
                                    else{
                                        view_loading=false
                                    }
//                                    print(isValidPassword())
                                }, label: {
                                    Text("هيا بنا").frame(width: 255,height: 40).background(Color.init(hex: "F1E6E0").opacity(0.97))
                                        .cornerRadius(10).foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
                                })
                               
                            }
                            else{
                                VStack(alignment:.center){
                                    
                                sandalLoadingIndicater()
                                
                                }.frame(width: 318, height: 50, alignment: .center)
                            }
                        
//                        Spacer()
                        HStack{
                            Spacer()
                           
                            Button(action: {
                               isSigIn=true
                            }, label: {
                                Text("لديك حساب بالفعل؟ تسجيل الدخول").foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))//foregroundColor(Color.init(hex: "F1E6E0"))
                            })
                            
                            
                            
                            
                        }
                        Spacer()
                    }.frame(width:370)
                    Spacer()
                }
                Spacer()
                Image("kayanSide").resizable().renderingMode(.none).frame(width: 220)
            }
                if (displayItem != -1) {
                    SendVarificationCode(completeSignUpPassed: $SignUpPassed, path:"is_come_form_login_operation", displayItem: $displayItem, phoneNumber: StringFunction().numberStrToEnglish(numberStr:phoneNumber))
                               
                       }
                if view_loading{
                    ZStack{
                        Color.Appliver
                            .opacity(0.66)
                LoadinIndicator()
                    }.edgesIgnoringSafeArea(.all)
                }
        }.edgesIgnoringSafeArea(.all)
    }.onTapGesture {
        self.hideKeyboard()

      }.navigationBarTitle(Text("Home"))
        .navigationBarHidden(true)
        }.environment(\.horizontalSizeClass, .compact).alert(isPresented: self.$showsAlert) {
            Alert(title: Text(message))
        }
        }
    
    func checkUserSignUp(){
        
        let prams = ["PhoneNo":"966"+StringFunction().numberStrToEnglish(numberStr: self.phoneNumber),"Password": self.PassWord,"Name":self.fullname,"GanderID":checked ] as [String : Any]
        print(Connection().getUrl(word: "register"))
        print(prams)
        RestAPI().postData(endUrl: Connection().getUrl(word: "register"), parameters: prams) { result in
            
            showSandalLoadingIndicater=false
           let sectionR = JSON(result!)
            print(sectionR)
            print(prams)
            view_loading=false
            if sectionR["responseCode"].int == 200{
//                SignUpPassed=true

                displayItem=1
            }
            
            if sectionR["responseCode"].int == 400{
                message=sectionR["responseMasg"].stringValue
                showsAlert=true
            }
            if sectionR["responseCode"].int == 409{
                message="هذا الرقم موجود مسبقا"
                showsAlert=true
            }
            
        } onError: { error in
            print(error)
            message="عفوا حدث خطاء ما"
            showsAlert=true
            view_loading=false
            showSandalLoadingIndicater=false
        }

//        isLogin = true
//        VarUserDefault.SysGlobalData.setGlobal(Key: VarUserDefault.SysGlobalData.isLogin, Val:isLogin)
    }
    func isValidPassword() -> Bool {
        
            let passwordRegex = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~`’]{8,}$"
            return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: PassWord)
        }
    func FormValidation() -> Bool {
        self.fullnameError = (self.fullname.isEmpty || self.fullname.count < 3) ? true : false
        self.phoneNumberError = (self.phoneNumber.isEmpty || self.phoneNumber.count != 9 )//|| self.phoneNumber.hasPrefix("05")) ? true : false
//        self.PassWordError = self.PassWord.isEmpty ? true : false
//        self.RePassWordError = self.RePassWord.isEmpty ? true : false
        
    PassWordError = self.PassWord.isEmpty || PassWord != RePassWord || !isValidPassword()
        
    if  PassWordError{//||
        
        if PassWord.isEmpty{
        
            message="كلمة المرور لايمكن ان تكون خالية"
       }
        else if PassWord != RePassWord{
            message="كلمة المرور غير متطابقة"
        }
        else if !isValidPassword(){
            message="كلمة المرور لم تستوفي معاير الحماية المطلوبة "
        }
           self.PassWordError = true
            self.RePassWordError=true
        
        showsAlert=true
    }
    else {
        self.PassWordError = false
        self.RePassWordError=false
        
    }

        if phoneNumberError{
            message=" خطاء في رقم الجوال"
            showsAlert=true
        }
        else {
            self.phoneNumberError = false
            self.phoneNumberError=false
        }
        if fullnameError {
            message="الاسم غير صحيح"
            showsAlert=true
        }
        else {
            self.fullnameError = false
            self.fullnameError=false
        }
//        else  if RePassWordError{
//            message="كلمة المرور يجب ان تكوت متطابقة وغير خالية"
//            showsAlert=true
//        }
        
        return (!self.fullnameError && !self.phoneNumberError && !self.PassWordError && !self.RePassWordError)
    }
    
    }

//
//struct SignUp_Previews: PreviewProvider {
//    static var previews: some View {
////        SignUp()
//    }
//}
