//
//  Pay_story.swift
//  Kayan
//
//  Created by Sandal on 03/01/1443 AH.
//

import SwiftUI
import SwiftyJSON

struct Pay_story: View {
    @State var story:StroryModal
    @State var phoneNumber=""
    @State var phoneNumberError:Bool=false
    
    @State var name:String=""
    @State var cobone:String=""
    @State var coboneError:Bool=false
    @State var checked:Bool=false
    @State var isCobonActivated:Bool=false
    @Binding var view_story_to_supscription_binding:Bool
    @Binding var show_pay_modal:Bool
    @State var storyPriceAfterCoupon:String=""
    @State var storyPriceAfterCouponMessage:String=""
    
//    @Binding var story_pay_url:String
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
//    WebViewModel
//    @StateObject var model = WebViewModel()
    
    @State  var  showsAlert:Bool=false
    @State  var  view_loading:Bool=false
    @State  var  message:String=""
    var body: some View {
        
      GeometryReader{ geo in
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color.init(hex:"F167BF"), Color.init(hex: "3068BD")]), startPoint: .topTrailing, endPoint: .bottomLeading).opacity(0.84)
                .edgesIgnoringSafeArea(.vertical)
                   
    
            VStack{
          HStack{
            VStack{
                
                Image("close_button").resizable().padding(5).frame(width: 32, height: 32)
                    //.background(Color.Appliver).foregroundColor(.white).cornerRadius(5).rotationEffect(Angle(degrees: 180))
                    .onTapGesture {
                                                       
                    view_story_to_supscription_binding=false
                }//.padding(.leading,5)
                    .offset(x: -5, y: -10)
                Spacer()
            }
            Spacer()
            VStack(spacing:0){
              
                HStack(spacing:90){
                
                Rectangle().fill(Color.AppPrimaryColor).frame(width:3,height: 12)
                
                Rectangle().fill(Color.AppPrimaryColor).frame(width:2,height: 12)
                    
            }.frame(width: 220)
                Rectangle().fill(Color.AppPrimaryColor).frame(width: 170,height: 50).overlay(
                    VStack{
                        Text(" بطاقة شراء").foregroundColor(.Appliver)
                    }.foregroundColor(.brown).font(.system(size: 15), weight: .heavy)
                ).cornerRadius(10)
                Spacer()
            }.offset(x:-16)
            Spacer()
          }
              VStack{
              
                  Spacer()
                  
//                Divider().foregroundColor(.black).padding(.vertical,20)
                
                HStack{
                    
                VStack{
                    
                    HStack{
                        Spacer()
                        Text(story.name!)//.textFieldStyle(CTFStyleClearBackground(width: 200, cornerRadius: 20, height: 40, showError: $phoneNumberError))
                            
                            .padding(.trailing,20)
                        Text("الإسم").frame(width: 100,alignment: .trailing)
                    }.padding(.trailing,20)
                HStack{
                    Spacer()
                    RatedView(rating: Int(story.rate!))
                        .padding(.trailing,20)
                    Text("تقييم القصة").frame(width: 100,alignment: .trailing)
                }.padding(.trailing,20)
                    HStack{
//                        Spacer()
//                        HStack{
//                            Spacer()
                        Spacer()
                        Spacer()
                        Button(action: {
                            checkCobonValue()
                        }) {
                            HStack{
                                Text("إختبار").font(.custom("Cairo-Black", size: 15)).foregroundColor(.white)
                            Image(systemName: "checkmark.circle.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.white).opacity(isCobonActivated ? 1 : 0)
                                
                            }.padding(5).background(isCobonActivated ? Color.green : Color.orange).cornerRadius(8)
                        }
                        TextField("", text: $cobone)
                            .textFieldStyle(CTFStyleClearBackground(width:  UIScreen.screenWidth*0.15, cornerRadius: 20, height: 40, showError: $coboneError))
                            .modifier(customFountCB())
                            .foregroundColor(.Appliver)
//                            .keyboardType(.)
//                            .padding(.trailing,20)
                        
                        Spacer()
                        Text(" كوبون ").frame(width: 100,alignment: .trailing)
                        
                    }.padding(.trailing,20)

                    HStack{
//                        Spacer()
//                        HStack{
//                            Spacer()
                        Spacer()
                        HStack(spacing:0){
                            Text("ريال").font(.custom("Cairo-Regular", size: 11)).foregroundColor(.Appliver)
                            Text(isCobonActivated ? storyPriceAfterCoupon : "\(story.subscribePrice!)")//.frame(width: 50,height: 30).background(Color.AppPrimaryColor)
                                .padding(5).cornerRadius(8)
                        
                        }.padding(.trailing,20)
                       
                        
                        Text("سعر القصة").frame(width: 100,alignment: .trailing)
                    }.padding(.trailing,20)
                    .overlay(
                        VStack{
                            Spacer()
                            Text(isCobonActivated ?( " قيمة الكوبون "+"\(storyPriceAfterCouponMessage)") : "").font(.custom("Cairo-Regular", size: 14)).foregroundColor(.Appliver)
                        }.frame(height:60).offset(x:-30)
                    )
                    HStack{
                        Spacer().zIndex(10)
                        
                                    Button(action: {
                                        add_story_to_supscription(story_id: story.id)
                                    }, label: {
                                        Text("شراء الان").frame(width: 255,height: 40).background(Color.Appliver).cornerRadius(10).font(.system(size: 15)).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                                    })
                     
                        Spacer()
                    }.padding(.vertical,30)
                }
                    
                }
                Spacer()
              }
            }.frame(width: UIScreen.screenWidth*0.5).background(
                RoundedRectangle(cornerRadius: 25)
                .foregroundColor(Color.white)
                .background(RoundedRectangle(cornerRadius: 25)
                             .stroke( Color.gray, lineWidth: 1.5 )
                )
            ).padding(.vertical,20)
        }.alert(isPresented: self.$showsAlert) {
            Alert(title: Text(message).font(.custom("Cairo-Black", size: 16)) )
        }
    }
}
    
    func checkCobonValue(){
        
        
        
        if cobone != "" {
            coboneError=false
            let prams = ["CouponCode":cobone,"CustomerId":VarUserDefault.SysGlobalData.getGlobalInt(key: VarUserDefault.SysGlobalData.userId)
                         ,"StoryID":story.id] as [String : Any]
            print( Connection().getUrl(word: "GetCheckCoupon"))
            print(prams)
            RestAPI().postData(endUrl: Connection().getUrl(word: "GetCheckCoupon"), parameters: prams){ result in
               let sectionR = JSON(result!)
                print(sectionR)
                
                if sectionR["responseCode"].int == 200{
//
                    storyPriceAfterCoupon = sectionR["response"]["storyPriceAfterCoupon"].stringValue
                    storyPriceAfterCouponMessage=sectionR["response"]["couponValue"].stringValue
                        isCobonActivated=true
                    
                    message = "تم تفعيل الكوبون قيمة الكوبون هي \(storyPriceAfterCouponMessage)"
                    showsAlert = true
                }
                else{
                    message =  sectionR["response"].stringValue //"عفوا تاكد من الكوبون"
                    showsAlert = true
                    coboneError=true
                    
                    storyPriceAfterCoupon = ""// sectionR["response"]["storyPriceAfterCoupon"].stringValue
                    storyPriceAfterCouponMessage=""//sectionR["response"]["couponValue"].stringValue
                        isCobonActivated=false
                }
            } onError: { error in
                print(error)
            }
        }
        else{
            message = "قيمة الكوبون خالية"
            showsAlert = true
        }
        }
    func add_story_to_supscription(story_id:Int){
        var prams = [String:Any]()
        var storySubscribe = [String:Int]()
//        if isCobonActivated{
            storySubscribe["CustomerID"]=VarUserDefault.SysGlobalData.getGlobalInt(key: VarUserDefault.SysGlobalData.userId)
        storySubscribe["StoryID"]=story_id
            prams["storySubscribe"]=storySubscribe
        prams["IsHasCoupon"]=isCobonActivated
        prams["CouponCode"]=cobone
        print( Connection().getUrl(word: "StorySubscribe"))
        print(prams)
        RestAPI().postData(endUrl: Connection().getUrl(word: "StorySubscribe"), parameters: prams){ result in
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
    
}
