//
//  CommentTextView.swift
//  Hacker News
//
//  Created by Jacob Scase on 01/08/2021.
//

import SwiftUI

struct CommentTextView: UIViewRepresentable{
    @EnvironmentObject var postManager: PostManager
    var htmlText: String
    var textView = UITextView()
    
    func makeUIView(context: Context) -> some UITextView {
        
        textView.isEditable = false
        
        
        return textView
        
    }
    func updateUIView(_ textView: UIViewType, context: Context) {
        textView.attributedText = postManager.addStyling(htmlText)
        textView.textContainer.heightTracksTextView = true
        textView.textContainer.size.width = 200
        textView.isScrollEnabled = true
        textView.isScrollEnabled = false
        
        
//        textView.heightAnchor.constraint(equalToConstant: textView.calculateViewHeightWithCurrentWidth()).isActive = true

        

//        textView.scrollRectToVisible(CGRect(x: 0, y: 0, width: 1, height: 1), animated: false)
    }
    
    func calcViewHeight() {
        textView.contentSize.height = textView.calculateViewHeightWithCurrentWidth()
    }
}

extension UITextView {
    // Note: This will trigger a text rendering!
    func calculateViewHeightWithCurrentWidth() -> CGFloat {
        let textWidth = self.frame.width -
        self.textContainerInset.left -
        self.textContainerInset.right -
        self.textContainer.lineFragmentPadding * 2.0 -
        self.contentInset.left -
        self.contentInset.right

        let maxSize = CGSize(width: textWidth, height: CGFloat.greatestFiniteMagnitude)
        var calculatedSize = self.attributedText.boundingRect(with: maxSize,
                                                              options: [.usesLineFragmentOrigin, .usesFontLeading],
                                                                      context: nil).size
        calculatedSize.height += self.textContainerInset.top
        calculatedSize.height += self.textContainerInset.bottom

        return ceil(calculatedSize.height)
    }
}
