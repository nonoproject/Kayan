//
//  Home.swift
//  Kayan
//
//  Created by Awad sandal on 30/03/2021.
//

import SwiftUI
import SwiftyJSON
import SwiftUIX
import Combine
struct Home: View {
    var imageName=["childrenStory","meditation","quran"]
    var storyName=["تلاوة قرآنية","مقاطع إسترخاء","قصص"]
    @State var isSignIn = false
    @State var title = ""
    @State var menue:[MenueModal]=[]
    @State var selectdMenuID:Int = 0
    var body: some View {
        NavigationView{
            GeometryReader{geo in
                    NavigationLink(destination: StoriesSection(id: selectdMenuID, section_title: title).navigationBarTitle(Text("Home"))
                            .navigationBarHidden(true), isActive: self.$isSignIn) {}.hidden()

        VStack{
//            NavigationLink(destination: Stories(id: 2, title: title), isActive: self.$isSignIn)
        if menue.count > 0 {
        
        
            
                
                ZStack{
                    LinearGradient(gradient: Gradient(colors: [Color.init(hex: "FCF1EF"), Color.init(hex: "BE9ECB"),Color.init(hex:"5461A7")]), startPoint: .topTrailing, endPoint: .bottomLeading)
                           .edgesIgnoringSafeArea(.vertical)
                   
                    VStack(spacing:0){
                
                
                    Navbars(isHome:true,page_titel: "كيان")
                Spacer()
                        ScrollView(.horizontal,showsIndicators:false) {
            HStack(spacing:45){
                ForEach(0...menue.count-1,id:\.self){ index in
                    StoriesCards(imageName:imageName[index],storyName:menue[index].name, storyID: menue[index].id,width: geo.size.width*0.4,title: $title, selectdMenuID: $selectdMenuID, isSignIn: $isSignIn,isStory:false)
                }
                }//.flipsForRightToLeftLayoutDirection(true).
            .padding(.horizontal)
                
                        }
                        .flipsForRightToLeftLayoutDirection(true)
                        .environment(\.layoutDirection, .rightToLeft)//.environment(\.layoutDirection, .rightToLeft).padding(20)
                Spacer()
        }
            
        }//.edgesIgnoringSafeArea(.all)// .fullScreenCover(isPresented: self.$isSignIn, content: {
//            Stories(id: 2, title: title)
//        })
        }
        }//.environment(\.horizontalSizeClass, .compact).edgesIgnoringSafeArea(.all)
            
        }.navigationBarTitle(Text("Home"))
            .navigationBarHidden(true)
        }
        .environment(\.horizontalSizeClass, .compact)
        .edgesIgnoringSafeArea(.all)
        
        .onAppear{
            getSection()
            }
//            else{
//                ActivityIndicator()
//                    .animated(true)
//                    .style(.large)
                
//            }
        
    }
    func getSection(){
        print(Connection().getUrl(word: "GetMenu"))
        RestAPI().getData(endUrl: Connection().getUrl(word: "GetMenu"), parameters: [:]) { result in
            
           let sectionR = JSON(result!)
            print(sectionR)
            if sectionR["responseCode"].int == 200{
                let jsonDatas = try! JSONEncoder().encode(sectionR["response"])
                let menus = try! JSONDecoder().decode([MenueModal].self, from: jsonDatas)
                menue=menus
                print(menue)
            }
        } onError: { error in
            print(error!)
        }
        
    }
    
}
