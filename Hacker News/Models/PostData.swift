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
    let url: String
    
}
