//
//  UserProfileView.swift
//  BookSharer
//
//  Created by 최성빈 on 2023/06/30.
//

import SwiftUI

struct UserProfileView: View {
    @EnvironmentObject var viewModel: ViewModel
    @State private var isNotLoggedIn = false
    
    var body: some View {
        VStack {
            //상단바
            UPVTopbar()
            Divider()
            
            //미니 프로필
            MiniUserProfile()
                .environmentObject(viewModel)
            Divider()
            
            // 유저 등급
            UserGrade()
            Divider()
            
            // 내역
            Breakdown()
            Spacer()
            
            Button {
                isNotLoggedIn = true
                viewModel.signOut()
            } label: {
                Text("로그아웃")
            }
            .fullScreenCover(isPresented: $isNotLoggedIn) {
                ContentView() // LoginView로 전환
            }

        }

    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}
