//
//  Favorate.swift
//  Kayan
//
//  Created by Sandal on 13/10/1442 AH.
//

import SwiftUI
import SwiftyJSON
struct Favorate: View {
    @State var id:Int=0
//    @State var selected_id=2
    @State var title:String=""
//    var imageName=["quran","meditation","childrenStory"]
//    var storyName=["قصص براعم","قصص الابطال","قصص القادة"]
//    var storyAge=["5-3","8-6","9-12"]
    @State var is_go_to_story_page:Bool=false
//    @Environment(\.presentationMode) var presentation
//    var horizontalPaddig:CGFloat=30.0
//    @Environment(\.presentationMode) var presentationModeEdit: Binding<PresentationMode>
    @State var stories:[StroryModal]=[]
    var body: some View {
        GeometryReader{geo in
            
            ZStack{
                VStack{

                    Navbars(isFavorate: true, page_titel: "المفضلة")
////                        Button(action: {
////                            self.presentationModeEdit.wrappedValue.dismiss()
////                                   }){
//
////                                   }
//
//
//
//                        Spacer()
//                        Image("vavoraite").resizable().frame(width: 46, height: 46)
//                        Image("setting").resizable().frame(width: 46, height: 46)
//                        Image("profile").resizable().frame(width: 46, height: 46).padding(.trailing,20)
//
//                    }.frame(height:55).background(Color.blue.opacity(0.77))
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
                        Text("تقريبا").foregroundColor(.white).fontWeight(.bold).font(.system(size: 14))
                        Spacer()
                    }
                )
            }
                        VStack{
                            Spacer()
                            ScrollView(.horizontal, showsIndicators: false){
                HStack{

                            ForEach(0...stories.count-1,id:\.self){ index in
                        HStack(spacing:0){
                            VStack{
                            VaforaiteCard(imageName:stories[index].imageURL ?? "",storyName:stories[index].name ?? "", storyID: stories[index].id,width:200,title: $title, selectdMenuID: $id, isSignIn: $is_go_to_story_page,isStory:false)
                            Button(action: {
        //                        selectd_story_page_MenuID=storyID
        //
                                remove_story_from_favorit(story_id: stories[index].id)
    //                            print()
        //                        selectdMenuID=storyID
        //                        isSignIn=true
                            }){
                                HStack(spacing:5){
                                    Image(systemName:"heart.fill").resizable().foregroundColor(.red).frame(width: 25, height:25)
                                    Text("حذف من المفضلة").font(.system(size: 13, weight: .bold, design: .rounded))
                                }
                            }
                            .frame(width: 155, height: 40).background(Color.AppPrimaryColor).foregroundColor(Color.black).cornerRadius(10)
                            .offset(y:-30)
                            }
    //
    //                        VStack{
    //                            Image(systemName:"heart.fill").resizable().frame(width: 35, height: 25)
    //                                .padding(5)
    //                                .background(Color.Appliver)
    //                                .foregroundColor(.red)
    //                                .cornerRadius(5)
    //                                .onTapGesture {
    //                                    print(stories[index].id)
    //                                    add_story_to_favorit(story_id: stories[index].id)
    //                                }
    //                        Text("استكشق").foregroundColor(.white).fontWeight(.regular).font(.system(size: 9))
    //                            Image(systemName:"camera.filters").frame(width:14,height:14)
    //                        }.frame(width: 44,height:73).background(Color.brown).cornerRadius(30, corners: [.topRight, .bottomRight]).offset(y:-55).onTapGesture {
    ////                            print(stories[index].id)
    ////                            selected_id=stories[index].id
    ////                            is_go_to_story_page=true
    //                        }
                        }
                    }
                }.padding(.horizontal,30)
    //                Spacer()
                }
                            Spacer()
                        }
                        
            
                    }
                    else{
                        VStack{
                            Spacer()
                            Text("عفوا لاتوجد عناصر في المفضلة").font(.system(size: 50, weight: .heavy, design: .rounded))
                                .foregroundColor(.Appliver.opacity(0.8))
                            Spacer()
                        }
                        

                    }
        }
            }.ignoresSafeArea(.all, edges: .all)

        }.onAppear{
//            print(id)
            GetFavorit()
//        }
        }.environment(\.horizontalSizeClass, .compact)

    }
    func remove_story_from_favorit(story_id:Int){
        print(story_id)
//        return
        let prams = ["CustomerID":VarUserDefault.SysGlobalData.getGlobalInt(key: VarUserDefault.SysGlobalData.userId),"StoryID":story_id]
        print( Connection().getUrl(word: "RemoveFromFavourite")+"\(story_id)")
        print(prams)
        RestAPI().postData(endUrl: Connection().getUrl(word: "RemoveFromFavourite"), parameters: prams){ result in
            
           let sectionR = JSON(result!)
            print(sectionR)
            if sectionR["responseCode"].int == 200{
//                print(sectionR["response"])
//                let jsonDatas = try! JSONEncoder().encode(sectionR["response"])
//                let menus = try! JSONDecoder().decode([StroryModal].self, from: jsonDatas)
//                stories=menus
////                print(stories)
                stories = stories.filter { $0.id != story_id }
            }
        } onError: { error in
            print(error)
        }
        
    }
    func add_story_to_favorit(story_id:Int){
//
//        let prams = ["CustomerID":VarUserDefault.SysGlobalData.getGlobalInt(key: VarUserDefault.SysGlobalData.userId),"StoryID":story_id]
//        print( Connection().getUrl(word: "AddToFavourite")+"\(story_id)")
//        print(prams)
//        RestAPI().postData(endUrl: Connection().getUrl(word: "AddToFavourite"), parameters: prams){ result in
//
//           let sectionR = JSON(result!)
//            print(sectionR)
//            if sectionR["responseCode"].int == 200{
//                print(sectionR["response"])
////                let jsonDatas = try! JSONEncoder().encode(sectionR["response"])
////                let menus = try! JSONDecoder().decode([StroryModal].self, from: jsonDatas)
////                stories=menus
//////                print(stories)
//            }
//        } onError: { error in
//            print(error)
//        }
//
    }
    func GetFavorit(){
//        https://kayanapp.ibtikar-soft.sa/api/Story/GetStories/2
        print( Connection().getUrl(word: "GetMyFavouriteStory")+"\(VarUserDefault.SysGlobalData.getGlobalInt(key: VarUserDefault.SysGlobalData.userId))")
//        RestAPI().getData(endUrl: Connection().getUrl(word: "GetStories")+"\(id)", parameters: [:])
        RestAPI().getData(endUrl: Connection().getUrl(word: "GetMyFavouriteStory")+"\(VarUserDefault.SysGlobalData.getGlobalInt(key: VarUserDefault.SysGlobalData.userId))", parameters: [:]){ result in

           let sectionR = JSON(result!)
            print(sectionR)
            if sectionR["responseCode"].int == 200{
                let jsonDatas = try! JSONEncoder().encode(sectionR["response"])
                let menus = try! JSONDecoder().decode([StroryModal].self, from: jsonDatas)
                stories=menus
//                print(stories)
            }
        } onError: { error in
            print(error)
        }

    }
}
