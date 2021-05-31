//
//  QueestionPage.swift
//  Kayan
//
//  Created by Sandal on 18/10/1442 AH.
//

import SwiftUI

struct QueestionPage: View {
    var body: some View {
        ZStack{
            Image("head").resizable()
            HStack{
                VStack{
                    
                        Spacer()
                        Image("home").resizable().frame(width: 42,height: 42)
                    
                    VStack{
                        Image(systemName: "mic.slash.fill").resizable().frame(width: 12, height: 12).padding(10).background(Color.Appliver).foregroundColor(.white).cornerRadius(5)
                }.frame(width: 40,height: 40).background(Color.AppPrimaryColor).cornerRadius(5)
                    .padding(.top,20)
                    Spacer()
                    Spacer()
                        Spacer()
                }
                
                Spacer()
                VStack{
                    VStack(spacing:0){
                        HStack(spacing:90){
                        
                        Rectangle().fill(Color.AppPrimaryColor).frame(width:3,height: 12)
                        
                        Rectangle().fill(Color.AppPrimaryColor).frame(width:2,height: 12)
                            
                    }.frame(width: 220)
                        Rectangle().fill(Color.AppPrimaryColor).frame(width: 220,height: 70).overlay(
                            VStack{
                                Text("لنفكر معا")
                            }.foregroundColor(.brown).font(.system(size: 17), weight: .heavy)
                        ).cornerRadius(10)
//                        Spacer()
                    }
                    
                    Rectangle().fill(Color.AppPrimaryColor).frame(width: UIScreen.screenWidth*0.6).overlay(
                        VStack(spacing:20){
                            Text("في اي عام ولد حسين؟")
                            Text("في اي عام ولد حسين؟")
                            Text("في اي عام ولد حسين؟")
                            Spacer()
                        }.foregroundColor(.brown).font(.system(size: 17), weight: .heavy)
                    ).cornerRadius(10)
                    
                    
//                    Spacer()
                }
                Spacer()
                
                
                
                
                
                
                VStack{
                    Spacer()
                    HStack{
                        Image(systemName: "play")
                        Image(systemName: "play")
                    }
                    Image(systemName: "pause")
                    Spacer()
                    
                    
                    VStack(spacing:4){
                        Spacer()
                            Image(systemName: "play.fill").resizable().frame(width: 35, height: 25).padding(5).background(Color.Appliver).foregroundColor(.white).cornerRadius(5).onTapGesture {
//                                page_indecator += 1
                                
//                                spekerSound=true
//                                stopSound()
//                                Load_data_from_DB()
//                                if story_from_table?.strory_page_records ?? "" == ""{
//                                playSound()
//                                }
//                                showing_image = !showing_image
//                                        Load_data_from_DB()
                            }

                            HStack(spacing:1){
                                Text("\(5)").frame(width: 18, height: 20).background(Color.Appliver).foregroundColor(Color.white).cornerRadius(2)

                                Text("\(1)").frame(width: 18, height: 20).background(Color.Appliver).foregroundColor(Color.white).cornerRadius(2)


                            }.frame(width: 40,height: 15).padding(.bottom,20)
                    
                }.frame(width: 40,height: 15)

                    Spacer()
                    
                }
                
                
            }
        }.ignoresSafeArea(.all, edges: .all)
    }
}

struct QueestionPage_Previews: PreviewProvider {
    static var previews: some View {
        QueestionPage()
    }
}
