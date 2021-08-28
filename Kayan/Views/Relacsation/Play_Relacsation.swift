//
//  Play_Relacsation.swift
//  Kayan
//
//  Created by Sandal on 14/10/1442 AH.
//

import SwiftUI
import AVKit
struct PlayRelacsation:View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var play:Bool = true
    
    @State var url_play_vedio:String
    var body: some View{
        ZStack(alignment:.top){
            if play{
            Play_Relacsation(videoURL:URL(string: url_play_vedio))
            }
            HStack{
                Button(action: {
                    play=false
                    self.presentationMode.dismiss()
                }){
                    Image(systemName: "chevron.left") // set image here
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.white)
                     
                    
                }.frame(width: 40,height: 40).background(Color.Appliver).zIndex(10)
    //            BackButton().frame(width: 40,height: 40).background(Color.red)
                Spacer()
            }
        }.ignoresSafeArea().ignoresSafeArea(.all, edges: .all)
    }
}

struct Play_Relacsation: UIViewControllerRepresentable {
    var videoURL: URL?
    private var player: AVPlayer {
        return AVPlayer(url: videoURL!)
    }


    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller =  AVPlayerViewController()
        controller.modalPresentationStyle = .fullScreen
        controller.player = player
        controller.showsPlaybackControls=true
        controller.player?.play()
        return controller
    }

    func updateUIViewController(_ playerController: AVPlayerViewController, context: Context) {

    }
}


