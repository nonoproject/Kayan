//
//  Stories.swift
//  Kayan
//
//  Created by Awad sandal on 31/03/2021.
//

import SwiftUI
import SwiftyJSON
struct StoriesSection: View {
    @State var id=3
    @State var section_title:String=""
    @State var title:String=""
    @State var url_play_vedio:String=""
    @State var ther_are_no_data = false
    var imageName=["quran","meditation","childrenStory"]
    var storyName=["قصص براعم","قصص الابطال","قصص القادة"]
    var storyAge=["5-3","8-6","9-12"]
    @State var isSignIn = false
        @State var is_play_vedio = false
    @State var is_going_to_gift = false
    
    
//    @Environment(\.presentationMode) var presentation
    var horizontalPaddig:CGFloat=30.0
//    @Environment(\.presentationMode) var presentationModeEdit: Binding<PresentationMode>
    @State var stories:[StoriesModal]=[]
    
    @State var clibs:[ClibModal]=[]
    @State var selectdMenuID:Int = 0
    var body: some View {
        ZStack{
        VStack(spacing:0){
            Navbars(x_view_to_move:AnyView(Home()), page_titel: section_title)
                ZStack{
                    LinearGradient(gradient: Gradient(colors: [Color.init(hex: "FCF1EF"), Color.init(hex: "BE9ECB"),Color.init(hex:"5461A7")]), startPoint: .topTrailing, endPoint: .bottomLeading)
                           .edgesIgnoringSafeArea(.vertical)
                    
                    VStack(spacing:0){
                        
                        NavigationLink(destination: SandalStoryV2View(selected_id:selectdMenuID,title: title).navigationBarTitle(Text("Home"))
                                .navigationBarHidden(true), isActive: self.$isSignIn) {}.hidden()
                        
                        NavigationLink(destination: GiftStory(selected_id:selectdMenuID,title: "الهدايا").navigationBarTitle(Text("Home"))
                                .navigationBarHidden(true), isActive: self.$is_going_to_gift) {}.hidden()

                        
                        NavigationLink(destination:PlayRelacsation(url_play_vedio:url_play_vedio).navigationBarTitle(Text("Home"))
                                .navigationBarHidden(true), isActive: self.$is_play_vedio) {}.hidden()

                HStack{
                    Rectangle().fill(Color.AppSecoundryColor).frame(width: 100, height: 40, alignment: .center).cornerRadius(20, corners: [.topRight, .bottomRight]).overlay(
                        HStack{
                            Spacer()
                            Text("الهدايا").foregroundColor(.white).fontWeight(.heavy).font(.system(size: 14))
                            Spacer()
                        }
                    ).onTapGesture {
                        is_going_to_gift=true
                    }
                    
                    Spacer()
                    
                    Rectangle().fill(Color(#colorLiteral(red: 0.9551857114, green: 0.8471567035, blue: 0.8317700028, alpha: 1))).frame(width: 100, height: 40, alignment: .center).cornerRadius(20, corners: [.topLeft, .bottomLeft]).overlay(
                        HStack{
                            Spacer()
                            Text("قريبا").foregroundColor(.white).fontWeight(.heavy).font(.system(size: 14))
                            Spacer()
                        }
                    ).hidden()
                }.padding(.top,10)
                .padding(.vertical,5)
                        if stories.count > 0 {
                            VStack{
                                Spacer()
                                
                            HStack{
                                ScrollView(.horizontal, showsIndicators: false){
                                HStack(spacing:45){
                                    ForEach(enumerating: stories,id:\.id){ index,arg  in
                                        
                                        Story_group_section(storyName:arg,title: $title, selectdMenuID: $selectdMenuID, isSignIn: $isSignIn).onAppear{
                                            print(arg)
                                        }
                                    }
                                }.padding(20)
                                }
                                .flipsForRightToLeftLayoutDirection(true)
                                .environment(\.layoutDirection, .rightToLeft)
                }//.padding(.horizontal,30)
                                
                                Spacer()
                            }
    //                        }
                        }
                       else if clibs.count > 0{
                            VStack{
                                Spacer()
                                HStack{
                                    ScrollView(.horizontal, showsIndicators: false){
                                    HStack(spacing:45){
                                        ForEach(enumerating: clibs,id:\.id){ index,arg  in
                                            
                                            clips_group_section(storyName:arg,title: $title, selectdMenuID: $selectdMenuID, is_play_vedio: $is_play_vedio, url_play_vedio: $url_play_vedio).onAppear{
                                                print(arg)
                                            }
                                        }
                                    }.padding(20)
                                    }
                    }.padding(.horizontal,30)

                                Spacer()
                            }
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
    //    }
            }.onAppear{
                print(id)
                if id == 1{
                    GetStories()
                }
                else{
                    GetClibs()
                }
                
    //        }
            }//.environment(\.horizontalSizeClass, .compact)
        }
            
        }.edgesIgnoringSafeArea(.all)
        
    }
    func GetClibs(){
        print(Connection().getUrl(word: "GetClibs"))
//        RestAPI().getData(endUrl: Connection().getUrl(word: "GetStories")+"\(id)", parameters: [:])
        RestAPI().getData(endUrl: Connection().getUrl(word: "GetClibs")+"\(id)", parameters: [:]){ result in
            
           let sectionR = JSON(result!)
            print(sectionR)
            if sectionR["responseCode"].int == 200{
                let jsonDatas = try! JSONEncoder().encode(sectionR["response"])
                let menus = try! JSONDecoder().decode([ClibModal].self, from: jsonDatas)
//                stories=menus
                clibs=menus
//                print(stories)
            }
        } onError: { error in
            print(error)
        }
        
    }
    func GetStories(){
        print(Connection().getUrl(word: "GetStoryCatogries"))
//        RestAPI().getData(endUrl: Connection().getUrl(word: "GetStories")+"\(id)", parameters: [:])
        RestAPI().getData(endUrl: Connection().getUrl(word: "GetStoryCatogries"), parameters: [:]){ result in
            
           let sectionR = JSON(result!)
            print(sectionR)
            if sectionR["responseCode"].int == 200{
                let jsonDatas = try! JSONEncoder().encode(sectionR["response"])
                let menus = try! JSONDecoder().decode([StoriesModal].self, from: jsonDatas)
                stories=menus
//                print(stories)
            }
        } onError: { error in
            print(error)
        }
        
    }
}
