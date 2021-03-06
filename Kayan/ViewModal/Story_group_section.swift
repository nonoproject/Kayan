//
//  Story_group_section.swift
//  Kayan
//
//  Created by Sandal on 14/10/1442 AH.
//

import SwiftUI
import SwiftyJSON
struct Story_group_section: View {
//    @State var imageName:String
    var storyName:StoriesModal
//    @State var storyID:Int
//    @State var typeID:Int
    
//    var storyAge:String?
    
    var width:CGFloat=202
    
    @Binding var title:String
    @Binding var selectdMenuID:Int
    
    @Binding var isSignIn:Bool

    
    
    var body: some View {
//        geo.size.width*0.25
//        geo.size.width*0.18
        HStack(spacing:0){
            
        ZStack{
            
        
           
        
                Group{
                    AsyncImage(
                        url: (URL(string:"\(AppBase)\(self.storyName.imageURL ?? "")" )! ),
                                        placeholder: { Image("kayan_logo").resizable()},
                                        image: { Image(uiImage: $0).resizable()
                                        }
                    )
                }.frame(width: UIScreen.card_width, height: UIScreen.card_heigh, alignment: .center).cornerRadius(10)//.blur(radius: 2)
            
                VStack{
                    
                    HStack(spacing:UIScreen.card_width*0.03){
                        HStack(spacing:UIScreen.card_width*0.03){
                            
                            Text("سنة").font(.system(size: UIScreen.card_width*0.05, weight: .semibold, design: .monospaced)).foregroundColor(.Appliver)
                                
                            Text("\(storyName.ageFrom)"+"-"+"\(storyName.ageTo)").font(.system(size: UIScreen.card_width*0.05, weight: .semibold, design: .monospaced))
                            
                        }.frame(width:UIScreen.card_width*0.30,height: UIScreen.card_heigh*0.18).background(Color.AppPrimaryColor).cornerRadius(10)
                        
                        Text(storyName.name).font(.system(size: UIScreen.card_width*0.05, weight: .semibold, design: .monospaced)).frame(height: UIScreen.card_heigh*0.18) .padding(.horizontal,30).background(Color.AppPrimaryColor).cornerRadius(10)
                    }.padding(.top,UIScreen.card_width*0.03)//.opacity(0.8)
                    .flipsForRightToLeftLayoutDirection(true)
                    .environment(\.layoutDirection, .rightToLeft)
                    
                    Spacer()
                    //  it was abutton to view your data
//                    Button(action: {
//
//                            title=storyName.name
//                            selectdMenuID=storyName.id
//                            isSignIn=true
//
//
//                                               }) {
//                        Text("عرض").frame(width: 145, height: 40).background(Color.AppPrimaryColor).foregroundColor(Color.black).cornerRadius(10)
//
//                                               }.offset(y:-10)
                
                    
                }.frame(height: UIScreen.card_heigh)
       
        }.onTapGesture {
            title=storyName.name
            selectdMenuID=storyName.id
            isSignIn=true
            PlayAppSound().AppPlayAppSound()
        }
            // it was discover sectoion
//            if !storyName.isSubscribed {
//            VStack{
//                Spacer()
//                Rectangle().fill(Color.AppDiscoverColor).frame(width: 50, height: 40, alignment: .center).cornerRadius(20, corners: [.topRight, .bottomRight]).overlay(
//            VStack{
//                Spacer()
//                Text("إستكشف").foregroundColor(.white).fontWeight(.bold).font(.system(size:8))
//                Image("stargaze").resizable().frame(width: 20,height: 20)
//                Spacer()
//            }
//                ).padding(.top,-60).onTapGesture {
//                    title=storyName.name+" "+"إستكشف"
//                    selectdMenuID=storyName.id
//                    isSignIn=true
//                }
//                Spacer()
//            }
//        }
        }
    }
    func add_story_to_supscription(story_id:Int){
        
        let prams = ["CustomerID":VarUserDefault.SysGlobalData.getGlobalInt(key: VarUserDefault.SysGlobalData.userId),"StoryCatogryID":story_id]
        print( Connection().getUrl(word: "StorySubscribe"))
        print(prams)
        RestAPI().postData(endUrl: Connection().getUrl(word: "StorySubscribe"), parameters: prams){ result in
           let sectionR = JSON(result!)
            print(sectionR)
            if sectionR["responseCode"].int == 200{
                print(sectionR["response"])
                title=storyName.name
                selectdMenuID=storyName.id
                isSignIn=true
            }
        } onError: { error in
            print(error)
        }
        
    }
}
