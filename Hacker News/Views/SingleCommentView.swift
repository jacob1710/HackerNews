//
//  SingleCommentView.swift
//  Hacker News
//
//  Created by Jacob Scase on 02/08/2021.
//

import SwiftUI

struct SingleCommentView: View {
    var comments: Comments
    var postManager = PostManager()
    var body: some View {
        if comments.text != ""{
//            Group{
//                CommentTextView(htmlText: comments.text ?? "")
//                    .environmentObject(PostManager())
//                if comments.children?.count != 0{
//                    ForEach(comments.children!){comment in
//                        SingleCommentView(comments: comment)
//                    }
//                   
//                }
//            }
                Section(
                    header: Text(comments.created_at ?? "")
//                        Text(postManager.addStyling(comments.text ?? "").string)
//                        CommentTextView(htmlText: comments.text ?? "")
//                        .frame(minWidth: 0, maxWidth: geo.size.width, minHeight: 0, maxHeight: .infinity)
    //                    .border(Color.blue)
                        .environmentObject(postManager)
                    
                ) {
                    if comments.children?.count != 0{
                        OutlineGroup(comments.children ?? [],
                                 id: \.id,
                                 children: \.children
                    ) { tree in
                            Text(postManager.addStyling(tree.text ?? "").string)
//                        CommentTextView(htmlText: tree.text ?? "")
//                            .frame(minWidth: 0, maxWidth: geo.size.width, minHeight: 0, maxHeight: .infinity)
    //                        .border(Color.blue)
                            .environmentObject(postManager)

                    }

                    }
                }
        }
    }
}
