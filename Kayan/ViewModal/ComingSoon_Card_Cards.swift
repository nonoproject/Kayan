//
//  ComingSoon_Card_Cards.swift
//  Kayan
//
//  Created by Sandal on 10/01/1443 AH.
//

import SwiftUI

struct ComingSoon_Card_Cards: View {
    
        var imageName:StroryModal
        @State var BackageHight:CGFloat
        var width:CGFloat=202
        
        @Binding var title:String
        @Binding var selectdMenuID:Int
        
        @Binding var isSignIn:Bool
        
        @Binding var add_story_to_supscription_binding:Bool
        var body: some View {
    //        geo.size.width*0.25
    //        geo.size.width*0.18
            
    //        ZStack{
                 
            ZStack(alignment: .top){
                
                    Group{
                    AsyncImage(
                        url: (URL(string:"\(AppBase)\(imageName.imageURL ?? "")" )! ),
                                        placeholder: { Image("kayan_logo")},
                                        image: { Image(uiImage: $0).resizable()//
                                            
                                        }
                                     )
                    }//.frame(width: width, height: BackageHight, alignment: .center).cornerRadius(10)
                    
               
    //            Text(imageName.name!).frame(width: width-100, height: 60).background(Color.AppPrimaryColor).foregroundColor(Color.black).cornerRadius(10)
    //                .offset(y:-30).onTapGesture {
    ////                     title=storyName
    //                    print(imageName.id)
    //                    selectd_story_page_MenuID=imageName.id
    //                    selectdMenuID=imageName.id
    //                    isSignIn=true
    //                }
    //            if BackageHight > 200{
    //            ZStack{
    //                Color.white.opacity(0.5)
    //            VStack{
    //                Text(imageName.name!).font(.system(size: 16, weight: .black, design: .rounded)).foregroundColor(.white)
    //               .padding(10)
    //                Spacer()
    //                Text(" لايوجد تفصيل او مقدمة في هذه القصة")
    //                Spacer()
    //            }
    //            }.frame(width: width*0.7, height:BackageHight*0.8).foregroundColor(Color.black).cornerRadius(10)
    //            .onTapGesture {
    ////                     title=storyName
    //
    //                if imageName.isSubscribed ?? false{
    //                print(imageName.id)
    //                selectd_story_page_MenuID=imageName.id
    //                selectdMenuID=imageName.id
    //                        print(imageName.storyQuestionsList)
    //                    story_Questions_List=imageName.storyQuestionsList ?? []
    //print(story_Questions_List)
    //                    isSignIn=true
    //                }
    //            }
    //            }
            }.frame(width: width, height: BackageHight).background(Color.white).cornerRadius(20)
           
                
           
    //        }
            
        }
        
    //
    }
