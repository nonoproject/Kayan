//
//  ComingSoon.swift
//  Kayan
//
//  Created by Sandal on 10/01/1443 AH.
//

import SwiftUI
import SwiftyJSON

    struct ComingSoon: View {
        @State var timer = Timer.publish (every: 1, on: .current, in: .common).autoconnect()
        @State var timeRemaining = -1
        @State var id:Int=0
        @State var ther_are_no_data = false
    //    @StateObject var model = WebViewModel()
        
        @State var selected_id=3
        @State var title:String=""
        var imageName=["quran","meditation","childrenStory"]
        var storyName=["قصص براعم","قصص الابطال","قصص القادة"]
        var storyAge=["5-3","8-6","9-12"]
        @State var is_go_to_story_page:Bool=false
        @State var show_pay_modal:Bool=false
    //    @State var story_pay_url:String=""
        
        @State var add_story_to_supscription_binding:Bool=false
        
        @Environment(\.presentationMode) var presentation
        var horizontalPaddig:CGFloat=30.0
        @Environment(\.presentationMode) var presentationModeEdit: Binding<PresentationMode>
        @State var stories:[StroryModal]=[]
        ////////////
        @State  var BackagePosition:[CGFloat]=[]
        @State  var BackageHight:[CGFloat]=[]
        @State private var CardIndecator=0//max number of item
        //    @State  var storyQuestionsList:[storyQuestionsList]=[]
    //    @ObservedObject var allMessages =  SignalRService(url:  URL(string: "\(AppBase)/NotificationHub?customerId=\(VarUserDefault.SysGlobalData.getGlobalInt(key: VarUserDefault.SysGlobalData.userId))")!)

    //    @State var kkkkkdsds:Double=0
    //    @State var kkkkk:CGFloat=0
        var body: some View {
            GeometryReader{geo in
                
                
                ZStack{
                    LinearGradient(gradient: Gradient(colors: [Color.init(hex: "FCF1EF"), Color.init(hex: "BE9ECB"),Color.init(hex:"5461A7")]), startPoint: .topTrailing, endPoint: .bottomLeading)
                        .edgesIgnoringSafeArea(.vertical)
                    
                    VStack( spacing: 0){
                        
//                        Navbars(page_titel: title)
//                        Spacer()
                        
                            
                            
                                Spacer()
                                    HStack{
                                        
                                        Image(systemName: "play.fill").resizable().frame(width: 22, height: 22).background(Color.Appliver).foregroundColor(.white).cornerRadius(5).rotationEffect(Angle(degrees: 180)).onTapGesture {
                                            self.presentationModeEdit.wrappedValue.dismiss()
                                        }.padding(.leading,5)
                                        Spacer()
                                        
                                        
                                    }.padding(.vertical,40)
                                
                                    Spacer()
                                
                                
                                        
                                if stories.count > 0 {
                                    
//                                                                    ScrollViewReader { action in
                                                                        ScrollView(.horizontal, showsIndicators: false) {
                                                                            HStack (alignment:.center, spacing:20){
                                                                            //
                                                                                Spacer()
                                        ForEach(0...stories.count-1,id:\.self){ index in
//                                            VStack{
                                            ComingSoon_Card_Cards(imageName:stories[index],BackageHight: UIScreen.card_heigh,width: UIScreen.card_width,title: $title, selectdMenuID: $id, isSignIn: $is_go_to_story_page,add_story_to_supscription_binding:$add_story_to_supscription_binding)
                                            
//                                            }
                                            
                                        }
                                    }.ignoresSafeArea(.all)
                                    Spacer()
                                                                        }
                                                                        
//                                                                    }
                                }
                            else{
                             VStack{
                                 Spacer()
                                 if ther_are_no_data{
                                     Text(" عفوا لاتوجد بيانات ").foregroundColor(.Appliver)
                                 }
                                 else{
                                     LoadinIndicator().onAppear{
                                         let seconds = 4.0
                                         DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                                             // Put your code which should be executed with a delay here
                                             ther_are_no_data = true
                                         }
                                     }
                                 }
                                 Spacer()
                             }
                            }
                        Spacer()
                            
                        }
                    
                
                  
                    
                }.edgesIgnoringSafeArea(.all)
            }.onAppear{
                //            print(story_Questions_List ?? "")
                GetStories()
                //        }
            }.environment(\.horizontalSizeClass, .compact)
            
        }
        
        
        
        
        func GetStories(){
            //        https://kayanapp.ibtikar-soft.sa/api/Story/GetStories/2
            print( Connection().getUrl(word: "GetComingSoonStories"))
            //        RestAPI().getData(endUrl: Connection().getUrl(word: "GetStories")+"\(id)", parameters: [:])
            RestAPI().getData(endUrl: Connection().getUrl(word: "GetComingSoonStories"), parameters: [:]){ result in
                
                let sectionR = JSON(result!)
                print(sectionR)
                if sectionR["responseCode"].int == 200{
                    let jsonDatas = try! JSONEncoder().encode(sectionR["response"])
                    let users = try! JSONDecoder().decode([StroryModal].self, from: jsonDatas)
                    if users.count > 0{
                  
                    
                    stories=users

                }
                }
                
            } onError: { error in
                print(error)
            }
        }
        
        
    }

