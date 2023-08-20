//
//  UserGrade.swift
//  BookSharer
//
//  Created by 최성빈 on 2023/07/01.
//

import SwiftUI

struct UserGrade: View {
    var body: some View {
        HStack(spacing: 16) {
            Image("Seed")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 58, height: 88)
            VStack(alignment: .leading, spacing: 12) {
                Text("새싹나누미")
                    .font(.system(size: 18))
                    .fontWeight(.semibold)
                Text("나눔 횟수: 0")
                    .font(.system(size: 16))
            }
            Spacer()
        }
        .padding(.horizontal, 16)
        .frame(height: 148)
        
    }
}

struct UserGrade_Previews: PreviewProvider {
    static var previews: some View {
        UserGrade()
    }
}
