//
//  Test.swift
//  Kayan
//
//  Created by Awad sandal on 29/03/2021.
//

import SwiftUI
import SwiftyJSON

import AVFoundation
struct StoryPage: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    // timer
    
     var uAnimationDuration: Double { return 3.0 }
//    @State var timeRemaining = 3
//       let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    @State var page_indecator:Int=1
    @State var page_story_id:Int
    
    @State var show_no_data:Bool=false
    @State var musicSound:Bool=true
    @State var spekerSound:Bool=true
    @State var isPlaying:Bool=false
    @State var story_sound:[String]=["https://kayanapp.ibtikar-soft.sa/storyPageVoices/76508c47-f92c-4f2a-a2b1-c3ece0d28a91_11.mp3","https://www.english-room.com/audio/p1_listening_term1_02.mp3","https://file-examples-com.github.io/uploads/2017/11/file_example_MP3_700KB.mp3"]
    @State var story_pages:[Story_Page_Modal]=[]
    var body: some View {
        ZStack{
//            if story_pages.count > 0{
                ZStack{
                   
                    HStack(spacing:0){
                        
          
                            VStack( spacing: 15){
                                Spacer()
                                Image("home").resizable().frame(width: 42,height: 42).onTapGesture {
                                    stopSound()
                                    self.presentationMode.wrappedValue.dismiss()
                                }
                                VStack{
                                    
                                    Image(systemName: "music.mic").resizable().frame(width: 25, height: 25).padding(5).background(Color.Appliver).foregroundColor(.white).cornerRadius(5)
                                    
                                    Image(systemName: "play.fill").resizable().frame(width: 25, height: 25).padding(5).background(Color.Appliver).foregroundColor(.white).cornerRadius(5)
                                }.frame(width: 40,height: 90).background(Color.AppPrimaryColor).cornerRadius(5)
                                Spacer()
                                VStack{
                                Image(systemName: "mic.fill").resizable().frame(width: 12, height: 12).padding(10).background(Color.Appliver).foregroundColor(.white).cornerRadius(5)
                            }.frame(width: 40,height: 40).background(Color.AppPrimaryColor).cornerRadius(5)
                                Spacer()
                                Spacer()
                                    Spacer()
                            }.padding(10).background(Color.AppPrimaryColor.opacity(0.2))
                        
//                        Color.blue.opacity(0.5)
                        if story_pages.count > 0{
                        AsyncImage(
                            url: (URL(string:"https://kayanapp.ibtikar-soft.sa\(self.story_pages[page_indecator-1].imageURL ?? "")" )! ),
                                            placeholder: { Image("kayan_logo")},
                                            image: { Image(uiImage: $0).resizable()//
                                                
                                            }
                                         )
                        }
                        else{
                            
                            ZStack{
                                HStack{
                                    Spacer()
                                if !show_no_data{
                                    sandalLoadingIndicater().onAppear{
                                        GetStoryPage()
                                    }
                                }
                                else{
                                    Text("عفوا لاتوجد بيانات").font(.system(size: 50, weight: .heavy, design: .rounded))
                                            .foregroundColor(.Appliver)
                                        
                                    }
                                    Spacer()
                                }
                            }

                        }
                        VStack( spacing: 15){
                            Spacer()
                            VStack(spacing:6){
                            enable_disableBtn(imageName: "music.quarternote.3", isEnabel: $musicSound).onTapGesture {
                                if isPlaying{
                                if musicSound{
                                    player?.pause()
                                }
                                else{
                                    player?.play()
                                }
                                }
                                musicSound.toggle()
                            }
                            enable_disableBtn(imageName: "speaker.wave.2.fill", isEnabel: $spekerSound)
                            .onTapGesture {
                                spekerSound.toggle()
                            }
                            }.frame(width: 42,height: 132)
                            Spacer()
        //                    if page_indecator == 4 {
                            VStack{
                            Image(systemName: "pause.fill").resizable().frame(width: 12, height: 12).padding(10).background(Color.Appliver).foregroundColor(.white).cornerRadius(5)
                                .onTapGesture {
                                    playSound()
                                }
                            }.frame(width: 40,height: 40).background(Color.AppPrimaryColor).cornerRadius(5).padding(.top,25)
        //                    }
                            Spacer()
                            Spacer()
                                Spacer()
                        }.padding(10).background(Color.AppPrimaryColor.opacity(0.2))

                    }
                    if story_pages.count > 0{
                    VStack(alignment: .leading){

                        Spacer()
                        HStack{
                            VStack{
                                                if page_indecator > 1 {
                            Image(systemName: "play.fill").resizable().frame(width: 35, height: 25).padding(5).background(Color.Appliver).foregroundColor(.white).cornerRadius(5).rotationEffect(Angle(degrees: 180)).onTapGesture {
                                page_indecator -= 1
                                playSound()
                            }
                                                }
                            }.frame(width: 40,height: 15)//.offset(y:10)
//                            ZStack{
                            if story_pages.count > 0{
                            HStack{
                                Text(story_pages[page_indecator-1].storyText ?? "عفوا لايوجد محتوى")//.padding(5).cornerRadius(20)

                            }.background(Color.white.opacity(0.6))
                            .padding(.horizontal,20).cornerRadius(20)
                            }
//}
                            VStack(spacing:4){
                                if page_indecator != story_pages.count {
                                    Image(systemName: "play.fill").resizable().frame(width: 35, height: 25).padding(5).background(Color.Appliver).foregroundColor(.white).cornerRadius(5).onTapGesture {
                                        page_indecator += 1
                                        playSound()
                                    }

                                    HStack(spacing:1){
                                        Text("\(page_indecator)").frame(width: 18, height: 20).background(Color.Appliver).foregroundColor(Color.white).cornerRadius(2)

                                        Text("\(story_pages.count)").frame(width: 18, height: 20).background(Color.Appliver).foregroundColor(Color.white).cornerRadius(2)


                                    }.frame(width: 40,height: 15)
                            }
                        }.frame(width: 40,height: 15).offset(y:10)
                        }.padding(.horizontal,10)

                    }.padding(.vertical,20).onAppear{
                        playSound()
                        }
                }
                }
//            }

        }.onAppear{
            print(page_story_id)
            restartAnimation()
            
            
        }
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
                
            }
        } onError: { error in
            print(error)
        }
        
    }
 
    @State var player: AVAudioPlayer?
    func stopSound(){
        if isPlaying{
            player!.stop()
            isPlaying=false
        }
    }
    func playSound(){
        if isPlaying{
            stopSound()
        }
         let radioURL = story_sound[page_indecator-1]
        let urlstring = radioURL
        let url = NSURL(string: urlstring)
        print("the url = \(url!)")
        downloadFileFromURL(url: url!)
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
            
            isPlaying=true
        } catch let error as NSError {
            //self.player = nil
            print(error.localizedDescription)
        } catch {
            print("AVAudioPlayer init failed")
        }
        
    }
    
}
//
//struct Test_Previews: PreviewProvider {
//    static var previews: some View {
//        StoryPage()
//    }
//}
