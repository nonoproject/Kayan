//
//  sandalLoadingIndicater.swift
//  Kayan
//
//  Created by mohammed aburukbah on 17/09/1442 AH.
//

import SwiftUI

struct sandalLoadingIndicater: View {
    let timer=Timer.publish(every: 0.6, on: .main, in: .common).autoconnect()
    @State var leftOfset:CGFloat = -100
    @State var rightOfset:CGFloat = 100
    @State var minOpacity:Double = 0.2
    @State var maxOpacity:Double = 1
    var body: some View {
        ZStack{
            Circle().fill(Color.Appliver).frame(width: 20, height: 20).offset(x:leftOfset).opacity(minOpacity).animation(Animation.easeInOut(duration: 1).delay(0))
            Circle().fill(Color.Appliver).frame(width: 20, height: 20).offset(x:leftOfset).opacity(minOpacity).animation(Animation.easeInOut(duration: 1).delay(0.2))
            Circle().fill(Color.Appliver).frame(width: 20, height: 20).offset(x:leftOfset).opacity(minOpacity).animation(Animation.easeInOut(duration: 1).delay(0.4))
            
        }.onReceive(timer) { (r) in
            swap(&self.leftOfset, &self.rightOfset)
            swap(&self.minOpacity, &self.maxOpacity)
        }
    }
}

struct sandalLoadingIndicater_Previews: PreviewProvider {
    static var previews: some View {
        sandalLoadingIndicater()
    }
}
