//
//  ContentView.swift
//  Kayan
//
//  Created by Awad sandal on 29/03/2021.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("isLogin") var isLogin: Bool = VarUserDefault.SysGlobalData.getGlobalBool(key: VarUserDefault.SysGlobalData.isLogin)
    
    var body: some View {
        
        SplashScreen().edgesIgnoringSafeArea(.all)
//            .statusBar(hidden: true)
//        SandalStoryV2View(id:3)
        
//        payment_WebView(webView: model.webView)
//            Pay_story()
//        Rate()
        
//        Image("Kyan_loader")
            
//            .font(.custom("Sukar black", size: 28))
            
//            StoryViewV4()
//        TestViewsSandaScroolV3()
        
                //        SeeAllView()
//        SnapCarousel().environmentObject(UIStateModel())
//        TestCarusel()
//        if !isLogin{
//        Home(selectdMenuID:3)
//
//            SignIn()
////                .background(Color.red)
//
////                /.edgesIgnoringSafeArea(.all)
//                .onTapGesture {
//                self.hideKeyboard()
//    //
//              }.edgesIgnoringSafeArea(.all)
////                Color.blue.edgesIgnoringSafeArea(.all)
//
//        }
//        else{
////        AppIntro()
//        SplashScreen()
//        
////        NavigationView{
//        Home()
//        PlayRelacsation()
        
////        StoriesSection()
////        SamopleRecourding(audioRecorder: AudioRecorder())
////        }.environment(\.horizontalSizeClass, .compact)
//        Stories()
//        StoryPage( audioRecorder: AudioRecorder(), page_story_id: 15, storyQuestionsList: [])
//        Test()//Reading Story
//        Gift()
//        QueestionPage()
//        
////        SignIn()
        .onTapGesture {
            self.hideKeyboard()
//
          } // aproved pay Ayman
            .onAppear{

//                    var bgTask = UIBackgroundTaskIdentifier(rawValue: 1)
//                                    UIApplication.shared.beginBackgroundTask { () -> Void in
SignalRService(url:  URL(string: "\(AppBase)/NotificationHub?customerId=\(VarUserDefault.SysGlobalData.getGlobalInt(key: VarUserDefault.SysGlobalData.userId))")!)
                print("\(VarUserDefault.SysGlobalData.getGlobalInt(key: VarUserDefault.SysGlobalData.userId))")
                
                }
////        SignUp() // aproved pay Ayman
////            AccountSetting() // aproved pay Ayman
////    ForgetPassword()
////        VarificationCode()
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
struct enable_disableBtn : View {
    var imageName:String
   @Binding var isEnabel:Bool
    var body: some View{
        ZStack{
            Image(systemName: imageName).resizable().frame(width: 25, height: 25)
            Image(systemName: "nosign").resizable().foregroundColor(.red.opacity(0.6)).frame(width: 34, height: 34).opacity(isEnabel ? 0 : 10)
        }
        
    }
}
