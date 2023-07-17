//
//  ContentView.swift
//  BookSharer
//
//  Created by 최성빈 on 2023/06/30.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @EnvironmentObject var viewModel: ViewModel
    
    
    var body: some View {
        VStack {
            if viewModel.state == .signedIn {
                MainView()
            } else {
                SignInView()
                    .environmentObject(viewModel)
            }
        }
        .onAppear {
            if Auth.auth().currentUser != nil {
                viewModel.state = .signedIn
            }
        }
    }
}

struct MainView: View {
    @State private var selection = 0
    
    var body: some View {
        NavigationStack {
            TabView(selection: $selection) {
                //나눔 뷰
                ShareView()
                    .tabItem {
                        if (selection == 0) {
                            Image(systemName: "house")
                        }
                        Image(systemName: "house")
                            .environment(\.symbolVariants, .none)
                        // 탭바 채워진 색 없애기
                      }
                    .tag(0)
                
                //채팅 리스트 뷰
                ChattingView()
                    .tabItem {
                        if (selection == 1) {
                            Image(systemName: "message")
                        }
                        Image(systemName: "message")
                            .environment(\.symbolVariants, .none)
                    }
                    .tag(1)
                
                //프로필 뷰
                UserProfileView()
                    .tabItem {
                        if (selection == 2) {
                            Image(systemName: "person")
                        }
                        Image(systemName: "person")
                            .environment(\.symbolVariants, .none)
                    }
                    .tag(2)
            }
            .accentColor(.black)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static let viewModel = ViewModel()
    
    static var previews: some View {
        ContentView()
            .environmentObject(viewModel)
    }
}
