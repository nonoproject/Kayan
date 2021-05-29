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
    @State var checked:Bool=false
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
                        
                        VStack(spacing:25){
                            Spacer()
                        HStack{
                            TextField("اسم المستخدم", text: $fullname).textFieldStyle(CTFStyleClearBackground(width: 250, cornerRadius: 20, height: 40, showError: $phoneNumberError))
                            Spacer()
                            Text("الاسم")
                        }
//                        Spacer()
                        HStack{
                            TextField("5xxxxxxxx", text: $phoneNumber).textFieldStyle(CTFStyleClearBackground(width: 250, cornerRadius: 20, height: 40, showError: $phoneNumberError))
                            Spacer()
                            Text("رقم الهاتف")
                        }
//                        Spacer()
                        HStack{
                            SecureField("*****", text: $PassWord).textFieldStyle(CTFStyleClearBackground(width: 250, cornerRadius: 20, height: 40, showError: $phoneNumberError))
                            Spacer()
                            Text("كلمة المرور")
                            
                        }
//                        }
//                        Spacer()
                        HStack(spacing:20){
                            Spacer()
                                
                            HStack{
                               
                                                Button(action: {
                                                    withAnimation{
                                                    checked = true
                                                }
                                                }, label: {
                                                    ZStack{
                                                        Circle()
                                                            .frame(width: 24, height: 24)
                                                            .foregroundColor(checked ?  Color.init(hex: "C7C4C4") : .gray )


                                                        Circle()
                                                            .frame(width: 20, height: 20)
                                                            .foregroundColor(.white)

                                                        Circle().frame(width: 16, height: 16).foregroundColor(checked ?  Color.init(hex: "C7C4C4") : Color.white.opacity(0.5))

                                                    }
                                                })
                                Image("female").resizable().frame(width: 38, height: 42)

                            }
                            Spacer().maxWidth(25)
                            HStack{
                                
                                Button(action: {
                                    withAnimation{
                                    checked = false
                                    }
                                }, label: {
                                    ZStack{
                                        Circle()
                                            .frame(width: 24, height: 24)
                                            .foregroundColor(!checked ?  Color.init(hex: "C7C4C4") : .gray)
                                        
                                        
                                        Circle()
                                            .frame(width: 20, height: 20)
                                            .foregroundColor(.white)
                                            
                                        Circle().frame(width: 16, height: 16).foregroundColor(!checked ?  Color.init(hex: "C7C4C4") : Color.white.opacity(0.5))

                                    }
                                })
                                Image("male").resizable().frame(width: 42, height: 42)
                                
                            }

                            Spacer()
                            Text("الجنس")
                            
                        }
                        
//                        Spacer()
                            if !showSandalLoadingIndicater{
                                Button(action: {
                                    showSandalLoadingIndicater=true
                                    if FormValidation(){
                                        checkUserSignUp()
                                    }
                                    else{
                                        ////
                                        showSandalLoadingIndicater=false
                                    }
                                }, label: {
                                    Text("هيا بنا").frame(width: 255,height: 40).background(Color.init(hex: "F1E6E0").opacity(0.97))
                                        .cornerRadius(10).font(.system(size: 15)).foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
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
        
        let prams = ["PhoneNo":StringFunction().numberStrToEnglish(numberStr: self.phoneNumber),"Password": self.PassWord,"Name":self.fullname,"GanderID":checked ? "2" : "1"]
        print(Connection().getUrl(word: "register"))
        print(prams)
        RestAPI().postData(endUrl: Connection().getUrl(word: "register"), parameters: prams) { result in
            
            showSandalLoadingIndicater=false
           let sectionR = JSON(result!)
            print(sectionR)
            print(prams)
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
            showSandalLoadingIndicater=false
        }

//        isLogin = true
//        VarUserDefault.SysGlobalData.setGlobal(Key: VarUserDefault.SysGlobalData.isLogin, Val:isLogin)
    }
    func FormValidation() -> Bool {
        self.fullnameError = (self.fullname.isEmpty || self.fullname.count < 3) ? true : false
        self.phoneNumberError = (self.phoneNumber.isEmpty || self.phoneNumber.count != 9) ? true : false
//        self.PassWordError = self.PassWord.isEmpty ? true : false
//        self.RePassWordError = self.RePassWord.isEmpty ? true : false
        if  self.PassWord.isEmpty{//PassWord != RePassWord {//||
            self.PassWordError = true
            self.RePassWordError=true
        }
        else {
            self.PassWordError = false
            self.RePassWordError=false
        }
         if phoneNumberError{
            message=" خطاء في رقم الجوال"
            showsAlert=true
        }
        else if fullnameError{
            message="الاسم غير صحيح"
            showsAlert=true
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
