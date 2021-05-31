//
//  Stories.swift
//  Kayan
//
//  Created by Sandal on 08/10/1442 AH.
//

import SwiftUI
import SwiftyJSON

var selectd_story_page_MenuID:Int=0
struct Stories: View {
    @State var id:Int=0
    @State var selected_id=3
    @State var title:String=""
    var imageName=["quran","meditation","childrenStory"]
    var storyName=["قصص براعم","قصص الابطال","قصص القادة"]
    var storyAge=["5-3","8-6","9-12"]
    @State var is_go_to_story_page:Bool=false
    @Environment(\.presentationMode) var presentation
    var horizontalPaddig:CGFloat=30.0
    @Environment(\.presentationMode) var presentationModeEdit: Binding<PresentationMode>
    @State var stories:[StroryModal]=[]
    ////////////
    @State  var BackagePosition:[CGFloat]=[]
    @State  var BackageHight:[CGFloat]=[]
    @State private var CardIndecator=0//max number of item
    
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
                            if stories.count > 0 {
                                HStack{
                                    Rectangle().fill(Color.AppPrimaryColor).frame(width: 100, height: 30, alignment: .center).cornerRadius(20, corners: [.topRight, .bottomRight]).overlay(
                                        HStack{
                                            Spacer()
                                            Text("هدايا").foregroundColor(.white).fontWeight(.bold).font(.system(size: 14))
                                            Spacer()
                                        }
                                    )
                                    
                                    Spacer()
                                    
                                    Rectangle().fill(Color.AppPrimaryColor).frame(width: 100, height: 30, alignment: .center).cornerRadius(20, corners: [.topLeft, .bottomLeft]).overlay(
                                        HStack{
                                            Spacer()
                                            Text("قريبا").foregroundColor(.white).fontWeight(.bold).font(.system(size: 14))
                                            Spacer()
                                        }
                                    )
                                }
                             
                                ZStack(alignment: .center){
                                    ForEach(0...stories.count-1,id:\.self){ index in
                                        VStack{
                                            
                                        
                                        Stories_Card_Cards(imageName:stories[index],BackageHight: $BackageHight[index],width: UIScreen.screenWidth*0.4,title: $title, selectdMenuID: $id, isSignIn: $is_go_to_story_page).padding(.horizontal,30)
                                            .contentShape(Rectangle())
                                            
                                            .offset(x:BackagePosition[index])
                                            .gesture(
                                                DragGesture()
                                                    .onChanged(
                                                        { (value) in
                                                            if value.translation.width > -50 {//&&                        self.BackagePosition[self.CardIndecator] == BackagePosition[index]  && BackagePosition.count > CardIndecator+1 {//swib left
                                                            
                                                            
                                                                withAnimation(.easeIn(duration: 0.5)) {
//                                                                    moveLeft()
//                                                                BackagePosition.map { $0 + 200 }
                                                                    self.BackagePosition[self.CardIndecator] = value.translation.width
                                                                }
                                                            
//                                                            print("curent \(value.translation.width)")
                                                        }
                                                            else if value.translation.width > 100 {//&&                        self.BackagePosition[self.CardIndecator] == BackagePosition[index]  && BackagePosition.count > CardIndecator-1 {
                                                            
//                                                            self.BackagePosition[self.CardIndecator] = value.translation.width
//                                                            print("+ \(value.translation.width)")
                                                            
                                                        }
                                                    }).onEnded({ (value) in
                                                        if value.translation.width < 0{
                                                            
                                                            if value.translation.width < -100{
                                                                
                                                              //                                                                BackagePosition.map { $0 + 200 }
                                                                                   moveLeft()
                                                            }
                                                                
                                                            
                                                        
                                                            else{
                                                                resetView()
                                                            }
                                                        }
                                                        else if value.translation.width > 0{
                                                            
                                                            if value.translation.width > 100{
                                                                moveRight()
                                                            }
                                                            else{
                                                                resetView()
                                                            }
                                                        }
                                                    })
                                                
                                            )
                                            if self.BackagePosition[self.CardIndecator] == BackagePosition[index]{
                                                HStack(spacing:10){
                                               Spacer()
                                                    if !stories[index].isPaid!{
                                                        Rectangle().fill(Color.AppPrimaryColor).frame(width: 100, height: 30, alignment: .center).cornerRadius(20, corners: [.bottomLeft, .bottomRight]).overlay(
                                                            HStack{
                                                                Spacer()
                                                                Text("شراء الأن").foregroundColor(.Appliver).fontWeight(.bold).font(.system(size: 14))
                                                                Spacer()
                                                            }
                                                        )
                                                        Rectangle().fill(Color.orange).frame(width: 70, height: 30, alignment: .center).cornerRadius(20, corners: [.bottomLeft,.bottomRight]).overlay(
                                                    VStack{
                                                        Spacer()
                                                        Text("مدفوع").foregroundColor(.white).fontWeight(.heavy).font(.system(size: 14))
                                                        
                                                        Text("$\(stories[index].subscribePrice!)").foregroundColor(.white).fontWeight(.bold).font(.system(size: 13))
                                                        Spacer()
                                                    }
                                                )
                                                    }
                                                    else{
//                                                        Spacer()
                                                        Rectangle().fill(Color.green).cornerRadius(20, corners: [.bottomLeft,.bottomRight]).overlay(
                                                    VStack{
                                                        Spacer()
                                                        Text("مجانية").foregroundColor(.white).fontWeight(.bold).font(.system(size: 12)).frame(width:50,height:10).padding(.top,3)
//                                                        Spacer()
                                                        Image(systemName:"gift").font(.system(size: 12, weight: .heavy)).foregroundColor(Color(#colorLiteral(red: 0.996468246, green: 0.6681806445, blue: 0.001119376859, alpha: 1))).frame(width:20,height:10).padding(.vertical,3)
                                                        Spacer()
                                                    }//.frame(width:50,height:34)
                                                        ).frame(width:50,height:44)
                                                    }
                                                }.frame(width:170).offset(x:30,y:-kkkkk)
                                                .opacity(kkkkkdsds)
                                                .onAppear{
                                                    print("dsds")
                                                    kkkkkdsds=0
                                                    kkkkk=0
//                                                    kkkkkd=0
                                                    withAnimation(.easeIn(duration: 2)) {
                                                        kkkkk+=8
                                                    }
                                                    withAnimation(.easeIn(duration: 2)) {
                                                        kkkkkdsds=0.9
                                                    }
                                                }
                                            }
                                    }
                                        
                                    }
                                }.ignoresSafeArea(.all)
                            }
                        }
                        
                    }
                }
            }.edgesIgnoringSafeArea(.all)
            .fullScreenCover(isPresented:  self.$is_go_to_story_page ){
                StoryPage( audioRecorder: AudioRecorder(), page_story_id: selectd_story_page_MenuID)
            }
            
        }.onAppear{
            //            print(id)
            GetStories()
            //        }
        }.environment(\.horizontalSizeClass, .compact)
       
    }
    func resetView(){
        BackageHight[CardIndecator]=UIScreen.screenHeight*0.5
        BackagePosition[CardIndecator] = 0//(UIScreen.screenWidth/2)
    }
    func moveLeft(){
        kkkkkdsds=0
        withAnimation(.easeIn(duration: 0.8)) {//1.5
                                                                          
        BackageHight[CardIndecator] =   CGFloat(UIScreen.screenHeight*0.4)
        BackagePosition[CardIndecator] = -(UIScreen.screenWidth*0.4)-50
        
        CardIndecator = stories.count > CardIndecator+1 ? CardIndecator+1 : 0
        
        BackagePosition[CardIndecator] = 0
        BackageHight[CardIndecator] =   UIScreen.screenHeight*0.5
        }
        
        if stories.count > CardIndecator+1{
            BackagePosition[CardIndecator+1] = (UIScreen.screenWidth*0.4)+50
        }
        else{
            if stories.count > 1{
                BackagePosition[0] = (UIScreen.screenWidth*0.4)+50
            }
        }
        
//
        
    }
    func moveRight(){
        
        BackageHight[CardIndecator] =   CGFloat(UIScreen.screenHeight*0.4)
        BackagePosition[CardIndecator] = (UIScreen.screenWidth*0.4)+50
        
//
        CardIndecator = CardIndecator-1 > 0  ? CardIndecator-1 : stories.count-1
//////
        BackagePosition[CardIndecator] = 0
        BackageHight[CardIndecator] =   UIScreen.screenHeight*0.5
//
//
        if CardIndecator-1 > 0  {
            BackagePosition[CardIndecator-1] = -(UIScreen.screenWidth*0.4)-50
        }
        else{
            if CardIndecator-1 < 1{
                BackagePosition[0] = -(UIScreen.screenWidth*0.4)-50
            }
        }
    }
    func add_story_to_favorit(story_id:Int){
        
        let prams = ["CustomerID":VarUserDefault.SysGlobalData.getGlobalInt(key: VarUserDefault.SysGlobalData.userId),"StoryID":story_id]
        print( Connection().getUrl(word: "AddToFavourite")+"\(story_id)")
        print(prams)
        RestAPI().postData(endUrl: Connection().getUrl(word: "AddToFavourite"), parameters: prams){ result in
            
            let sectionR = JSON(result!)
            print(sectionR)
            if sectionR["responseCode"].int == 200{
                print(sectionR["response"])
                //                let jsonDatas = try! JSONEncoder().encode(sectionR["response"])
                //                let menus = try! JSONDecoder().decode([StroryModal].self, from: jsonDatas)
                //                stories=menus
                ////                print(stories)
            }
        } onError: { error in
            print(error)
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
                let menus = try! JSONDecoder().decode([StroryModal].self, from: jsonDatas)
                
                BackagePosition=Array(repeating: CGFloat(UIScreen.screenWidth+200), count: (menus.count))

                    BackageHight=Array(repeating:CGFloat(UIScreen.screenHeight*0.4), count: (menus.count))
                stories=menus
                CardIndecator=0
                if stories.count > 0 {
                    
                    print((UIScreen.screenWidth*0.4/2))
                    
                    if stories.count > 2{
                        BackagePosition[CardIndecator+1] = (UIScreen.screenWidth*0.4)+50
                        BackagePosition[stories.count-1] = -(UIScreen.screenWidth*0.4)-50
                    }
                    
                    BackageHight[0]=UIScreen.screenHeight*0.5
                    BackagePosition[0] = 0//(UIScreen.screenWidth/2)
                }
            }
        } onError: { error in
            print(error)
        }
        
    }
}
extension UIScreen{
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenSize = UIScreen.main.bounds.size
}
