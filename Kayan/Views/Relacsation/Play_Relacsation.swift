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
    var body: some View{
        ZStack{
            if play{
            Play_Relacsation(videoURL:URL(string: "\(AppBase)/ClibsPath/ed2f09aa-f15b-484c-a695-6c25623e1a43.mp4"))
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

