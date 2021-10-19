//
//  ContentView.swift
//  Kayan
//
//  Created by Awad sandal on 29/03/2021.
//

import SwiftUI
import AVFoundation
struct ContentView: View {
    @AppStorage("isLogin") var isLogin: Bool = VarUserDefault.SysGlobalData.getGlobalBool(key: VarUserDefault.SysGlobalData.isLogin)
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    @State var timer = Timer.publish (every: 1, on: .current, in: .common).autoconnect()
    @State var timeRemaining = -1
    @State var player: AVAudioPlayer?
    @ObservedObject var audioPlayer = BackGroundAudioPlayer()
    var body: some View {
        
//
        
        SplashScreen().edgesIgnoringSafeArea(.all)
        //
//        Gift()
//            .statusBar(hidden: true)
//        GiftStory(id:3)
        
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
//        StoryPage( audioRecorder: AudioRecorder(), page_story_id: 2, storyQuestionsList: [])
//        Test()//Reading Story
        
//        QueestionPage()
//        
////        SignIn()
        .onTapGesture {
            self.hideKeyboard()
//
          } // aproved pay Ayman
            .onAppear{
                playSound(radioURL: "https://www.proudmusiclibrary.com/en/file/preview_download/?did=M3ZteDBDcThhVHVGUXBMLzN5VjRpdz09")//AppBase+story_pages[page_indecator-1].storyVoicePath!)
//                    var bgTask = UIBackgroundTaskIdentifier(rawValue: 1)
//                                    UIApplication.shared.beginBackgroundTask { () -> Void in
//SignalRService(url:  URL(string: "\(AppBase)/NotificationHub?customerId=\(VarUserDefault.SysGlobalData.getGlobalInt(key: VarUserDefault.SysGlobalData.userId))")!)
                print("\(VarUserDefault.SysGlobalData.getGlobalInt(key: VarUserDefault.SysGlobalData.userId))")
                ////
                SignalRService(url:  URL(string: "https://takuaapi.ibtikar-soft.com/NotificationHub?UserID=4&PhoneNo=+966566220639")!)
//                                print("\(VarUserDefault.SysGlobalData.getGlobalInt(key: VarUserDefault.SysGlobalData.userId))")
                
                }
////        SignUp() // aproved pay Ayman
////            AccountSetting() // aproved pay Ayman
////    ForgetPassword()
////        VarificationCode()
//        }
    }
    func playSound(radioURL:String){
        
        if ((player?.isPlaying) != nil ) {
            player!.stop()
        }
//        let radioURL = AppBase+story_pages[page_indecator-1].storyVoicePath!
        let urlstring = radioURL
        let url = NSURL(string: urlstring)
        print("the url = \(url!)")
        downloadFileFromURL(url: url!)
//        }
//        else{
//            stopSound()
//        }
        
    }
    func downloadFileFromURL(url:NSURL){

        var downloadTask:URLSessionDownloadTask
        downloadTask = URLSession.shared.downloadTask(with: url as URL, completionHandler: {(URL, response, error) -> Void in
            self.play(url: URL as! NSURL)
        })
            
        downloadTask.resume()
        
    }
    func play(url:NSURL) {
        print("playing \(url)")
        
       
        do {
            self.player = try AVAudioPlayer(contentsOf: url as URL)
            player!.volume = 1.0
            player?.numberOfLoops = -1
            player!.play()
            
                
           
        } catch let error as NSError {
            //self.player = nil
            print(error.localizedDescription)
        } catch {
            print("AVAudioPlayer init failed")
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
    var image_sourse:String = ""
    
    var body: some View{
        ZStack{
            if image_sourse == "" {
            Image(systemName: imageName).resizable().frame(width: 25, height: 25)
            Image(systemName: "nosign").resizable().foregroundColor(.red.opacity(0.6)).frame(width: 34, height: 34).opacity(isEnabel ? 0 : 10)
            }
            else{
                Image(image_sourse).resizable().frame(width: 35, height: 35)
                Image(systemName: "nosign").resizable().foregroundColor(.red.opacity(0.6)).frame(width: 34, height: 34).opacity(isEnabel ? 0 : 10)
            }
        }
        
    }

    
    
}
