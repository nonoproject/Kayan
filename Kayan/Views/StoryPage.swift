//
//  Test.swift
//  Kayan
//
//  Created by Awad sandal on 29/03/2021.
//

import SwiftUI
import SwiftyJSON
import RealmSwift
import AVFoundation
struct StoryPage: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    // timer
    @State var isAtMaxScale = false
   
      private let animation = Animation.easeInOut(duration: 1).repeatForever(autoreverses: true)
    private let maxScale: CGFloat = 1.3
     var uAnimationDuration: Double { return 3.0 }
    
    /// player
    @ObservedObject var audioRecorder: AudioRecorder
    @ObservedObject var audioPlayer = AudioPlayer()
    ///
    @State var story_from_table:stories_table?
    @State var page_indecator:Int=1
    @State var page_story_id:Int=0
    @State var storyQuestionsList:[storyQuestionsList]
    
    @State var show_no_data:Bool=false
    @State var musicSound:Bool=false
    @State var spekerSound:Bool=VarUserDefault.SysGlobalData.getGlobalBool(key: VarUserDefault.SysGlobalData.spekerSound)
    @State var is_auto_pay_anable:Bool=VarUserDefault.SysGlobalData.getGlobalBool(key: VarUserDefault.SysGlobalData.is_auto_pay_anable)
    
    @State var isPlaying:Bool=false
    
    @State var showing_image =  false
    @State var story_sound:[String]=["https://kayanapp.ibtikar-soft.sa/storyPageVoices/76508c47-f92c-4f2a-a2b1-c3ece0d28a91_11.mp3","https://www.english-room.com/audio/p1_listening_term1_02.mp3","https://file-examples-com.github.io/uploads/2017/11/file_example_MP3_700KB.mp3"]
    @State var story_pages:[Story_Page_Modal]=[]
    @State var is_going_to_question:Bool = false
    
    var olympicStatus: String {
           return "page_story_id_\(page_story_id)_\(story_pages[page_indecator-1].id!)"
        }
    var selected_image: String {
           return story_pages[page_indecator-1].imageURL!
        }
    
    @State  var  showsAlert:Bool=false
    @State  var  message:String=""
    // timer
    @State var timer = Timer.publish (every: 1, on: .current, in: .common).autoconnect()
    @State var timeRemaining = -10
    var body: some View {
        ZStack{
//            if story_pages.count > 0{
                ZStack{
                   
                    HStack(spacing:0){
                        
          // Left Controller
                        
                        
                            VStack( spacing: 15){
                                Spacer()
                                Image("home").resizable().frame(width: 42,height: 42).onTapGesture {
                                    stopSound()
                                    self.presentationMode.wrappedValue.dismiss()
                                }
                                VStack{
                                    if story_from_table?.strory_page_records ?? "" == ""{
//                                        stopSound()
                                        if audioRecorder.recording == false {
                                            Button(action: {
                                                print("will rigester")
                                                stopSound()
                                                    self.audioRecorder.startRecording(strory_page_record: olympicStatus)
                                                
                                            }) {
                                                Image(systemName: "mic.fill")
                                                    .resizable().frame(width: 25, height: 25).padding(5).background(Color.Appliver).foregroundColor(.white).cornerRadius(5)
                                            }
                                        } else {
                                            Button(action: {
                                                    self.audioRecorder.stopRecording(strory_page_record: olympicStatus)
                                                Load_data_from_DB()
                                            }) {
                                                Image(systemName: "record.circle.fill")
                                                    .resizable().frame(width: 25, height: 25).padding(5).background(Color.Appliver).foregroundColor(.white).cornerRadius(5)
                                            }
                                            
                                        }
                                    }
                                    else{
                                        Image(systemName: "play.fill").resizable().frame(width: 25, height: 25).padding(5).background(Color.Appliver).foregroundColor(.white).cornerRadius(5)
                                            .scaleEffect(isAtMaxScale ? maxScale : 1)
                                                        .onAppear {
                                                            withAnimation(self.animation, {
                                                                self.isAtMaxScale.toggle()
                                                            })
                                                        }
                                            .onTapGesture {
                                            if spekerSound{
                                                play_audio_from_local()
                                            }
                                            else{
                                                message="???????????? ?????????? ?????????? ???? ???????????????? ?????? ????????"
                                                showsAlert=true
                                            }
                                           
                                            
                                        }
                                    }
                                   
//
//
                                }.frame(width: 40,height: 45).background(Color.AppPrimaryColor).cornerRadius(5).disabled(story_pages.count == 0)
//                                Spacer()
                                
                                
                                
                                
          
                                
                                VStack{
                                    Image(systemName: "mic.slash.fill").resizable().frame(width: 12, height: 12).padding(10).background(Color.Appliver).foregroundColor(.white).cornerRadius(5).onTapGesture {
                                        
                                        delet_audio_from_DB(page_story_id:olympicStatus)
                                        delet_audio_from_local()

                                    }
                            }.frame(width: 40,height: 40).background(Color.AppPrimaryColor).cornerRadius(5)
                                .padding(.top,20)
//                                Image("replaysource_audio")
                                Image(systemName: "music.mic")
                                    
                                    .resizable().frame(width: 30, height: 30).cornerRadius(5).foregroundColor(.Appliver).onTapGesture {
                                        if spekerSound{
                                            if audioPlayer.isPlaying {
                                            paus_audio_from_DB()
                                            }
                                            stopSound()
                                            playSound(radioURL: AppBase+story_pages[page_indecator-1].storyVoicePath!)
                                        }
                                        else{
                                            message="???????????? ?????????? ?????????? ???? ???????????????? ?????? ????????"
                                            showsAlert=true
                                        }
                                    }
                                Spacer()
                                Spacer()
                                    Spacer()
//                                play previs
                                VStack{
                                    Spacer()
                                                    if page_indecator > 1 {
                                Image(systemName: "play.fill").resizable().frame(width: 35, height: 25).padding(5).background(Color.Appliver).foregroundColor(.white).cornerRadius(5).rotationEffect(Angle(degrees: 180)).onTapGesture {
                                    page_indecator -= 1
                                    
    //                                spekerSound=true
                                    if spekerSound{
                                    stopSound()
                                }
                                    Load_data_from_DB()
                                    if story_from_table?.strory_page_records ?? "" == ""{
                                        if spekerSound{
                                            playSound(radioURL: AppBase+story_pages[page_indecator-1].storyVoicePath!)
                                        }
    //                                playSound()
                                    }
                                    showing_image = !showing_image
                                }
                                                    }
                                }.frame(width: 40,height: 15)//.offset(y:10)
//                                .padding(.bottom,20)
                                .padding(.bottom,40)

                            }.padding(10).background(Color.AppPrimaryColor.opacity(0.2))
                        
                        
                        
                        
                        if story_pages.count>0{
                        if showing_image {
//                            showImage(url: "\(self.story_pages[page_indecator-1].imageURL)")
                            
                            self.story_pages[page_indecator-1].selected_image
                            }
                        else{
                            self.story_pages[page_indecator-1].selected_image
//                            showImage(url: "\(self.story_pages[page_indecator-1].imageURL)")
                        }
                        
                        }
                        else{

                            ZStack{
                                HStack{
                                    Spacer()
                                if !show_no_data{
                                    LoadinIndicator().onAppear{
                                        GetStoryPage()
                                    }
                                }
                                else{
                                    Text("???????? ???????????? ????????????").font(.system(size: 50, weight: .heavy, design: .rounded))
                                            .foregroundColor(.Appliver)

                                    }
                                    Spacer()
                                }
                            }

                        }
                        
                        
                        // End Of showing Image Section
                        
                        
                        
                        
                        // Right Controller
                        
                        VStack( spacing: 15){
                            Spacer()
                            VStack(spacing:6){
                                
                                enable_disableBtn(imageName: "music.quarternote.3", isEnabel: $musicSound,image_sourse: "rington").onTapGesture {

                                musicSound.toggle()
                                if musicSound{
//                                    changeUsingSound()
                                    if spekerSound{
                                        stopSound()
                                        if story_pages[page_indecator-1].storyVoiceWithMusicPath != nil{
                                            playSound(radioURL: AppBase+story_pages[page_indecator-1].storyVoiceWithMusicPath!)
                                        }
                                    }
                                }
                                else{
                                    
                                }
                            }
                            enable_disableBtn(imageName: "speaker.wave.2.fill", isEnabel: $spekerSound )
                            .onTapGesture {
                                changeUsingSound()
                                if !spekerSound{
                                    stopSound()
                                }
//                                else{
//                                    stopSound()
//                                }
                            }
                            }.frame(width: 42,height: 132)
//                            Spacer()
        //                    if page_indecator == 4 {
                            VStack{
                                Image(is_auto_pay_anable ? "play" : "no-play").resizable().frame(width: 40, height: 40)//.padding(10)
//                                    .background(Color.Appliver)
                                    .foregroundColor(.white).cornerRadius(5)
                                .onTapGesture {
                                    is_auto_pay_anable = !is_auto_pay_anable
                                    VarUserDefault.SysGlobalData.setGlobal(Key: VarUserDefault.SysGlobalData.is_auto_pay_anable, Val: is_auto_pay_anable)
                                }
                            }.frame(width: 40,height: 40)//.background(Color.AppPrimaryColor)
                            .cornerRadius(5).padding(.top,35)
        //                    }
                            Spacer()
                            Spacer()
                                Spacer()
                            
                            
                            VStack(spacing:4){
                                Spacer()
//                                if page_indecator != story_pages.count || story_Questions_List.count > 0{
                                    Image(systemName: "play.fill").resizable().frame(width: 35, height: 25).padding(5).background(Color.Appliver).foregroundColor(.white).cornerRadius(5).onTapGesture {
                                        go_to_next_page()
//                                        Load_data_from_DB()
                                    }

                                    HStack(spacing:1){
                                        Text("\(page_indecator)").frame(width: 18, height: 20).background(Color.Appliver).foregroundColor(Color.white).cornerRadius(2)

                                        Text("\(story_pages.count)").frame(width: 18, height: 20).background(Color.Appliver).foregroundColor(Color.white).cornerRadius(2)
                                    }.frame(width: 40,height: 15).padding(.bottom,20)
//                            }
                            }.frame(width: 40,height: 15).padding(.bottom,30)

                        }.padding(10).background(Color.AppPrimaryColor.opacity(0.2))
                        
                        // Right Controller End
                        

                    }
                    // Story Text Controller Starting
                    
                    if story_pages.count > 0{
                    

                        Spacer()
                        HStack( spacing: 0){
//                            ZStack{
                         //   Color.blue
                            
                            VStack{
                                Spacer()
                                Text(story_pages[page_indecator-1].storyText ?? "???????? ???????????? ??????????")//
                                    .font(.custom("Cairo-Black", size: 14))
                                    .multilineTextAlignment(.trailing)
                                    .lineSpacing(1)
//                                    .lineSpacing(4)
//                                    .modifier(customFountCR())
                                    .padding(.bottom,8)
                            }
                                //.padding(5).cornerRadius(20)

                                    
                            //.background(Color.white.opacity(0.6))
                            
//


                        }.frame(width: UIScreen.screenWidth*0.8)
                        
                        .padding(.horizontal,20).cornerRadius(20).onAppear{
                       if story_from_table?.strory_page_records ?? "" == ""{
                        if spekerSound{
                            playSound(radioURL: AppBase+story_pages[page_indecator-1].storyVoicePath!)
                        }
                        }
                        }
                }
                    
                    // Story Text Controller Starting
                }.onReceive(timer) { _ in
                    if is_auto_pay_anable{
                    if self.timeRemaining > 0 {
                        self.timeRemaining -= 1
                    } else{
                        self.timer.upstream.connect().cancel()
                        if timeRemaining != -10{
                            go_to_next_page()
                        }
                        
//                        GoToNextStory()
                        
                        // Do the action on end of timer. Text would  have been hidden by now
                        
                    }
                    }
                    else {
                        self.timer.upstream.connect().cancel()
                    }
                    
                }
//            }

        }.edgesIgnoringSafeArea(.leading).onAppear{
            print(storyQuestionsList)
            restartAnimation()
//            GetStoryPage()
            print(page_story_id)
//            print()
            
        }
        .alert(isPresented: self.$showsAlert) {
            Alert(title: Text(message))
        }
        .fullScreenCover(isPresented:  self.$is_going_to_question ){
            QueestionPage(story_pages_count:story_pages.count,page_story_id:page_story_id).navigationBarTitle(Text("Home"))
                .navigationBarHidden(true)
        }
    }
    func go_to_next_page(){
        if page_indecator != story_pages.count{
        page_indecator += 1
        
//                                        spekerSound=true
//                                        stopSound()
        Load_data_from_DB()
        if story_from_table?.strory_page_records ?? "" == ""{
            if spekerSound{
                playSound(radioURL: AppBase+story_pages[page_indecator-1].storyVoicePath!)
            }
        }
        showing_image = !showing_image
        }
        else{
            if spekerSound{
                if (player?.isPlaying != nil) {
                player!.stop()
                isPlaying=false
            }
            
            }
            is_going_to_question=true
        }
    }
    func changeUsingSound(){
        VarUserDefault.SysGlobalData.setGlobal(Key: VarUserDefault.SysGlobalData.spekerSound, Val: !spekerSound)
        spekerSound.toggle()
    }
    
    func restartAnimation() {
      var deadline: DispatchTime = .now() + uAnimationDuration
      DispatchQueue.main.asyncAfter(deadline: deadline) {
        self.show_no_data = true
      }
    }
    func GetStoryPage(){
        print(Connection().getUrl(word: "GetStoryPages"))
//        RestAPI().getData(endUrl: Connection().getUrl(word: "GetStories")+"\(id)", parameters: [:])
//        \(page_story_id)
        RestAPI().getData(endUrl: Connection().getUrl(word: "GetStoryPages")+"\(page_story_id)", parameters: [:]){ result in

           let sectionR = JSON(result!)
            print(sectionR)
            
            if sectionR["responseCode"].int == 200{
                let jsonDatas = try! JSONEncoder().encode(sectionR["response"])
                story_pages = try! JSONDecoder().decode([Story_Page_Modal].self, from: jsonDatas)
                if story_pages.count > 0{
                if StoryPage.Load_DB_data(id: olympicStatus) != nil{
//                    print(StoryPage.Load_DB_data(id: "\(page_story_id)"))
//                    print("*********************************")
                    Load_data_from_DB()
//                    delet_audio_from_DB(page_story_id: "page_story_id_\(page_story_id)_\(story_pages[page_indecator].id!)")
                }
                }
                
            }
        } onError: { error in
            print(error)
        }
        
    }
    func Load_data_from_DB() {
        story_from_table=StoryPage.Load_DB_data(id: olympicStatus )
    }
    
 
    @State var player: AVAudioPlayer?
    func stopSound(){
        if ((player?.isPlaying) != nil) {
            player!.stop()
            isPlaying=false
        }
    }
    func playSound(radioURL:String){
        
        if ((player?.isPlaying) != nil || isPlaying) {
            stopSound()
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
            player!.play()
            print(Int(player!.duration))
//            print(Int(player!.duration)/8)
            if is_auto_pay_anable{
                
                
//                self.timer = Timer.publish (every: 1, on: .current, in:
//                    .common).autoconnect()
//
//                timeRemaining = 30
//               self.timer = Timer.publish (every: 1, on: .current, in:.common).autoconnect()
//                timer = timer.upstream.autoconnect()
//                timer =  timer.upstream.autoconnect()
                DispatchQueue.main.async {
//                    self.timeRemaining = Int(3)
                    self.timeRemaining = Int(player!.duration)
                    self.timer = Timer.publish (every: 1, on: .current, in:
                                                       .common).autoconnect()
                }
                
            }
           
            isPlaying=true
        } catch let error as NSError {
            //self.player = nil
            print(error.localizedDescription)
        } catch {
            print("AVAudioPlayer init failed")
        }
        
    }
    
    
    static func Load_DB_data(id: String) -> stories_table {
        print("*********************************")
        print(id)
        print("*********************************")
        let realm = try! Realm()
//        let scope = realm.objects(stories_table.self).filter("story_page_id == %@", id)
        
        return realm.object(ofType: stories_table.self, forPrimaryKey: id) ?? stories_table()
//        return scope.first!
    }
    func play_audio_from_local(){
    let fileManager = FileManager.default
    let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
    let directoryContents = try! fileManager.contentsOfDirectory(at: documentDirectory, includingPropertiesForKeys: nil)
    for audio in directoryContents {
        if "\(audio)".contains(olympicStatus){
            self.audioPlayer.startPlayback(audio: audio)
            return
        }
        
    }
}
    func delet_audio_from_local(){
    let fileManager = FileManager.default
    let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
    let directoryContents = try! fileManager.contentsOfDirectory(at: documentDirectory, includingPropertiesForKeys: nil)
    for audio in directoryContents {
        if "\(audio)".contains(olympicStatus){
//            self.audioPlayer.del
                                                    self.audioRecorder.deleteRecording(urlsToDelete: [audio])
            
//            delet_audio_from_DB(page_story_id: "page_story_id_\(page_story_id)_\(story_pages[page_indecator].id!)")
            break
        }
        
    }
}
    func paus_audio_from_DB(){
        self.audioPlayer.stopPlayback()//startPlayback(audio: audio)
    }
    func delet_audio_from_DB(page_story_id:String){
//        do {
//                let realm = try Realm()
//                    let predicate = NSPredicate(format: "UUID == %@", "\(page_story_id)")
//                if let obj = realm.objects(stories_table.self).filter("story_page_id= %@", page_story_id).first {
//
//                    //Delete must be perform in a write transaction
//
//                    try! realm.write {
//                         realm.delete(obj)
//                     }
//                }
////
//            } catch let error {
//                print("error - \(error.localizedDescription)")
//            }
        let person = stories_table()
        person.story_page_id = page_story_id
        person.strory_page_records=""
        
        let realm = try! Realm()
        try! realm.write {
            realm.add(person, update: .modified)
            
            
        }
    }
}
//
//struct Test_Previews: PreviewProvider {
//    static var previews: some View {
//        StoryPage()
//    }
//}

struct showImage : View {
    @Binding var url:String
    var body : some View{
        
        AsyncImage(
            url: (URL(string:"\(AppBase)/storyPageImages/966b408a-8777-4056-a9bd-aef07d8956f2.jpg)")!),
                            placeholder: { Image("kayan_logo").resizable()},
                            image: { Image(uiImage: $0).resizable()
                            }
        ).onAppear{
            print(url)
        }
    }
    
}
