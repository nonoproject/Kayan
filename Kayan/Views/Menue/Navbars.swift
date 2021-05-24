//
//  Navbars.swift
//  Kayan
//
//  Created by Awad sandal on 01/04/2021.
//

import SwiftUI

struct Navbars: View {
    @AppStorage("isLogin") var isLogin: Bool = VarUserDefault.SysGlobalData.getGlobalBool(key: VarUserDefault.SysGlobalData.isLogin)
    @State var isHome:Bool=false
    @State var isBackPressed:Bool=false
    
    @State var x_view_to_move:AnyView=AnyView(Home())
    @State var page_titel:String
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    
    var body: some View {
        HStack(spacing:15){
            
            Image("logout").resizable().frame(width: 46, height: 46).padding(.leading,20).onTapGesture {
                isLogin = false
            }
           if !isHome {
            NavigationLink(destination: x_view_to_move.navigationBarTitle(Text("Home"))
                    .navigationBarHidden(true), isActive: self.$isBackPressed) {}.hidden()

                Image("home").resizable().frame(width: 46, height: 46).onTapGesture {
                                        self.presentationMode.wrappedValue.dismiss()
                    isBackPressed=true
//                    self.presentationMode.wrappedValue.dismiss()
//                    self.mode.wrappedValue.dismiss()
//                    self.prresentationMode.wrappedValue.dismiss()
                }
            }
            Spacer()
            Text(page_titel).font(.system(size: 18, weight: .semibold, design: .monospaced))
            Spacer()
            Image(systemName:"heart.circle.fill").resizable().backgroundFill(Color.red) .clipShape(Circle()).foregroundColor(.white).frame(width: 46, height:46)
            Image("profile").resizable().frame(width: 46, height: 46).padding(.trailing,20)
            
        }.frame(height:55).background(Color.AppPrimaryColor)

    }
}
//
//struct Navbars_Previews: PreviewProvider {
//    static var previews: some View {
//        Navbars()
//    }
//}
