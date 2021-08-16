//
//  SandalStoryV2View.swift
//  Kayan
//
//  Created by Sandal on 09/11/1442 AH.
//

import SwiftUI
import SwiftyJSON
struct SandalStoryV2View: View {
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
                
                VStack( spacing: 0){
                    
                    Navbars(page_titel: title)
                    ZStack{
                        LinearGradient(gradient: Gradient(colors: [Color.init(hex: "FCF1EF"), Color.init(hex: "BE9ECB"),Color.init(hex:"5461A7")]), startPoint: .topTrailing, endPoint: .bottomLeading)
                            .edgesIgnoringSafeArea(.vertical)
                        
                        VStack(spacing:0){
                            
                                HStack{
                                    
                                    Image(systemName: "play.fill").resizable().frame(width: 22, height: 22).background(Color.Appliver).foregroundColor(.white).cornerRadius(5).rotationEffect(Angle(degrees: 180)).onTapGesture {
                                        self.presentationModeEdit.wrappedValue.dismiss()
                                    }.padding(.leading,5)
                                    Spacer()
                                    
                                    Rectangle().fill(Color.AppPrimaryColor).frame(width: 100, height: 30, alignment: .center).cornerRadius(20, corners: [.topLeft, .bottomLeft]).overlay(
                                        HStack{
                                            Spacer()
                                            Text("قريبا").foregroundColor(.white).fontWeight(.bold).font(.system(size: 14))
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
                                            Spacer()
                                        }
                                    )
                                }.padding(.top,20)
                            
                                Spacer()
                            
                            
                                    
                            if stories.count > 0 {
                                ZStack(alignment: .center){
                                    ForEach(0...stories.count-1,id:\.self){ index in
                                        VStack{
                                            Stories_Card_Cards(imageName:stories[index],BackageHight: $BackageHight[index],width: UIScreen.screenWidth*0.4,title: $title, selectdMenuID: $id, isSignIn: $is_go_to_story_page,add_story_to_supscription_binding:$add_story_to_supscription_binding).padding(.horizontal,30)
                                                .contentShape(Rectangle())
                                                .offset(x:BackagePosition[index])
                                                .gesture(
                                                    DragGesture()
                                                        .onChanged(
                                                            { (value) in
                                                                if value.translation.width > 0 {
                                                                    if self.CardIndecator-1 >= 0{
                                                                        self.BackagePosition[self.CardIndecator] = value.translation.width
                                                                        BackagePosition[self.CardIndecator-1]=value.translation.width-(UIScreen.screenWidth*0.4)-50
                                                                        
                                                                        
                                                                    }
                                                                }
                                                                else if value.translation.width < 0{
                                                                    if self.CardIndecator+1 < BackagePosition.count {
                                                                        self.BackagePosition[self.CardIndecator] = value.translation.width
                                                                        BackagePosition[self.CardIndecator+1]=value.translation.width+(UIScreen.screenWidth*0.4)+50
                                                                        
                                                                        
                                                                    }
                                                                    
                                                                }
                                                                
                                                            }).onEnded({ (value) in
                                                                if value.translation.width < 0{
                                                                    if value.translation.width < -40 && self.CardIndecator+1 < BackagePosition.count{
                                                                        moveRight()
                                                                    }
                                                                    else{
                                                                        if self.CardIndecator-1 >= 0{
                                                                        resetView(direction:2)
                                                                        }
                                                                    }
                                                                }
                                                                else if value.translation.width > 0{
                                                                    
                                                                    if value.translation.width > 40 &&  self.CardIndecator-1 >= 0 {
                                                                        moveLeft()
                                                                    }
                                                                    else{
                                                                        if self.CardIndecator+1 < BackagePosition.count {

                                                                        resetView()
                                                                        }
                                                                    }
                                                                }
                                                            })
                                                    
                                                )
                                            if self.BackagePosition[self.CardIndecator] == BackagePosition[index]{
//                                                StoriesTail(isPaid: , isSubscribed: stories[CardIndecator].isSubscribed)
                                                StoriesTail(isPaid: stories[CardIndecator].isPaid!, isSubscribed: stories[CardIndecator].isSubscribed!)
//                                                free_payed_view(isPaid: stories[CardIndecator].isPaid!, subscribePrice: stories[CardIndecator].subscribePrice!, offsetY: 0, ViewOpacity: 0, isSubscribed: stories[CardIndecator].isSubscribed!)
                                            }
                                        }
                                        
                                    }
                                }.ignoresSafeArea(.all)
                                Spacer()
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
                        }
                        
                    }
                }
            
                if  add_story_to_supscription_binding {//|| !show_pay_modal{
                Pay_story(story: stories[CardIndecator], view_story_to_supscription_binding: $add_story_to_supscription_binding,show_pay_modal:$show_pay_modal)//,story_pay_url:$story_pay_url)
//                Pay_story(view_story_to_supscription_binding:,story:)
              }
                if show_pay_modal{
                    ZStack(alignment: .top){
                        HStack{
                        Image("close_button").resizable().padding(5).frame(width: 50, height: 40)
                            .onTapGesture {
                                add_story_to_supscription_binding=false
                                show_pay_modal=false
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
            }.edgesIgnoringSafeArea(.all)
            .fullScreenCover(isPresented:  self.$is_go_to_story_page ){
                StoryPage( audioRecorder: AudioRecorder(), page_story_id: selectd_story_page_MenuID,storyQuestionsList:story_Questions_List)//,storyQuestionsList:storyQuestionsList)
            }
//            .fullScreenCover(isPresented:  self.$add_story_to_supscription_binding ){
//                Rate(page_story_id:3)
//                print(stories[CardIndecator])
//                Pay_story(story:stories[CardIndecator])
//            }
            
        }.onAppear{
            //            print(story_Questions_List ?? "")
            GetStories()
            //        }
        }.environment(\.horizontalSizeClass, .compact)
        
    }
    func resetViewData(){
        add_story_to_supscription_binding=false
        show_pay_modal=false
//        is_payment_succesrlse
        is_payment_success = false
//        CardIndecator=0
//        stories=[]
//        BackagePosition=[]//.removeAll()
//        BackageHight=[]//.removeAll()
        //.removeAll()
//        let seconds = .0
//        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
        GetStories()
//        }
        
    }
    func resetView(direction:Int?=1){
        BackageHight[CardIndecator]=UIScreen.screenHeight*0.5
        BackagePosition[CardIndecator] = 0//(UIScreen.screenWidth/2)
        if direction == 1{
            if   self.CardIndecator-1 >= 0{
            BackageHight[CardIndecator-1] = CGFloat(UIScreen.screenHeight*0.4)
            BackagePosition[CardIndecator-1] =  -(UIScreen.screenWidth*0.4)-50
            }
        }
        else{
            if  self.CardIndecator+1 < BackagePosition.count{
            BackageHight[CardIndecator+1] = CGFloat(UIScreen.screenHeight*0.4)
            BackagePosition[CardIndecator+1] = (UIScreen.screenWidth*0.4)+50
            }
        }
        
    }
    func moveRight(){
//        kkkkkdsds=0
//        withAnimation(.easeIn(duration: 0.5)) {//1.5
            
            BackageHight[CardIndecator] =   CGFloat(UIScreen.screenHeight*0.4)
            BackagePosition[CardIndecator] = -(UIScreen.screenWidth*0.4)-50
            
            CardIndecator =  CardIndecator+1
            
            BackagePosition[CardIndecator] = 0
            BackageHight[CardIndecator] =   UIScreen.screenHeight*0.5
//        }
        for i in CardIndecator...stories.count-1{
                   BackagePosition[i] = BackagePosition[i-1]+(UIScreen.screenWidth*0.4)+50
            
        }
//
//        if stories.count > CardIndecator+1{
//            BackagePosition[CardIndecator+1] = (UIScreen.screenWidth*0.4)+50
//        }
        
    }
    func moveLeft(){
        
//        kkkkkdsds=0
//        withAnimation(.easeIn(duration: 0.5)) {//1.5
            
            BackageHight[CardIndecator] =   CGFloat(UIScreen.screenHeight*0.4)
            BackagePosition[CardIndecator] = (UIScreen.screenWidth*0.4)+50
            
            CardIndecator -= 1
            
            BackagePosition[CardIndecator] = 0
            BackageHight[CardIndecator] =   UIScreen.screenHeight*0.5
//        }
        for i in 1...stories.count-1{
                    if i != CardIndecator{
                        if i > CardIndecator{
                            BackagePosition[i]=BackagePosition[i-1]+(UIScreen.screenWidth*0.4)+50
                        }
                        else{
                            BackagePosition[i] = -BackagePosition[CardIndecator-i]-(UIScreen.screenWidth*0.4)-50
                        }
                        BackageHight[i]=UIScreen.screenHeight*0.4
                    }
            
        }
    }
    func GetStories(){
        //        https://kayanapp.ibtikar-soft.sa/api/Story/GetStories/2
        print( Connection().getUrl(word: "GetStories")+"\(selected_id)")
        //        RestAPI().getData(endUrl: Connection().getUrl(word: "GetStories")+"\(id)", parameters: [:])
        RestAPI().getData(endUrl: Connection().getUrl(word: "GetStories")+"\(selected_id)/\(VarUserDefault.SysGlobalData.getGlobalInt(key: VarUserDefault.SysGlobalData.userId))", parameters: [:]){ result in
            
            let sectionR = JSON(result!)
            print(sectionR)
            if sectionR["responseCode"].int == 200{
                let jsonDatas = try! JSONEncoder().encode(sectionR["response"])
                let users = try! JSONDecoder().decode([StroryModal].self, from: jsonDatas)
                if users.count > 0{
                var menus=users.sorted  {
                    $0.isPaid!  &&  $1.isPaid!
                }
                print(menus)
                print("-----")
                print(menus.reverse())
                
                
                BackagePosition=Array(repeating: 0, count: (menus.count))
                BackageHight=Array(repeating:0, count: (menus.count))
                
                BackagePosition[CardIndecator]=0
                BackageHight[CardIndecator]=UIScreen.screenHeight*0.5//UIScreen.screenHeight*0.6
                
                CardIndecator=0
                
                stories=menus
                for i in 1...menus.count-1{
//                    if i != CardIndecator{
//                        if i > CardIndecator{
                            BackagePosition[i]=BackagePosition[i-1]+(UIScreen.screenWidth*0.4)+50
//                        }
//                        else{
//                            BackagePosition[i]=BackagePosition[i+1]-(UIScreen.screenWidth*0.4)-50
//                        }
                        BackageHight[i]=UIScreen.screenHeight*0.4
//                    }
                    
                }
                
            }
            }
            
        } onError: { error in
            print(error)
        }
    }
    
    
}

