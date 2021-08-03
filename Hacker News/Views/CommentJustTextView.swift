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
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(commentParentID == nil ? .blue:postBackgroundColor)
                .cornerRadius(10)
            Text(unwrappedText)
                .foregroundColor(commentParentID == nil ? .white: CommentsView.getTextColor(postBackgroundColor))
                .padding()

        }
    }
}
