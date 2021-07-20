//
//  OpenedLinkView.swift
//  Hacker News
//
//  Created by Jacob Scase on 11/07/2021.
//

import SwiftUI

struct OpenedLinkView: View {
    @Environment(\.openURL) var openURL
    var postURLString: String?
    var commentsURL: String
    @State var title: String
    @State var url: String?
    @State var webContentView: WebContentView?
    var body: some View {
            VStack{
                ZStack{
                    Text(String(url ?? "url"))
                }
                webContentView                
                ZStack{
                    Rectangle()
                        .frame(height: 30, alignment: .center)
                        .foregroundColor(.black)
                    HStack(spacing: 10){
                        Button{
                            webContentView?.activateBackButton()
                        } label: {
                                Image(systemName: "arrow.backward")
                                    .resizable()
                                    .frame(width: 25, height: 25, alignment: .center)
                                    .scaledToFit()
                                    .foregroundColor(.white)
                           
                        }
                        .padding(EdgeInsets(top: 5, leading: 30, bottom: 0, trailing: 30))
                        
                        NavigationLink(
                            destination: CommentsView(urlString: commentsURL),
                            label: {
                                Image(systemName: "text.bubble")
                                    .resizable()
                                    .frame(width: 25, height: 25, alignment: .center)
                                    .scaledToFit()
                                    .foregroundColor(.white)
                            })
                            .padding(EdgeInsets(top: 5, leading: 30, bottom: 0, trailing: 30))
                       
                        Button{
                            openURL(URL(string: postURLString ?? commentsURL)!)
                        } label: {
                            Image(systemName: "globe")
                                .resizable()
                                .frame(width: 25, height: 25, alignment: .center)
                                .scaledToFit()
                                .foregroundColor(.white)
                        }
                        .padding(EdgeInsets(top: 5, leading: 30, bottom: 0, trailing: 30))
                        Button{
                            webContentView?.activateForwardButton()
                        } label: {
                                Image(systemName: "arrow.forward")
                                    .resizable()
                                    .frame(width: 25, height: 25, alignment: .center)
                                    .scaledToFit()
                                    .foregroundColor(.white)
                            
                        }
                        .padding(EdgeInsets(top: 5, leading: 30, bottom: 0, trailing: 30))
                    }
                }
            }
            .navigationBarTitle(title)
    }
    
       
}

struct OpenedLinkView_Previews: PreviewProvider {
    static var previews: some View {
        OpenedLinkView(postURLString: "https://www.google.co.uk", commentsURL: "https://www.google.co.uk", title: "Google")
    }
}
