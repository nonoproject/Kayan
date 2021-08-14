//
//  payment_WebView.swift
//  Kayan
//
//  Created by Sandal on 04/01/1443 AH.
//

import SwiftUI
import WebKit

struct payment_WebView: UIViewRepresentable {
    let request: URLRequest

//    let webView: WKWebView
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
          uiView.load(request)
      }
}
