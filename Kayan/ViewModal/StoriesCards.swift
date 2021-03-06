//
//  StoryCards.swift
//  Kayan
//
//  Created by Awad sandal on 30/03/2021.
//

import SwiftUI
import SwiftyJSON
import AVFoundation


var player: AVAudioPlayer?
struct StoriesCards: View {
    var imageName:String
    var storyName:String
    var storyID:Int
    var storyAge:String?
    
    var width:CGFloat=202
    
    @Binding var title:String
    @Binding var selectdMenuID:Int
    
    @Binding var isSignIn:Bool
    
    var isStory:Bool=true
    @ObservedObject var audioPlayer = AudioPlayer()
    var body: some View {
//        geo.size.width*0.25
//        geo.size.width*0.18
        
        ZStack{
            
        VStack{
            if !isStory{
            Image(imageName).resizable().frame(width: width, height: UIScreen.card_heigh-20, alignment: .center).cornerRadius(10)
            }
            else{
                Group{
                AsyncImage(
                    url: (URL(string:"https://kayanapp.ibtikar-soft.sa"+imageName) ?? URL(string:"kayan_logo"))!,
                                    placeholder: { Image("kayan_logo")},
                                    image: { Image(uiImage: $0).resizable()//
                                        
                                    }
                                 )
                }.frame(width: width, height: UIScreen.card_width, alignment: .center).cornerRadius(10)
            }
            if !isStory{
//                .font(.custom("Sukar black", size: 20))
                Text(storyName).font(.system(size: 18,weight: .semibold, design: .monospaced))
                    .frame(width: UIScreen.card_width*0.5, height: UIScreen.card_heigh*0.15).background(Color.AppPrimaryColor).cornerRadius(10)
                .offset(y:-UIScreen.card_heigh*0.08)
                
                    .flipsForRightToLeftLayoutDirection(true)
                    .environment(\.layoutDirection, .rightToLeft)
            }
//            else{
//                VStack{
//                    HStack(spacing:5){
//                        Text(storyAge!).frame(width: 50, height: 40).background(Color.blue.opacity(0.97)).foregroundColor(Color.white).cornerRadius(10)
//
//                        Text(storyName).frame(width: 110, height: 40).background(Color.blue.opacity(0.97)).foregroundColor(Color.white).cornerRadius(10)
//                    }
//                    Button(action: {
//                        print(storyAge)
//                   //                                title=stories[index].name
//                   //                                id=stories[index].id
//                   //                               isSignIn=true
//                                               }) {
//                                                   Text("?????????? ???? ????????????").frame(width: 145, height: 40).background(Color.blue.opacity(0.97)).foregroundColor(Color.white).cornerRadius(10)
//
//                                               }.offset(y:35)
//                }.offset(y:-30)
//            }
        }
        .onTapGesture {
             title=storyName
            print(storyID)
            print(storyAge)
            selectdMenuID=storyID
            isSignIn=true
            PlayAppSound().AppPlayAppSound()
        }
            
       
        }
    }
}
 var story_Questions_List:[storyQuestionsList]=[]
struct Stories_Card_Cards: View {
    var imageName:StroryModal
    @Binding var BackageHight:CGFloat
    var width:CGFloat=202
    
    @Binding var title:String
    @Binding var selectdMenuID:Int
    
    @Binding var isSignIn:Bool
    
    @Binding var add_story_to_supscription_binding:Bool
    var body: some View {
//        geo.size.width*0.25
//        geo.size.width*0.18
        
//        ZStack{
             
        ZStack(alignment: .top){
            
                Group{
                AsyncImage(
                    url: (URL(string:"\(AppBase)\(imageName.imageURL ?? "")" )! ),
                                    placeholder: { Image("kayan_logo")},
                                    image: { Image(uiImage: $0).resizable()//
                                        
                                    }
                                 )
                }//.frame(width: width, height: BackageHight, alignment: .center).cornerRadius(10)
                .onTapGesture {
    //                     title=storyName
//                    if imageName.isPaid ?? false{
                    if !imageName.isPaid! || ( imageName.isPaid! && imageName.isSubscribed!) {
                    print(imageName.id)
                    selectd_story_page_MenuID=imageName.id
                    selectdMenuID=imageName.id
                            print(imageName.storyQuestionsList)
                        story_Questions_List=imageName.storyQuestionsList ?? []
                        print(story_Questions_List)
                        isSignIn=true
                        PlayAppSound().AppPlayAppSound()
                    }
                    else{
                        if ((player?.isPlaying) != nil) {
                            stopSound()
                        }
                        add_story_to_supscription_binding = true //(story_id:imageName.id)
                    }
//                    }
                }
            
            HStack{
                Spacer()
                
                Image(systemName:"headphones.circle.fill").resizable().backgroundFill(Color.red) .clipShape(Circle()).foregroundColor(.white).frame(width: 35, height:35)
                    .onTapGesture {
                        print(imageName.storyVoiceSample)
                        if imageName.storyVoiceSample != nil{
                            playSound()
                        }
                    }
            }
//            Text(imageName.name!).frame(width: width-100, height: 60).background(Color.AppPrimaryColor).foregroundColor(Color.black).cornerRadius(10)
//                .offset(y:-30).onTapGesture {
////                     title=storyName
//                    print(imageName.id)
//                    selectd_story_page_MenuID=imageName.id
//                    selectdMenuID=imageName.id
//                    isSignIn=true
//                }
//            if BackageHight > 200{
//            ZStack{
//                Color.white.opacity(0.5)
//            VStack{
//                Text(imageName.name!).font(.system(size: 16, weight: .black, design: .rounded)).foregroundColor(.white)
//               .padding(10)
//                Spacer()
//                Text(" ???????????? ?????????? ???? ?????????? ???? ?????? ??????????")
//                Spacer()
//            }
//            }.frame(width: width*0.7, height:BackageHight*0.8).foregroundColor(Color.black).cornerRadius(10)
//            .onTapGesture {
////                     title=storyName
//
//                if imageName.isSubscribed ?? false{
//                print(imageName.id)
//                selectd_story_page_MenuID=imageName.id
//                selectdMenuID=imageName.id
//                        print(imageName.storyQuestionsList)
//                    story_Questions_List=imageName.storyQuestionsList ?? []
//print(story_Questions_List)
//                    isSignIn=true
//                }
//            }
//            }
        }.frame(width: width, height: BackageHight).background(Color.white).cornerRadius(20)
       
            
       
//        }
        
    }
    
   
    func stopSound(){
        if ((player?.isPlaying) != nil) {
            player!.stop()
        }
    }
    func playSound(){
        if ((player?.isPlaying) != nil) {
            stopSound()
        }
//        storyVoiceSample
        let radioURL = "\(AppBase)\(imageName.storyVoiceSample!.replacingOccurrences(of: "\\", with: ""))"
        let urlstring = radioURL
        let url = NSURL(string: urlstring)
        print("the url = \(url!)")
        downloadFileFromURL(url: url!)
    }
    func downloadFileFromURL(url:NSURL){
print(url)
        var downloadTask:URLSessionDownloadTask
        downloadTask = URLSession.shared.downloadTask(with: url as URL, completionHandler: {(URL, response, error) -> Void in
            self.play(url: URL as! NSURL)
        })
        downloadTask.resume()
    }
    func play(url:NSURL) {
        print("playing \(url)")
        do {
            player = try AVAudioPlayer(contentsOf: url as URL)
            player!.volume = 1.0
            player!.play()
        } catch let error as NSError {
            //self.player = nil
            print(error.localizedDescription)
        } catch {
            print("AVAudioPlayer init failed")
        }
        
    }
//
}

struct RemoteImage: View {
   private enum LoadState {
       case loading, success, failure
   }

   private class Loader: ObservableObject {
       var data = Data()
       var state = LoadState.loading

       init(url: String) {
           guard let parsedURL = URL(string: url) else {
               fatalError("Invalid URL: \(url)")
           }

//        if (imageCache.object(forKey:  "\(AppImageBase)"+url as NSString)) != nil {
//            self.data  = (imageCache.object(forKey:  "\(AppImageBase)"+url as NSString))! as Data
//        }
//        else{
            URLSession.shared.dataTask(with: parsedURL) { data, response, error in
                if let data = data, data.count > 0 {
                    self.data = data
//                    imageCache.setObject(self.data as NSData, forKey: ("\(AppImageBase)"+url) as NSString )
//                    imageCache.setObject(self.data as NSData, forKey: (url as NSString))
                    self.state = .success
                } else {
                    self.state = .failure
                }

                DispatchQueue.main.async {
                    self.objectWillChange.send()
                }
            }.resume()
//        }
          
       }
   }

   @StateObject private var loader: Loader
   var loading: Image
   var failure: Image

   var body: some View {
       selectImage()
           .resizable()
   }

   init(url: String, loading: Image = Image(systemName: "photo"), failure: Image = Image(systemName: "multiply.circle")) {
       _loader = StateObject(wrappedValue: Loader(url: url))
       self.loading = loading
       self.failure = failure
   }

   private func selectImage() -> Image {
       switch loader.state {
       case .loading:
           return loading
       case .failure:
           return failure
       default:
           if let image = UIImage(data: loader.data) {
               return Image(uiImage: image)
           } else {
               return failure
           }
       }
   }
}
