//
//  clips_group_section.swift
//  Kayan
//
//  Created by Sandal on 14/10/1442 AH.
//

import SwiftUI

struct clips_group_section: View {
    var storyName:ClibModal
//    @State var storyID:Int
//    @State var typeID:Int
    
//    var storyAge:String?
    
    var width:CGFloat=202
    
    @Binding var title:String
    @Binding var selectdMenuID:Int
    
    @Binding var is_play_vedio:Bool

    
    
    var body: some View {
//        geo.size.width*0.25
//        geo.size.width*0.18
        HStack(spacing:0){
            
        ZStack{
            
        
           
        
                Group{
                    AsyncImage(
                        url: (URL(string:"https://kayanapp.ibtikar-soft.sa\(self.storyName.imageURL ?? "")" )! ),
                                        placeholder: { Image("kayan_logo").resizable()},
                                        image: { Image(uiImage: $0).resizable()//

                                        }
                    )
                    
                }.frame(width: width, height: 161, alignment: .center).cornerRadius(10).blur(radius: 2)
                .onTapGesture {
                    is_play_vedio=true
                }
                .overlay(VStack{
                    Image(systemName: "play").font(.system(size: 52, weight: .medium, design: .rounded)).foregroundColor(.Appliver)//.backgroundFill(Color.AppPrimaryColor)
                })
//                VStack{
//
//                    HStack(spacing:5){
//                        Text("\(storyName.ageFrom)"+"-"+"\(storyName.ageTo)").font(.system(size: 18, weight: .semibold, design: .monospaced)).frame(width: 50, height: 40).background(Color.AppPrimaryColor).cornerRadius(10)
//
//                        Text(storyName.name).font(.system(size: 18, weight: .semibold, design: .monospaced)).frame(width: 110, height: 40).background(Color.AppPrimaryColor).cornerRadius(10)
//                    }.padding(.top,30)
//
//                    Spacer()
//
//                    Button(action: {
//                        if storyName.isSubscribed {
//                        add_story_to_supscription(story_id: storyName.id)
//                        }
//                        else{
//                            title=storyName.name
//                            selectdMenuID=storyName.id
//                            isSignIn=true
//                        }
//
//                                               }) {
//                        Text( storyName.isSubscribed ?
//
//
//                                "إشترك في الباقة"
//                                : "عرض"
//                        ).frame(width: 145, height: 40).background(Color.AppPrimaryColor).foregroundColor(Color.black).cornerRadius(10)
//
//                                               }.offset(y:-10)
//
//
//                }.frame(height: 201)
       
        }.onAppear{
//            print(typeID)
        }
//            if !storyName.isSubscribed {
//            VStack{
//                Spacer()
//                Rectangle().fill(Color.Appliver).frame(width: 80, height: 30, alignment: .center).cornerRadius(20, corners: [.topRight, .bottomRight]).overlay(
//            HStack{
//                Spacer()
//                Text("إستكشف").foregroundColor(.black).fontWeight(.bold).font(.system(size: 14))
//                Spacer()
//            }
//                ).padding(.top,-60).onTapGesture {
//                    title=storyName.name
//                    selectdMenuID=storyName.id
//                    isSignIn=true
//                }
//                Spacer()
//            }
//        }
        }
    }
//    func add_story_to_supscription(story_id:Int){
//
//        let prams = ["CustomerID":VarUserDefault.SysGlobalData.getGlobalInt(key: VarUserDefault.SysGlobalData.userId),"StoryID":story_id]
//        print( Connection().getUrl(word: "StorySubscribe"))
//        print(prams)
//        RestAPI().postData(endUrl: Connection().getUrl(word: "StorySubscribe"), parameters: prams){ result in
//
//           let sectionR = JSON(result!)
//            print(sectionR)
//            if sectionR["responseCode"].int == 200{
//                print(sectionR["response"])
//
////                                        print(storyAge)
//                title=storyName.name
//                selectdMenuID=storyName.id
//                                                                  isSignIn=true
//            }
//        } onError: { error in
//            print(error)
//        }
//
//    }
}
