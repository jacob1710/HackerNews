//
//  WebContentView.swift
//  Hacker News
//
//  Created by Jacob Scase on 11/07/2021.
//

import SwiftUI
import WebKit

struct WebContentView: UIViewRepresentable {
    @State var urlString: String
    func makeUIView(context: Context) -> some UIView {
        let webView = WKWebView()
        let request = URLRequest(url: URL(string: urlString)!)
        webView.load(request)
        return webView
        
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
}

struct WebContentView_Previews: PreviewProvider {
    static var previews: some View {
        WebContentView(urlString: "https://www.google.co.uk")
    }
}
