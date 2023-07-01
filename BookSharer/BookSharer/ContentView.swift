//
//  ContentView.swift
//  BookSharer
//
//  Created by 최성빈 on 2023/06/30.
//

import SwiftUI

struct ContentView: View {
    @State private var selection = 0
    var body: some View {
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
