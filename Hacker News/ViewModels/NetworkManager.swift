//
//  NetworkManager.swift
//  Hacker News
//
//  Created by Jacob Scase on 25/11/2020.
//

import Foundation

class NetworkManager: ObservableObject {
    
    @Published var posts = [Post]()
    @Published var comments = [Comments]()
    @Published var currentPostID: String?
    
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
    
    func fetchCommentsData(id: String){
        currentPostID = id
        if let url = URL(string: Constants.postUrl+id){
            var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
            
            urlRequest.httpMethod = "GET"
            
            let session = URLSession.shared
            
            let dataTask = session.dataTask(with: urlRequest) { data, response, error in
                if error == nil{
                    do {
                        let jsonDecoder = JSONDecoder()
                        let result = try jsonDecoder.decode(Comments.self, from: data!)
                        DispatchQueue.main.async {
                            self.comments = [result]
                        }
                        
                    } catch {
                        print("Error in parsing the json")
                    }
                }else{
                    print("Error with retrieving data")
                }
            }
            dataTask.resume()
        }
    }
}
