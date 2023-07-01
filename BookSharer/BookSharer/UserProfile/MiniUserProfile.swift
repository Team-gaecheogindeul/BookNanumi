//
//  MiniUserProfile.swift
//  BookSharer
//
//  Created by 최성빈 on 2023/06/30.
//

import SwiftUI

struct MiniUserProfile: View {
    var body: some View {
        HStack {
            Image(systemName: "person.crop.circle")
                .frame(width: 80.0, height: 80.0)
            .font(.system(size: 52))
            Text("닉네임")
                .fontWeight(.semibold)
                .font(.system(size: 24))
            Spacer()
            Button {
                //프로필 관리
            } label: {
                Text("프로필 관리")
                    .font(.system(size: 12))
                    .frame(width: 84.0, height: 24.0)
                    .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.black, lineWidth: 1)
                    )
            }
            .padding(.trailing, 16.0)
            .accentColor(.black)

        }
    }
}

struct MiniUserProfile_Previews: PreviewProvider {
    static var previews: some View {
        MiniUserProfile()
    }
}
