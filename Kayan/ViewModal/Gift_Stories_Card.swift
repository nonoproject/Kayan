//
//  Gift_Stories_Card.swift
//  Kayan
//
//  Created by Sandal on 11/01/1443 AH.
//

import SwiftUI
struct Gift_Stories_Card: View {
    var imageName:StroryModal
    @Binding var BackageHight:CGFloat
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
                .onTapGesture {
    //                     title=storyName
//                    if imageName.isPaid ?? false{
                    
                    print(imageName.id)
                    selectd_story_page_MenuID=imageName.id
                    selectdMenuID=imageName.id
                            print(imageName.storyQuestionsList)
                        story_Questions_List=imageName.storyQuestionsList ?? []
                        print(story_Questions_List)
                        isSignIn=true
                        PlayAppSound().AppPlayAppSound()

//                    }
                }
        }.frame(width: width, height: BackageHight).background(Color.white).cornerRadius(20)
    
    }
    
   
//
}
