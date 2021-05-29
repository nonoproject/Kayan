//
//  VaforaiteCard.swift
//  Kayan
//
//  Created by Sandal on 13/10/1442 AH.
//

import SwiftUI
import SwiftyJSON

struct VaforaiteCard: View {
    
        var imageName:String?
        var storyName:String
        var storyID:Int
        var storyAge:String?
        
        var width:CGFloat=202
        
        @Binding var title:String
        @Binding var selectdMenuID:Int
        
        @Binding var isSignIn:Bool

        var isStory:Bool=true
        
        var body: some View {
    //        geo.size.width*0.25
    //        geo.size.width*0.18
            
            ZStack{
                
            VStack{
               
                    Group{
                    AsyncImage(
                        url: (URL(string:"https://kayanapp.ibtikar-soft.sa\(imageName ?? "")" )! ),
                                        placeholder: { Image("kayan_logo")},
                                        image: { Image(uiImage: $0).resizable()//
                                            
                                        }
                                     )
                    }.frame(width: width, height: 161, alignment: .center).cornerRadius(10)
                                if !isStory{
                        
                    }
//                if !isStory{
//                Text(storyName).frame(width: 145, height: 40).background(Color.AppPrimaryColor).foregroundColor(Color.black).cornerRadius(10)
//                    .offset(y:-30).onTapGesture {
//    //                     title=storyName
//
//                        selectd_story_page_MenuID=storyID
//
//                        selectdMenuID=storyID
//                        isSignIn=true
//
//                    }
//                }
                
            }
           
                
           
            }
        }
   
    }
