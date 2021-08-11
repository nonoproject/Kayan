//
//  QueestionPage.swift
//  Kayan
//
//  Created by Sandal on 18/10/1442 AH.
//

import SwiftUI
import SwiftyJSON
struct QueestionPage: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var is_go_to_Home:Bool = false
    @State var story_pages_count:Int=5
    @State private var showing_alert = false
    @State private var alert_message = ""
    @State private var is_go_to_Gift = false
    
    
    @State private var showShareSheet = false
        
    var body: some View {
//        VStack{
        
        NavigationView {
        ZStack{
            
//                if is_go_to_Home{
//                    Home().navigationBarTitle(Text("Home"))
//                        .navigationBarHidden(true)//.edgesIgnoringSafeArea(.all)
//                }
//                else{
            Image("head").resizable()
            HStack{
                VStack{
                    NavigationLink(
                                 destination: Home().navigationBarTitle(Text("Home"))
                                    .navigationBarHidden(true),isActive: self.$is_go_to_Home
                             ) {
                        Image("home").resizable().frame(width: 42,height: 42).padding(.top,30).onTapGesture {
                            
                            is_go_to_Home=true
                        }
                             }.isDetailLink(false)
                    .navigationBarTitle(Text("Home"))
                            .navigationBarHidden(true)
                        
                  
                    Spacer()
                    Spacer()
                    Spacer()
                    VStack{
                        Image(systemName: "play.fill").resizable().padding(2).frame(width: 22, height: 22).background(Color.Appliver).foregroundColor(.white).cornerRadius(5).rotationEffect(Angle(degrees: 180)).onTapGesture {
                                                                    self.presentationMode.wrappedValue.dismiss()
                        }.padding(.leading,5)
                }.frame(width: 40,height: 40).background(Color.Appliver).cornerRadius(5)
                    .padding(.top,20)
//                    Spacer()
//                    Spacer()
                        Spacer()
                }.padding(.horizontal,8)
                
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
                    ZStack{
                        Rectangle().fill(Color.AppPrimaryColor)
                        VStack(alignment:.trailing, spacing:20){
                            ScrollView(.vertical, showsIndicators: false) {
                                ForEach(story_Questions_List,id:\.self){ x in
                                    HStack{
                                        Spacer()
                                        Text(x.questionText)
                                        Text("\(x.id)")
                                    }.padding(15)
                                    
                                }
                            }
//                            Spacer()
                        }.foregroundColor(.brown).font(.system(size: 17), weight: .heavy)
                    }
                    .frame(width: UIScreen.screenWidth*0.6)
                    .cornerRadius(10)
                    
                    
                    Spacer()
                }
                Spacer()
                VStack{
                    Spacer()
                    HStack{
                        Image(systemName:"heart.circle.fill").resizable().backgroundFill(Color.red) .clipShape(Circle()).foregroundColor(.white).frame(width: 35, height:35)
                            .onTapGesture {
                                add_story_to_favorit(story_id: selectd_story_page_MenuID)
//                                isGoToFavoratePressed=true
                                
                            }
                        Image(systemName:"gift.circle.fill").resizable().backgroundFill(Color.blue) .clipShape(Circle()).foregroundColor(.white).frame(width: 35, height:35)
                            .onTapGesture {
                                
                                is_go_to_Gift=true
                                
                            }
                    }.frame(height: 42).padding(.horizontal,10)
                    HStack{
                        Spacer()
                        Image(systemName:"arrowshape.turn.up.right.circle.fill").resizable().backgroundFill(Color.black) .clipShape(Circle()).foregroundColor(.white).frame(width: 35, height:35).onTapGesture {
                            self.showShareSheet = true
                        }
                        
                    }.width(70) .sheet(isPresented: $showShareSheet) {
                        ShareSheet(activityItems: ["App URL"])
                    }
                    
                    Spacer()
                    Spacer()
                    Spacer()
                    VStack(spacing:4){
                        Spacer()
                            HStack(spacing:1){
                                Text("\(story_pages_count)").frame(width: 18, height: 20).background(Color.Appliver).foregroundColor(Color.white).cornerRadius(2)

                                Text("\(story_pages_count)").frame(width: 18, height: 20).background(Color.Appliver).foregroundColor(Color.white).cornerRadius(2)


                            }.frame(width: 40,height: 15).padding(.bottom,20).onAppear{
                                print(story_pages_count)
                            }
                    
                }.frame(width: 40,height: 15)
                    Spacer()
                }
            }
//        }
        }.ignoresSafeArea(.all, edges: .all)
//        .sheet(isPresented: $is_go_to_Home) {
//            //            NavView(isShowSheet: self.$isShowSheet)
//
//                Home()
//    }
//    }
        .fullScreenCover(isPresented: self.$is_go_to_Gift){
            Gift()
        }
//
        }.navigationBarTitle(Text("Home"))
        .navigationBarHidden(true).alert(isPresented: $showing_alert) {
            Alert(title: Text("الحالة"), message: Text(alert_message), dismissButton: .default(Text("حسنا")))
        }

//        }

    }
    
    func add_story_to_favorit(story_id:Int){

        let prams = ["CustomerID":VarUserDefault.SysGlobalData.getGlobalInt(key: VarUserDefault.SysGlobalData.userId),"StoryID":story_id]
        print( Connection().getUrl(word: "AddToFavourite")+"\(story_id)")
        print(prams)
        RestAPI().postData(endUrl: Connection().getUrl(word: "AddToFavourite"), parameters: prams){ result in

            let sectionR = JSON(result!)
            print(sectionR)
            if sectionR["responseCode"].int == 200{
                print(sectionR["response"])
                //                let jsonDatas = try! JSONEncoder().encode(sectionR["response"])
                //                let menus = try! JSONDecoder().decode([StroryModal].self, from: jsonDatas)
                //                stories=menus
                ////                print(stories)
                alert_message = sectionR["responseMasg"].stringValue
                showing_alert=true
            }
        } onError: { error in
            print(error)
        }

    }
}
