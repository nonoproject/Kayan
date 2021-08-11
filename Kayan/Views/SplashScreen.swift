//
//  SplashScreen.swift
//  Kayan
//
//  Created by Awad sandal on 30/03/2021.
//

import SwiftUI
import SwiftyJSON
struct SplashScreen: View {
   @State var logo_key=0
    var uAnimationDuration: Double { return 3.0 }
//    @State private var isPresented = false
    @AppStorage("isLogin") var isLogin: Bool = VarUserDefault.SysGlobalData.getGlobalBool(key: VarUserDefault.SysGlobalData.isLogin)
    var body: some View {
        
        ZStack{
            Color.white
            
            if logo_key == 0{
                Image("kayan_logo").resizable().frame(width: 400, height: 400, alignment: .center).onAppear{
//                    checConnection()
                    restartAnimation()

                }
            }
            else if logo_key >= 1{
                if logo_key == 1 && !VarUserDefault.SysGlobalData.getGlobalBool(key: VarUserDefault.SysGlobalData.isFirestTime) {
                    IntroVedio().onAppear{
//                        uAnimationDuration = 5.0
                        VarUserDefault.SysGlobalData.setGlobal(Key: VarUserDefault.SysGlobalData.isFirestTime, Val: true)
                        restartAnimation(video_time: 5.0)
                    }
                }
                 else{
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
            }
        }//.fullScreenCover(isPresented: ($isPresented), content: Home())
//        .fullScreenCover(isPresented: self.$isPresented, content: {
//            Home()
//        })
        
    }
    func restartAnimation(video_time:Double=0.0) {
        let deadline: DispatchTime = video_time != 0.0 ? .now() + video_time :.now() + uAnimationDuration
      DispatchQueue.main.asyncAfter(deadline: deadline) {
        if self.logo_key+1 == 2{
          self.logo_key += 1
        }
        else{
//        withAnimation(.easeIn(duration: uAnimationDuration)) {
            self.logo_key += 1
//            isPresented = self.logo_key == 2 ? true : false
//            restartAnimation()
//           }
        }
      }
    }
    func checConnection()  {
        RestAPI().postData(endUrl: Connection().getUrl(word: "login"), parameters: [:]) { result in
//            showSandalLoadingIndicater=false
           let sectionR = JSON(result!)
            print(Connection().getUrl(word: "login"))
//                  print(prams)
            print(sectionR)
         
            if sectionR["responseCode"].int == 200{
                
                
                
            }
            else if sectionR["responseCode"].int == 405{ // user not active

            }
            else if sectionR["responseCode"].int == 404{//user not found
                restartAnimation()
            }
            else if sectionR["responseCode"].int == 406{//user not found
            }
            else{
            }
            
        } onError: { error in
            print(error)

        }

        
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
