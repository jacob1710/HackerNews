//
//  CommentJustTextView.swift
//  Hacker News
//
//  Created by Jacob Scase on 03/08/2021.
//

import SwiftUI

struct CommentJustTextView: View {
    var unwrappedText: String
    var postBackgroundColor: Color
    var commentParentID:Int?
    var hasChildren:Bool
    var body: some View {
        ZStack {
            if hasChildren{
                Rectangle()
                    .foregroundColor(commentParentID == nil ? .blue:postBackgroundColor)
                    .cornerRadius(10)
                    
            }else{
                Rectangle()
                    .foregroundColor(commentParentID == nil ? .blue:postBackgroundColor)
                    .cornerRadius(10)
            }
           
            Text(unwrappedText)
                .foregroundColor(commentParentID == nil ? .white: CommentsView.getTextColor(postBackgroundColor))
                .padding()

        }
    }
}
