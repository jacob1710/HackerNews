//
//  ContentView.swift
//  Hacker News
//
//  Created by Jacob Scase on 25/11/2020.
//

import SwiftUI


struct ContentView: View {
    @Environment(\.openURL) var openURL
    @ObservedObject var networkManager = NetworkManager()
    
    var body: some View {
        NavigationView{
            List(networkManager.posts){ post in
                    HStack {
                        Text(String(post.points))
                        Text(post.title)
                            .onTapGesture{
                                openURL(URL(string: post.url!)!)
                            }
                            .onLongPressGesture {
                                actionSheet(theurl: post.url!)
                            }                        
                    }
            }
            .navigationBarTitle("News")
        }
        .onAppear(perform: {
            self.networkManager.fetchData()
        })
    }
    func actionSheet(theurl: String) {
        guard let data = URL(string: theurl) else { return }
            let av = UIActivityViewController(activityItems: [data], applicationActivities: nil)
            UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
