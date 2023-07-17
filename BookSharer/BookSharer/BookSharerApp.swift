//
//  BookSharerApp.swift
//  BookSharer
//
//  Created by 최성빈 on 2023/06/30.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct BookSharerApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var viewModel: ViewModel = ViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
                    .environmentObject(viewModel)
            }
        }
    }
}
