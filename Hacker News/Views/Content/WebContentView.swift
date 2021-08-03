//
//  WebContentView.swift
//  Hacker News
//
//  Created by Jacob Scase on 11/07/2021.
//

import SwiftUI
import WebKit

struct WebContentView: UIViewRepresentable {
    @State var webView = WKWebView()
    @State var urlString: String
    func makeUIView(context: Context) -> some UIView {
        let request = URLRequest(url: URL(string: urlString)!)
        webView.load(request)
        webView.allowsBackForwardNavigationGestures = true
        webView.allowsLinkPreview = true
        return webView
        
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
    
    func activateBackButton(){
        webView.goBack()
    }
    
    func activateForwardButton(){
        webView.goForward()
    }
    
}
