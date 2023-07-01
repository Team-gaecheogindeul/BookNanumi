//
//  UserProfileView.swift
//  BookSharer
//
//  Created by 최성빈 on 2023/06/30.
//

import SwiftUI

struct UserProfileView: View {
    var body: some View {
        VStack {
            //상단바
            UPVTopbar()
            Divider()
            
            //미니 프로필
            MiniUserProfile()
            Divider()
            
            // 유저 등급
            UserGrade()
            Divider()
            
            // 내역
            Breakdown()
            Spacer()
        }

    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}
