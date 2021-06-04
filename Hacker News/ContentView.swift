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
    @ObservedObject var networkManager = NetworkManager()
    init() {
//        UIView.appearance().backgroundColor = UIColor.red
//        UINavigationBar.appearance().backgroundColor = UIColor.red

    }
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
                            .contextMenu {
                                    Button {
                                        openURL(getCommentsUrl(objectID: post.objectID))
                                    } label: {
                                        Label("View Comments", systemImage: "globe")
                                    }

                                    Button {
                                        print("Enable geolocation")
                                    } label: {
                                        Label("Detect Location", systemImage: "location.circle")
                                    }
                                }
                    }
            }
            .navigationBarTitle("News")
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear(perform: {
            self.networkManager.fetchData()
        })
    }
    func actionSheet(theurl: String) {
        guard let data = URL(string: theurl) else { return }
            let av = UIActivityViewController(activityItems: [data], applicationActivities: nil)
            UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
    }
    func getCommentsUrl(objectID: String) -> URL {
        let baseUrl = "https://news.ycombinator.com/item?id="
        let combinedUrl = baseUrl+objectID
        let data = URL(string: combinedUrl)!
        return data
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
