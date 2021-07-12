//
//  CommentsView.swift
//  Hacker News
//
//  Created by Jacob Scase on 12/07/2021.
//

import SwiftUI

struct CommentsView: View {
    var urlString: String
    var body: some View {
        WebContentView(urlString:urlString)
    }
}

