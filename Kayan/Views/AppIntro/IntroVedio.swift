//
//  IntroVedio.swift
//  Kayan
//
//  Created by Sandal on 03/11/1442 AH.
//

import SwiftUI
import AVKit
struct IntroVedio: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var play:Bool = true
    var body: some View{
        ZStack{
            if play{
            Play_IntroVedio(videoURL:URL(string:"http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4"))
            }
            VStack{
                Button(action: {
                    play=false
                    self.presentationMode.dismiss()
                }){
                    Image(systemName: "chevron.right") // set image here
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.AppPrimaryColor)
                }.frame(width: 40,height: 40).background(Color.red)
    //            BackButton().frame(width: 40,height: 40).background(Color.red)
                Spacer()
            }
        }.ignoresSafeArea().ignoresSafeArea(.all, edges: .all)
    }
}
struct Play_IntroVedio: UIViewControllerRepresentable {
    var videoURL: URL?
    private var player: AVPlayer {
        return AVPlayer(url: videoURL!)
    }


    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller =  AVPlayerViewController()
        controller.modalPresentationStyle = .fullScreen
        controller.player = player
        controller.showsPlaybackControls=false
        controller.player?.play()
        return controller
    }

    func updateUIViewController(_ playerController: AVPlayerViewController, context: Context) {

    }
}

