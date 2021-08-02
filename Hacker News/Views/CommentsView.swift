//
//  CommentsView.swift
//  Hacker News
//
//  Created by Jacob Scase on 12/07/2021.
//

import SwiftUI

struct CommentsView: View {
    var post:Post
    @EnvironmentObject var networkManager: NetworkManager
    var body: some View {
        if networkManager.comments.count != 0{
            if networkManager.comments[0].children?.count != 0{
                List(networkManager.comments[0].children!,children: \.children){ comment in
    //                Text(comment.text?.utf8)
                    if let commentText = comment.text{
                        Text(commentText.trimHTMLTags() ?? "")
                    }
    //                Text(comment.text?.trimHTMLTags() ?? "")
    //                CommentTextView(htmlText: comment.text ?? "")
    //                    .environmentObject(PostManager())


                }
                .onAppear(perform: {
                    if post.id == String(networkManager.comments[0].id ?? 0){
                        //Same comment thread as last time
                        print("Is Equal ID")
                        print(networkManager.comments[0].children?[0])
                    }else{
                        //Different thread, need new comments
                        networkManager.fetchCommentsData(id: post.id)
                        print(networkManager.comments[0].children?[0])
                    }
                })
            }
            
//                ScrollView {
//                    ForEach(networkManager.comments){ comment in
//                        Section(
//                            header:  CommentTextView(htmlText: comment.text ?? "")
//                                .environmentObject(PostManager())
//                                .padding()
//                        ) {
//                            OutlineGroup(comment.children ?? [],
//                                         id: \.id,
//                                         children: \.children
//                            ) { tree in
//                                CommentTextView(htmlText: tree.text ?? "")
//                                                    .environmentObject(PostManager())
//                                    .padding()
//
//                            }
//                        }
//                    }
//                }
//
//
        }else{
            ProgressView()
                .onAppear(perform: {
                    networkManager.fetchCommentsData(id: post.id)
                })
            
        }
//        WebContentView(urlString:urlString)
        
        
    }
}


extension String {

    public func trimHTMLTags() -> String? {
        guard let htmlStringData = self.data(using: String.Encoding.utf8) else {
            return nil
        }
        
        let options: [NSAttributedString.DocumentReadingOptionKey : Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        let attributedString = try? NSAttributedString(data: htmlStringData, options: options, documentAttributes: nil)
        return attributedString?.string
    }
    
}
