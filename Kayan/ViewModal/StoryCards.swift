//
//  StoryCards.swift
//  Kayan
//
//  Created by Sandal on 08/10/1442 AH.
//

import SwiftUI

struct StoryCards: View {
//    @State var story:StroryModal
    var imageName:String
    var storyName:String
    var storyID:Int
    
    
    var width:CGFloat=202
    @Binding var title:String
    @Binding var selectdStoryID:Int
    @Binding var openStory:Bool
    var body: some View {
        VStack{
            
//            AsyncImage(
//                url: (URL(string:"https://kayanapp.ibtikar-soft.sa"+imageName) ?? URL(string:"kayan_logo"))!,
//                                placeholder: { Image("kayan_logo")},
//                                image: { Image(uiImage: $0).resizable()//
//
//                                }
//                             )
//            }
                Image("kayan_logo").frame(width: width, height: 161, alignment: .center).cornerRadius(10)
//
            Text(storyName ?? "الاسم").frame(width: 145, height: 40).background(Color.blue.opacity(0.97)).foregroundColor(Color.white).cornerRadius(10)
                .offset(y:-30)
                .onTapGesture {
//                    title=story.name ?? ""
////                    print(story.name)
//                    selectdStoryID=story.id
                    print(storyID)
//                    openStory=true
                }

        
        }
    }
}
