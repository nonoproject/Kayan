//
//  Navbars.swift
//  Kayan
//
//  Created by Awad sandal on 01/04/2021.
//

import SwiftUI

struct Navbars: View {
    @AppStorage("isLogin") var isLogin: Bool = VarUserDefault.SysGlobalData.getGlobalBool(key: VarUserDefault.SysGlobalData.isLogin)
    @State var isFavorate:Bool=false
    @State var isProfile:Bool=false
    @State var isHome:Bool=false
    @State var isBackPressed:Bool=false
    
    @State var isGoToFavoratePressed:Bool=false
    @State var isGoToProfilePressed:Bool=false
    
    @State var profile_view_to_move:AnyView=AnyView(Setting())
    @State var x_view_to_move:AnyView=AnyView(Home())
    @State var Favorate_view_to_move:AnyView=AnyView(Favorate())
    @State var page_titel:String
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    
    var body: some View {
        HStack(spacing:15){
            
            Image("logout").resizable().frame(width: 46, height: 46).padding(.leading,20).onTapGesture {
                isLogin = false
            }
            if !isFavorate{
            NavigationLink(destination: Favorate_view_to_move.navigationBarTitle(Text("Home"))
                    .navigationBarHidden(true), isActive: self.$isGoToFavoratePressed) {}.hidden()
            }
            if !isProfile{
            NavigationLink(destination: profile_view_to_move.navigationBarTitle(Text("Home"))
                    .navigationBarHidden(true), isActive: self.$isGoToProfilePressed) {}.hidden()
            }
           if !isHome {
            
            NavigationLink(destination: x_view_to_move.navigationBarTitle(Text("Home"))
                           
                    .navigationBarHidden(true).statusBar(hidden: true), isActive: self.$isBackPressed) {}.hidden()

                Image("home").resizable().frame(width: 46, height: 46).onTapGesture {
//                                        self.presentationMode.wrappedValue.dismiss()
                    isBackPressed=true
                    PlayAppSound().AppPlayAppSound()
//                    self.presentationMode.wrappedValue.dismiss()
//                    self.mode.wrappedValue.dismiss()
//                    self.prresentationMode.wrappedValue.dismiss()
                }
            }
            Spacer()
            Text(page_titel)//.font(.system(size: 18, weight: .semibold, design: .monospaced))
                
//                .font(.custom("Sukar black"),size:18)
            Spacer()
            if !isFavorate{
            Image(systemName:"heart.circle.fill").resizable().backgroundFill(Color.red) .clipShape(Circle()).foregroundColor(.white).frame(width: 46, height:46)
                .onTapGesture {
                    PlayAppSound().AppPlayAppSound()
                    self.presentationMode.wrappedValue.dismiss()
                    isGoToFavoratePressed=true
                    
                }
            }
            if !isProfile{
                Image("profile").resizable().frame(width: 46, height: 46).padding(.trailing,20)
                .onTapGesture {
                    PlayAppSound().AppPlayAppSound()
                    self.presentationMode.wrappedValue.dismiss()
                    isGoToProfilePressed=true
                    
                }
            }
//            Image("profile").resizable().frame(width: 46, height: 46).padding(.trailing,20)
            
        }.frame(height:55).background(Color.AppPrimaryColor)

    }
}
//
//struct Navbars_Previews: PreviewProvider {
//    static var previews: some View {
//        Navbars()
//    }
//}
