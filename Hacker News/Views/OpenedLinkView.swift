//
//  OpenedLinkView.swift
//  Hacker News
//
//  Created by Jacob Scase on 11/07/2021.
//

import SwiftUI

struct OpenedLinkView: View {
    @Environment(\.openURL) var openURL
    var postURLString: String
    var commentsURL: URL
    var title: String
    var body: some View {
        VStack{
            WebContentView(urlString: postURLString)
            ZStack{
                Rectangle()
                    .frame(height: 30, alignment: .center)
                    .foregroundColor(.gray)
                    .ignoresSafeArea()
                HStack(spacing: 30){
                    Button {
                        openURL(commentsURL)
                        
                    } label: {
                        Image(systemName: "text.bubble")
                            .resizable()
                            .frame( width: 25, height: 25, alignment: .center)
                            .scaledToFit()
                            .foregroundColor(.white)
                    }
                    .padding()
                    Spacer()
                    Button {
                        openURL(URL(string: postURLString)!)
                    } label: {
                        Image(systemName: "globe")
                            .resizable()
                            .frame( width: 25, height: 25, alignment: .center)
                            .scaledToFit()
                            .foregroundColor(.white)
                    }
                    .padding()
                }
            }
        }
        .navigationBarTitle("Testing", displayMode: .inline)
    }
}

struct OpenedLinkView_Previews: PreviewProvider {
    static var previews: some View {
        OpenedLinkView(postURLString: "https://www.google.co.uk", commentsURL: URL(string: "https://www.google.co.uk")!, title: "Google")
    }
}
