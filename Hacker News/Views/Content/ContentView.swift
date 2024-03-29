//
//  ContentView.swift
//  Hacker News
//
//  Created by Jacob Scase on 25/11/2020.
//

import SwiftUI


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithOpaqueBackground()
        // Changes navbar color
        coloredAppearance.backgroundColor = .black
        coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor.yellow]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.yellow]
        
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        
        
        return true
    }
    
}


struct ContentView: View {
    
    @Environment(\.openURL) var openURL
    
    @EnvironmentObject var networkManager:NetworkManager
    
    var body: some View {
        NavigationView {
            if networkManager.posts.count != 0{
                List(networkManager.posts){ post in
                    HStack {
                        Text(String(post.points))
                        if post.url != nil{
                            NavigationLink(
                                destination: OpenedLinkView(
                                    post: post,
                                    postURLString: post.url,
                                    commentsURL: ContentView.getCommentsUrl(objectID: post.objectID),
                                    title: post.title
                                    
                                ),
                                label: {
                                    ContentViewPostLabel(post:post)
                                })
                        }else{
                            NavigationLink(
//                                destination:  CommentsView(post: post, postBackgroundColor: Color.random),
                                destination:OpenedLinkView(
                                    post: post,
                                    postURLString: post.url,
                                    commentsURL: ContentView.getCommentsUrl(objectID: post.objectID),
                                    title: post.title
                                    
                                ),
                                label: {
                                    ContentViewPostLabel(post:post)
                                })
                        }
                        
                        
                    }
                }
                .navigationBarTitle("News")
               
        }else{
            ProgressView()
                .onAppear(perform: {
                    self.networkManager.fetchData()
                })
                .navigationBarTitle("News")
        
        }
           
           
        }
        .edgesIgnoringSafeArea(.all)
        
    }
    
    
    
    func actionSheet(theurl: String) {
        guard let data = URL(string: theurl) else { return }
        let av = UIActivityViewController(activityItems: [data], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
    }
    
    
    static func getCommentsUrl(objectID: String) -> String {
        let baseUrl = "https://news.ycombinator.com/item?id="
        let combinedUrl = baseUrl+objectID
        //        let data = URL(string: combinedUrl)!
        return combinedUrl
    }
}

