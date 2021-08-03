//
//  CommentsView.swift
//  Hacker News
//
//  Created by Jacob Scase on 12/07/2021.
//

import SwiftUI
import Pastel

struct CommentsView: View {
    var post:Post
    var postBackgroundColor: Color
    @EnvironmentObject var networkManager: NetworkManager
    var body: some View {
        if networkManager.comments.count != 0{
            if networkManager.comments[0].text == nil{
                if networkManager.comments[0].children?.count != 0{
                    List(networkManager.comments[0].children!,children: \.children){ comment in
    //                    Text(comment.text ?? "")
                        if let commentText = comment.text{
                            if let unwrappedText = commentText.trimHTMLTags(){
                                ZStack {
                                    Rectangle()
                                        .foregroundColor(postBackgroundColor)
                                        .cornerRadius(10)
                                    Text(unwrappedText.trimHTMLTags()!)
                                        .foregroundColor(getTextColor(postBackgroundColor))
                                        .padding()

                                }
                            }

                        }

                    }
                    .onAppear(perform: {
                        if post.id != String(networkManager.comments[0].id ?? 0){
                            //Different comment thread, need new comments
                            networkManager.fetchCommentsData(id: post.id)
                        }
                    })
                    
                }
            }else{
                if networkManager.comments[0].children?.count != 0{
                    List(networkManager.comments,children: \.children){ comment in

        //                    Text(comment.text ?? "")
                            if let commentText = comment.text{
                                if let unwrappedText = commentText.trimHTMLTags(){
                                    ZStack {
                                        Rectangle()
                                            .foregroundColor(comment.parent_id == nil ? .blue:postBackgroundColor)
                                            .cornerRadius(10)
                                        Text(unwrappedText.trimHTMLTags()!)
                                            .foregroundColor(comment.parent_id == nil ? .white:getTextColor(postBackgroundColor))
                                            .padding()

                                    }
                                }

                            }

                        }
                        .onAppear(perform: {
                            if post.id != String(networkManager.comments[0].id ?? 0){
                                //Different comment thread, need new comments
                                networkManager.fetchCommentsData(id: post.id)
                            }
                    })
                    
                }
            }
            
        }else{
            ProgressView()
                .onAppear(perform: {
                    networkManager.fetchCommentsData(id: post.id)
                })
            
        }
        
    }
    func getTextColor(_ color: Color) -> Color{
        if let red = color.cgColor?.components?[0], let green = color.cgColor?.components?[1], let blue = color.cgColor?.components?[2]{
            if (red*0.299 + green*0.587 + blue*0.114) * 255 > 186{
                return Color.black
            }else{
                return Color.white
            }
        }
        
        return Color.white
//
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

extension Color {
    static var random: Color {
        return Color(red: .random(in: 0...1),
                     green: .random(in: 0...1),
                     blue: .random(in: 0...1))
    }
}
