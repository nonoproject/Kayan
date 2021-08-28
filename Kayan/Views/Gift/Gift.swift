//
//  Gift.swift
//  Kayan
//
//  Created by Awad sandal on 05/04/2021.
//

import SwiftUI
import SwiftyJSON
struct Gift: View {
    @State var user_name=""
    @State var phoneNumberError:Bool=false
    @ObservedObject var textBindingManager = TextBindingManager(limit: 10)
    @State var name_error:Bool=false
     var story_id:Int
    @State var checked:Bool=false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var show_pay_modal:Bool=false
//    @State var story_pay_url:String=""
    
//    @State var add_story_to_supscription_binding:Bool=false
    
    @State var timer = Timer.publish (every: 1, on: .current, in: .common).autoconnect()
    @State var timeRemaining = -1
    
    @State  var  showsAlert:Bool=false
    @State  var  view_loading:Bool=false
    
    @State  var  message:String=""
    var body: some View {
        
      GeometryReader{ geo in
        ZStack{
//            LinearGradient(gradient: Gradient(colors: [Color.init(hex:"F167BF"), Color.init(hex: "3068BD")]), startPoint: .topTrailing, endPoint: .bottomLeading)
            Color.gray.opacity(0.4)
                   .edgesIgnoringSafeArea(.all)
            VStack{
          HStack{
            VStack{
                
                Image(systemName: "play.fill").resizable().padding(5).frame(width: 32, height: 32).background(Color.Appliver).foregroundColor(.white).cornerRadius(5).rotationEffect(Angle(degrees: 180)).onTapGesture {
                                                            self.presentationMode.wrappedValue.dismiss()
                }.padding(.leading,5)
                Spacer()
            }.padding(20)
            Spacer()
              VStack{
                  VStack(spacing:0){
                      HStack(spacing:90){
                      
                      Rectangle().fill(Color.white).frame(width:3,height: 12)
                      
                      Rectangle().fill(Color.white).frame(width:2,height: 12)
                          
                  }.frame(width: 220)
                      Rectangle().fill(Color.white).frame(width: 220,height: 70).overlay(
                          VStack{
                              Text("هديتي لك")
                          }.foregroundColor(.Appliver).font(.system(size: 17), weight: .heavy)
                      ).cornerRadius(10)
                      Spacer()
                  }
                  Spacer()
                  
                  Spacer()
              }
            Spacer()
          }
                VStack{
                    Spacer()
                    ZStack{
                        LinearGradient(gradient: Gradient(colors: [Color.init(hex:"F167BF"), Color.init(hex: "3068BD")]), startPoint: .topTrailing, endPoint: .bottomLeading)
                               .edgesIgnoringSafeArea(.vertical)
                               
                        VStack{
                            Spacer()
                            HStack{
                                    Spacer()
                                VStack{
                                    Spacer()
                                    HStack{
                                        Spacer()
                                        TextField("sad", text: $user_name).textFieldStyle(CTFStyleClearBackground(width: 200, cornerRadius: 20, height: 40, showError: $phoneNumberError))
                                        
                                        Text("الإسم").frame(width: 90)
                                        
                                    }
                                HStack{
                                    Spacer()
                                    
                                    TextField("05xxxxxxxx", text: $textBindingManager.text, onEditingChanged: onEditingChanged(_:), onCommit: onCommit)
                                        .textFieldStyle(CTFStyleClearBackground(width: 200, cornerRadius: 20, height: 40, showError: $phoneNumberError))
                                        .modifier(customFountCB())
                                        .foregroundColor(.Appliver)
                                        .keyboardType(.phonePad)
                                    Text("رقم الهاتف").frame(width: 90)
                                }
                                    HStack{
                                        Spacer()
                                        HStack{
                                            Spacer()
                                            Text("").frame(width: 50,height: 30).background(Color.AppPrimaryColor).padding(5).cornerRadius(8)
                                        }.frame(width:200)
                                        Text("سعر القصة").frame(width: 90)
                                    }
                                }
                                
Spacer()
                            }
                            HStack{
                                Spacer()
                                
                                            Button(action: {
                                                if FormValidation(){
                                                add_story_to_supscription(story_id: story_id)
                                                }
                                            }, label: {
                                                Text("إهداء الان").frame(width: 255,height: 40).background(Color.AppPrimaryColor).cornerRadius(10).font(.system(size: 15)).foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
                                            })
                             
                                Spacer()
                            }.padding(.bottom,30)
                            Spacer()
                        }.zIndex(10)
                        LinearGradient(gradient: Gradient(colors: [ Color.init(hex: "3068BD"),Color.init(hex:"F167BF")]), startPoint: .leading, endPoint: .bottomTrailing)
                    }
                    Spacer()
                }.frame(width: 600).cornerRadius(20).padding(.bottom,60)
                
//                       .edgesIgnoringSafeArea(.vertical)
                Spacer()
            }
            
        }
        .onReceive(timer) { _ in
                    if self.timeRemaining < 0 {
                        // We don't need it when we start off
                        self.timer.upstream.connect().cancel()
                        return
                    }
                    if self.timeRemaining > 0 {
                        if is_payment_success{
                            
                            self.timer.upstream.connect().cancel()
                            resetViewData()
                        }
                        else{
                            
                            self.timeRemaining -= 1
                        }
                        
                    } else {
                        timeRemaining = 30
//                                                                self.timer.upstream.connect().cancel()
                        self.timer = Timer.publish (every: 1, on: .current, in:
                            .common).autoconnect()
                        // Do the action on end of timer. Text would have been hidden by now
                    }
              }
//
//            if  add_story_to_supscription_binding {//|| !show_pay_modal{
//            Pay_story(story: stories[CardIndecator], view_story_to_supscription_binding: $add_story_to_supscription_binding,show_pay_modal:$show_pay_modal)//,story_pay_url:$story_pay_url)
////                Pay_story(view_story_to_supscription_binding:,story:)
//          }
            if show_pay_modal{
                ZStack(alignment: .top){
                    HStack{
                    Image("close_button").resizable().padding(5).frame(width: 50, height: 40)
                        .onTapGesture {
//                            add_story_to_supscription_binding=false
//                            show_pay_modal=false
                            resetViewData()
                    }.padding(.leading,5)
                        Spacer()
                    }.offset(x:63).zIndex(10)
                    
                    payment_WebView(request:URLRequest(url: URL(string:story_pay_url)!))
                    
                    .onTapGesture {
                    self.hideKeyboard()
        //
                    }.frame(maxWidth:600)//.padding(.horizontal,80)
                    
                }
                .onAppear{
//                        is_payment_success = true
                     timeRemaining = 30
                    self.timer = Timer.publish (every: 1, on: .current, in:.common).autoconnect()

                }
            }
      }.onTapGesture {
        hideKeyboard()
      }
      .onAppear{
        textBindingManager.text=""
          print(story_id)
      }.alert(isPresented: self.$showsAlert) {
        Alert(title: Text(message).font(.custom("Cairo-Black", size: 16)) )
    }
        
}
    func FormValidation() -> Bool {
        
        self.phoneNumberError = (self.textBindingManager.text.isEmpty || self.textBindingManager.text.count != 10 || !self.textBindingManager.text.hasPrefix("05") ) ? true : false
        name_error = user_name.isEmpty || self.user_name.count <  4
        if phoneNumberError{
            message="خطاء في رقم الجوال"
            showsAlert=true
        }
        else if name_error{
            message="الاسم خالي"
            showsAlert=true
        }
        return (!self.phoneNumberError && !self.name_error)
    }
    func onCommit() {
           print("commit")
       }
       func onEditingChanged(_ changed: Bool) {
           print(changed)
       }
    func add_story_to_supscription(story_id:Int){
        var prams = ["CustomerID":VarUserDefault.SysGlobalData.getGlobalInt(key: VarUserDefault.SysGlobalData.userId),"StoryID":story_id,"PhoneNo":"\(textBindingManager.text)","Name":user_name] as [String : Any]

        print( Connection().getUrl(word: "StoryGift"))
        print(prams)
        RestAPI().postData(endUrl: Connection().getUrl(word: "StoryGift"), parameters: prams){ result in
           let sectionR = JSON(result!)
            print(sectionR)
            
            if sectionR["responseCode"].int == 200{
//                VarUserDefault.SysGlobalData.setGlobal(Key: VarUserDefault.SysGlobalData.story_pay_url, Val: sectionR["responseCode"].stringValue)
                story_pay_url =// "https://payments-dev.urway-tech.com//URWAYPGService//HTMLPage.html"//
                    sectionR["response"].stringValue
                
                story_pay_url = story_pay_url.replacingOccurrences(of: "\\", with: "")
                print(story_pay_url)
//                model.url = URL(string : "https://payments-dev.urway-tech.com//URWAYPGService//HTMLPage.html")!
                show_pay_modal = true
                
//                selectd_story_page_MenuID=imageName.id
//                story_Questions_List = imageName.storyQuestionsList ?? []
//                is_go_to_story_page=true
                //////
//                selectdMenuID=imageName.id
//                        print(imageName.storyQuestionsList)
//                    story_Questions_List=imageName.storyQuestionsList ?? []
//                    print(story_Questions_List)
//                    isSignIn=true
            }
            else{
//                story_pay_url = "https://payments-dev.urway-tech.com/URWAYPGService/direct.jsp?paymentid=2122412453308233713"
//                model.objectWillChange
//                model.loadUrl()
//                show_pay_modal = true
            }
        } onError: { error in
            print(error)
        }
        
    }
    func resetViewData(){
//        add_story_to_supscription_binding=false
        show_pay_modal=false
//        is_payment_succesrlse
        is_payment_success = false
        presentationMode.dismiss()

//        GetStories()
//        }
        
    }
}
