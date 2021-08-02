//
//  PostManager.swift
//  Hacker News
//
//  Created by Jacob Scase on 01/08/2021.
//

import Foundation

class PostManager: ObservableObject{
    
    var styleData: Data?
    @Published var commentText = NSAttributedString()
    
    func addStyling(_ htmlString: String) -> NSAttributedString{
        
        let styleUrl = Bundle.main.url(forResource: "style", withExtension: "html")
        
        
        do {
            let styleData = try Data(contentsOf: styleUrl!)
            self.styleData = styleData
        } catch {
            print(error)
        }
        
        
        var resultString = NSAttributedString()
        var data = Data()
        
        if styleData != nil{
            data.append(styleData!)
        }
        
        data.append(Data(htmlString.utf8))
        
        if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil){
            resultString = attributedString
        }
        
        return resultString
        
    }
}
