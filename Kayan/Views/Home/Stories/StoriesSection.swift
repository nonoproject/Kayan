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
    
    var imageName=["quran","meditation","childrenStory"]
    var storyName=["قصص براعم","قصص الابطال","قصص القادة"]
    var storyAge=["5-3","8-6","9-12"]
    @State var isSignIn = false
        @State var is_play_vedio = false
    
//    @Environment(\.presentationMode) var presentation
    var horizontalPaddig:CGFloat=30.0
//    @Environment(\.presentationMode) var presentationModeEdit: Binding<PresentationMode>
    @State var stories:[StoriesModal]=[]
    
    @State var clibs:[ClibModal]=[]
    @State var selectdMenuID:Int = 0
    var body: some View {
//        NavigationView{
//        GeometryReader{geo in
        VStack(spacing:0){
            Navbars(x_view_to_move:AnyView(Home()), page_titel: section_title)
                ZStack{
                    LinearGradient(gradient: Gradient(colors: [Color.init(hex: "FCF1EF"), Color.init(hex: "BE9ECB"),Color.init(hex:"5461A7")]), startPoint: .topTrailing, endPoint: .bottomLeading)
                           .edgesIgnoringSafeArea(.vertical)
                    
                    VStack(spacing:0){
                        NavigationLink(destination: Stories(selected_id:selectdMenuID,title: title).navigationBarTitle(Text("Home"))
                                .navigationBarHidden(true), isActive: self.$isSignIn) {}.hidden()
//                        NavigationLink(destination: PlayVedio(selected_url:selectdMenuID,title: title).navigationBarTitle(Text("Home"))
//                                .navigationBarHidden(true), isActive: self.$isSignIn) {}.hidden()
                        NavigationLink(destination:PlayRelacsation().navigationBarTitle(Text("Home"))
                                .navigationBarHidden(true), isActive: self.$is_play_vedio) {}.hidden()

                        if stories.count > 0 {
                HStack{
                    Rectangle().fill(Color.AppSecoundryColor).frame(width: 100, height: 30, alignment: .center).cornerRadius(20, corners: [.topRight, .bottomRight]).overlay(
                        HStack{
                            Spacer()
                            Text("هدايا").foregroundColor(.black).fontWeight(.heavy).font(.system(size: 14))
                                
                            
                            Spacer()
                        }
                    )
                    
                    Spacer()
                    
                    Rectangle().fill(Color.AppPrimaryColor).frame(width: 100, height: 30, alignment: .center).cornerRadius(20, corners: [.topLeft, .bottomLeft]).overlay(
                        HStack{
                            Spacer()
                            Text("قريبا").foregroundColor(.black).fontWeight(.heavy).font(.system(size: 14))
                            Spacer()
                        }
                    )
                }.padding(.vertical,5)
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
                }.padding(.horizontal,30)
    //                        }
                        }
                        if clibs.count > 0{
                            VStack{
                                Spacer()
                                HStack{
                                    ScrollView(.horizontal, showsIndicators: false){
                                    HStack(spacing:45){
                                        ForEach(enumerating: clibs,id:\.id){ index,arg  in
                                            
                                            clips_group_section(storyName:arg,title: $title, selectdMenuID: $selectdMenuID, is_play_vedio: $is_play_vedio).onAppear{
                                                print(arg)
                                            }
                                        }
                                    }.padding(20)
                                    }
                    }.padding(.horizontal,30)

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
            }.environment(\.horizontalSizeClass, .compact)
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
