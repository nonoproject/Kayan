//
//  SandalStoryV2View.swift
//  Kayan
//
//  Created by Sandal on 09/11/1442 AH.
//

import SwiftUI
import SwiftyJSON
struct SandalStoryV2View: View {
    @State var id:Int=0
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
    
    @State var kkkkkdsds:Double=0
    @State var kkkkk:CGFloat=0
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
                                            Spacer()
                                        }
                                    )
                                }.padding(.top,20)
                            
                                Spacer()
                            if stories.count > 0 {
                                ZStack(alignment: .center){
                                    ForEach(0...stories.count-1,id:\.self){ index in
                                        VStack{
//                                            if self.BackagePosition[self.CardIndecator] == BackagePosition[index]{
////                                            HStack{
////                                                Spacer()
////                                                Image("Play_test_Sound").resizable().padding(5).frame(width: 32, height: 32)
////                                                    //.background(Color.Appliver).foregroundColor(.white).cornerRadius(5).rotationEffect(Angle(degrees: 180))
////                                                    .onTapGesture {
////
//////                                                    view_story_to_supscription_binding=false
////                                                }.offset(x: -5, y: -20)
////                                            }
//                                            }
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
                                                HStack(spacing:10){
                                               Spacer()
                                                    if stories[index].isPaid!{
                                                        if !stories[index].isSubscribed!{
//                                                        Rectangle().fill(Color.AppPrimaryColor).frame(width: 100, height: 30, alignment: .center).cornerRadius(20, corners: [.bottomLeft, .bottomRight]).overlay(
//                                                            HStack{
//                                                                Spacer()
//                                                                Text("شراء الأن").foregroundColor(.Appliver).fontWeight(.bold).font(.system(size: 14))
//
//                                                                Spacer()
//                                                            }
//                                                        )//.onTapGesture {
//                                                            add_story_to_supscription(story_id:stories[index].id)
//                                                        }
                                                            Image("free_story").resizable().frame(width: 70, height: 50).overlay(
                                                    VStack{
                                                        Spacer()
                                                        Text("مدفوع").foregroundColor(.white).fontWeight(.heavy).font(.system(size: 12))
                                                        
                                                        Text("$\(stories[index].subscribePrice!)").foregroundColor(.white).fontWeight(.bold).font(.system(size: 11))
                                                        Spacer()
                                                    }.padding()
                                                )
                                                    }
                                                    }
                                                    else{
//                                                        Spacer()
                                                        Image("payed_story").resizable().frame(width: 70, height: 50).overlay(
                                                    VStack{
                                                        Spacer()
                                                        Text("مجانية").foregroundColor(.white).fontWeight(.bold).font(.system(size: 12)).frame(width:50,height:10).padding(.top,3)
//                                                        Spacer()
                                                        Image(systemName:"gift").font(.system(size: 12, weight: .heavy)).foregroundColor(Color(#colorLiteral(red: 0.996468246, green: 0.6681806445, blue: 0.001119376859, alpha: 1))).frame(width:20,height:10).padding(.vertical,3)
                                                        Spacer()
                                                    }//.frame(width:50,height:34)
                                                        )
                                                    }
                                                }.frame(width:170).offset(x:30,y:-kkkkk)
                                                .opacity(kkkkkdsds)
                                                .onAppear{
                                                    print("dsds")
                                                    kkkkkdsds=0
                                                    kkkkk=0
//                                                    kkkkkd=0
                                                    withAnimation(.easeIn(duration: 0.5)) {
                                                        kkkkk+=8
                                                    }
                                                    withAnimation(.easeIn(duration: 1)) {
                                                        kkkkkdsds=0.9
                                                    }
                                                }
                                            }
                                        }
                                        
                                    }
                                }.ignoresSafeArea(.all)
                                Spacer()
                            }
                        }
                        
                    }
                }
            
              if  add_story_to_supscription_binding && !show_pay_modal{
                Pay_story(story: stories[CardIndecator], view_story_to_supscription_binding: $add_story_to_supscription_binding,show_pay_modal:$show_pay_modal)//,story_pay_url:$story_pay_url)
//                Pay_story(view_story_to_supscription_binding:,story:)
              }
                if show_pay_modal{
                    ZStack(alignment: .top){
                        HStack{
                        Image("close_button").resizable().padding(5).frame(width: 50, height: 40)
                            //.background(Color.Appliver).foregroundColor(.white).cornerRadius(5).rotationEffect(Angle(degrees: 180))
                            .onTapGesture {
                                                               
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
        kkkkkdsds=0
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
        
        kkkkkdsds=0
//        withAnimation(.easeIn(duration: 0.5)) {//1.5
            
            BackageHight[CardIndecator] =   CGFloat(UIScreen.screenHeight*0.4)
            BackagePosition[CardIndecator] = (UIScreen.screenWidth*0.4)+50
            
            CardIndecator -= 1
            
            BackagePosition[CardIndecator] = 0
            BackageHight[CardIndecator] =   UIScreen.screenHeight*0.5
//        }
        for i in 1...stories.count-1{
                    if i != CardIndecator{5
                        if i > CardIndecator{
                            BackagePosition[i]=BackagePosition[i-1]+(UIScreen.screenWidth*0.4)+50
                        }
                        else{
                            BackagePosition[i] = -BackagePosition[CardIndecator-i]-(UIScreen.screenWidth*0.4)-50
                        }
                        BackageHight[i]=UIScreen.screenHeight*0.4
                    }
            
        }
//        for i in 0...CardIndecator{
//
//
//        }
        
//        if CardIndecator-1 >  0{
//            BackagePosition[CardIndecator-1] = -(UIScreen.screenWidth*0.4)-50
//        }
//        else{
//            BackagePosition[(stories.count - 1 - CardIndecator)] = -(UIScreen.screenWidth*0.4)-50
//        }
        
        //
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
