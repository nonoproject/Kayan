//
//  SamopleRecourding.swift
//  Kayan
//
//  Created by Sandal on 08/10/1442 AH.
//

import SwiftUI

struct SamopleRecourding: View {
    @ObservedObject var audioRecorder: AudioRecorder
    var body: some View {
//        NavigationView {
            VStack {
                RecordingsList(audioRecorder: audioRecorder)
                Spacer()
                if audioRecorder.recording == false {
                    Button(action: {self.audioRecorder.startRecording(strory_page_record: "\(Date().toString(dateFormat: "dd-MM-YY 'at' HH:mm:ss"))")}) {
                        Image(systemName: "circle.fill")
                            .resizable()
                            
                            .frame(width: 70, height: 70)
                            .clipped()
                            .foregroundColor(.red)
                            .padding(.bottom, 40)
                    }
                } else {
                    Button(action: {
//                            self.audioRecorder.stopRecording()
                        
                    }) {
                        Image(systemName: "stop.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 70, height: 70)
                            .clipped()
                            .foregroundColor(.red)
                            .padding(.bottom, 40)
                    }
                }
            }
            
    }
}

struct SamopleRecourding_Previews: PreviewProvider {
    static var previews: some View {
        SamopleRecourding(audioRecorder: AudioRecorder())
    }
}
