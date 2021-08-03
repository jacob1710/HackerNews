//
//  ContentViewPostLabel.swift
//  Hacker News
//
//  Created by Jacob Scase on 03/08/2021.
//

import SwiftUI

struct ContentViewPostLabel: View {
    
    @Environment(\.openURL) var openURL

    var post:Post
    var body: some View {
        Text(post.title)
            .contextMenu {
                Button {
                    openURL(URL(string: ContentView.getCommentsUrl(objectID: post.objectID))!)
                } label: {
                    Label("View Comments", systemImage: "text.bubble")
                }
                Button {
                    openURL(URL(string: post.url!)!)
                } label: {
                    Label("Open in Browser", systemImage: "globe")
                }
                
            }
    }
}
