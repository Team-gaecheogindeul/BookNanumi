//
//  BookSharerApp.swift
//  BookSharer
//
//  Created by 최성빈 on 2023/06/30.
//

import SwiftUI
import FirebaseCore
import KakaoSDKCommon
import KakaoSDKAuth

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
    
    init() {
        // Kakao SDK 초기화
        KakaoSDK.initSDK(appKey: "b4dd2e153d1188907d7559b5b31e6460")
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
                    .environmentObject(viewModel)
                    .onOpenURL { url in // 뷰가 속한 Window에 대한 URL을 받았을 때 호출할 Handler를 등록하는 함수카카오 로그인을 위해 웹 혹은 카카오톡 앱으로 이동 후 다시 앱으로 돌아오는 과정을 거쳐야하므로, Handler를 추가로 등록해줌
                        if AuthApi.isKakaoTalkLoginUrl(url) {
                            _ = AuthController.handleOpenUrl(url: url)
                        }
                    }
            }
        }
    }
}
