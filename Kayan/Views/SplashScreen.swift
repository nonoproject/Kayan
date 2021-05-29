//
//  SplashScreen.swift
//  Kayan
//
//  Created by Awad sandal on 30/03/2021.
//

import SwiftUI

struct SplashScreen: View {
   @State var logo_key=0
    var uAnimationDuration: Double { return 3.0 }
//    @State private var isPresented = false
    @AppStorage("isLogin") var isLogin: Bool = VarUserDefault.SysGlobalData.getGlobalBool(key: VarUserDefault.SysGlobalData.isLogin)
    var body: some View {
        
        ZStack{
            Color.white
            
            if logo_key == 0{
                Image("kayan_logo").resizable().frame(width: 127, height: 138, alignment: .center).onAppear{
                    restartAnimation()
                }
            }
            else if logo_key == 1{
                if !isLogin{
                    
                    SignIn()
        //                .background(Color.red)
                        
        //                /.edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                        self.hideKeyboard()
            //
                      }.edgesIgnoringSafeArea(.all)
        //                Color.blue.edgesIgnoringSafeArea(.all)
                    
                }
                else{
        //        AppIntro()
//                SplashScreen()
                
        //        NavigationView{
                        Home().edgesIgnoringSafeArea(.all)
        //        StoriesSection()
        //        SamopleRecourding(audioRecorder: AudioRecorder())
        //        }.environment(\.horizontalSizeClass, .compact)
        //        Stories()
        //            StoryPage( audioRecorder: AudioRecorder(), page_story_id: 2)
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
        }//.fullScreenCover(isPresented: ($isPresented), content: Home())
//        .fullScreenCover(isPresented: self.$isPresented, content: {
//            Home()
//        })
        
    }
    func restartAnimation() {
      var deadline: DispatchTime = .now() + uAnimationDuration
      DispatchQueue.main.asyncAfter(deadline: deadline) {
        if self.logo_key+1 == 2{
          self.logo_key += 1
        }
        else{
        withAnimation(.easeIn(duration: uAnimationDuration)) {
            self.logo_key += 1
//            isPresented = self.logo_key == 2 ? true : false
//            restartAnimation()
           }
        }
      }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
