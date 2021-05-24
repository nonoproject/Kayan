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
        
        if !isLogin{
            SignIn().onTapGesture {
                self.hideKeyboard()
    //
              }
        }
        else{
//        AppIntro()
//        SplashScreen()
        
//        NavigationView{
                Home()
//        StoriesSection()
//        SamopleRecourding(audioRecorder: AudioRecorder())
//        }.environment(\.horizontalSizeClass, .compact)
//        Stories()
//            StoryPage( page_story_id: 12)
//        Test()//Reading Story
//        Gift()
        
//        SignIn()
        .onTapGesture {
            self.hideKeyboard()
//
          } // aproved pay Ayman
//        SignUp() // aproved pay Ayman
//            AccountSetting() // aproved pay Ayman
//    ForgetPassword()
//        VarificationCode()
        }
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
