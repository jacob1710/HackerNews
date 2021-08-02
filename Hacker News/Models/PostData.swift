//
//  PostData.swift
//  Hacker News
//
//  Created by Jacob Scase on 25/11/2020.
//

import Foundation

struct Results: Decodable {
    let hits: [Post]
}

struct Post: Decodable, Identifiable {
    var id: String {
        return objectID
    }
    let objectID: String
    let points: Int
    let title: String
    let url: String?
    
}

struct Comments: Decodable, Identifiable{
    var id: Int?
    var created_at: String?
    var type: String?
    var author: String?
    var text: String?
    var parent_id: Int?
    var story_id: Int?
    var children: [Comments]?
}
