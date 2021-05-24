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
//    @Environment(\.presentationMode) var presentation
    var horizontalPaddig:CGFloat=30.0
//    @Environment(\.presentationMode) var presentationModeEdit: Binding<PresentationMode>
    @State var stories:[StoriesModal]=[]
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


                        if stories.count > 0 {
                HStack{
                    Rectangle().fill(Color.AppSecoundryColor).frame(width: 100, height: 30, alignment: .center).cornerRadius(20, corners: [.topRight, .bottomRight]).overlay(
                        HStack{
                            Spacer()
                            Text("هدايا").foregroundColor(.black).fontWeight(.bold).font(.system(size: 14))
                                
                            
                            Spacer()
                        }
                    )
                    
                    Spacer()
                    
                    Rectangle().fill(Color.AppPrimaryColor).frame(width: 100, height: 30, alignment: .center).cornerRadius(20, corners: [.topLeft, .bottomLeft]).overlay(
                        HStack{
                            Spacer()
                            Text("قريبا").foregroundColor(.black).fontWeight(.bold).font(.system(size: 14))
                            Spacer()
                        }
                    )
                }.padding(.vertical,5)
                            HStack{
                                ScrollView(.horizontal, showsIndicators: false){
                                HStack(spacing:45){
                                    ForEach(0...stories.count-1,id:\.self){ index in
                                        
                                        Story_group_section(imageName:imageName[index],storyName:stories[index].name, storyID: stories[index].id, typeID: id,storyAge: "\(stories[index].ageFrom)-\(stories[index].ageTo)",title: $title, selectdMenuID: $selectdMenuID, isSignIn: $isSignIn,isStory:false)
                                    }
                                }.padding(20)
                                }
                }.padding(.horizontal,30)
    //                        }
                        }
                        Spacer()
            }
    //    }
            }.onAppear{
                print(id)
                GetStories()
    //        }
            }.environment(\.horizontalSizeClass, .compact)
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
