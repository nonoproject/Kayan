//
//  Rate.swift
//  Kayan
//
//  Created by Sandal on 03/01/1443 AH.
//

import SwiftUI
import SwiftyJSON
struct Rate: View {
//    var body: some View {
        @State var phoneNumber=""
        @State var phoneNumberError:Bool=false
        @State var name:String=""
    @State var comment:String=""
    
        @State var checked:Bool=false
    @State var rating:Int = 5
    @State var page_story_id:Int
    
    
    
    @State  var  showsAlert:Bool=false
    @State  var  view_loading:Bool=false
    
    @State  var  message:String=""
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

        var body: some View {
            
          GeometryReader{ geo in
            ZStack{
                LinearGradient(gradient: Gradient(colors: [Color.init(hex:"F167BF"), Color.init(hex: "3068BD")]), startPoint: .topTrailing, endPoint: .bottomLeading)
                       .edgesIgnoringSafeArea(.vertical)
              
              
                VStack(spacing:5){
                    VStack(spacing:10){
                        HStack{
                        Spacer()
                            Image("close_button").resizable().frame(width: 20,height: 20).onTapGesture {
                                self.presentationMode.wrappedValue.dismiss()
                            }
                        }
                        RatingView(rating: $rating)
//                            .flipsForRightToLeftLayoutDirection(true)
                        
                    }.padding(.horizontal, 20)
                    .padding(.top,10)
                    HStack{
                        Spacer()
                        Text("شاركنا رأيك").padding(.horizontal,20)
                        
                    }.padding(.horizontal, 20)
                    TextEditor(text: $comment)
                        .modifier(customFountCB())
                           .foregroundColor(.Appliver)
                           .multilineTextAlignment(.center)
                           .frame(width: 350, height:70)
                        .cornerRadius(20)
//                           .background(
                               
                           
                    Text("تقيم").frame(width: 200,height: 40).background(Color.Appliver)
                        .cornerRadius(10).modifier(customFountCB()).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))).onTapGesture {
//                            if FormValidation(){
//                                view_loading = true
//                            checkUserSignIn()
                            rateThisIteam()
                        }.padding(.vertical,10)
                        
                HStack{
//                    Image("facebook").resizable().frame(width: 30,height: 30)
                    
                    Link(destination: URL(string: "https://www.facebook.com/kayanstories/")!) {
                        Image("facebook").resizable().frame(width: 30,height: 30)
            //                            .font(.largeTitle)
                    }

                    
                    Link(destination: URL(string: "https://instagram.com/kayanstories?utm_medium=copy_link")!) {
                        Image("instagram").resizable().frame(width: 30,height: 30)
            //                            .font(.largeTitle)
                    }
                    Image("snapchat").resizable().frame(width: 30,height: 30)
                    Image("twitter").resizable().frame(width: 30,height: 30)
                }
                    Link(destination: URL(string: "https://kayanapp.com")!) {
                        Text("KayanApp.com").foregroundColor(.white)
            //                            .font(.largeTitle)
                    }
//                    Text("KayanApp.com").foregroundColor(.white).onTapGesture {
//
//                    }
                    Spacer()
                    
                }.frame(width: 420,height: geo.size.height*0.8).background(
                    RoundedRectangle(cornerRadius: 25)
                    .foregroundColor(Color.clear)
                    .background(RoundedRectangle(cornerRadius: 25)
                                 .stroke( Color.gray, lineWidth: 1.5 )
                    )
                )
                    
                    
                    
                
            }
        }.alert(isPresented: self.$showsAlert) {
            
            Alert(
                title:  Text("نجاح").font(.custom("Cairo-Black", size: 18)).foregroundColor(.green) ,
                           message: Text(message).font(.custom("Cairo-Black", size: 16)) ,
                primaryButton: .default (Text("تم")) {
                               
                            self.presentationMode.wrappedValue.dismiss()
                           },
                secondaryButton: .cancel(Text("إلغاء"), action: {
                    self.presentationMode.wrappedValue.dismiss()
                })
                       )
        }.onTapGesture {
            hideKeyboard()
        }
            
    }
    func rateThisIteam(){
        let prams = ["CustomerID": VarUserDefault.SysGlobalData.getGlobalInt(key: VarUserDefault.SysGlobalData.userId),"StoryID":page_story_id,"Rate":rating]
             RestAPI().postData(endUrl: Connection().getUrl(word: "Rate"), parameters: prams) { result in
    //            showSandalLoadingIndicater=false
               let sectionR = JSON(result!)
                print(Connection().getUrl(word: "Rate"))
                      print(prams)
                print(sectionR)
//                view_loading=false
                if sectionR["responseCode"].int == 200{
    //
                    
    ////                print(sectionR["response"]["userId"].int)
    //                VarUserDefault.SysGlobalData.setGlobal(Key: VarUserDefault.SysGlobalData.mobileNo, Val:sectionR["response"]["customer"]["phone"].stringValue)
    //        VarUserDefault.SysGlobalData.setGlobal(Key: VarUserDefault.SysGlobalData.fullName, Val:sectionR["response"]["customer"]["name"].stringValue)
    //
//                    VarUserDefault.SysGlobalData.setGlobal(Key: VarUserDefault.SysGlobalData.userId, Val:sectionR["response"]["id"].intValue)
    //        print( VarUserDefault.SysGlobalData.getGlobalInt(key: VarUserDefault.SysGlobalData.userId))
    //
    //               VarUserDefault.SysGlobalData.setGlobal(Key: VarUserDefault.SysGlobalData.isLogin, Val:true)
    //
    //                isHomeView=true
    //
//                    isLogin = true
                message="شكرا لمشاركتنا رأيك"
                    showsAlert = true
//                    self.presentationMode.wrappedValue.dismiss()
                }
               
                
            } onError: { error in
                print(error)
                    message="حدث خطاء ما"
                    showsAlert = true
//                view_loading=false
    //            showSandalLoadingIndicater=false
            }

            

        
    }
    }
