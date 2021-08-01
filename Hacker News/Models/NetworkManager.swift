//
//  NetworkManager.swift
//  Hacker News
//
//  Created by Jacob Scase on 25/11/2020.
//

import Foundation

class NetworkManager: ObservableObject {
    
    @Published var posts = [Post]()
    
    func fetchData(){
        if let url = URL(string: Constants.frontPageUrl){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error == nil{
                    let decoder = JSONDecoder()
                    if let safeData = data{
                        do {
                            let results = try decoder.decode(Results.self, from: safeData)
                            DispatchQueue.main.async {
                                self.posts = results.hits
                                
                            }
                        } catch {
                            print(error)
                        }
                        
                    }
                }
            }
            task.resume()
        }
    }
}
