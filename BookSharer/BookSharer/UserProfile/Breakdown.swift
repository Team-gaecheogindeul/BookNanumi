//
//  Breakdown.swift
//  BookSharer
//
//  Created by 최성빈 on 2023/07/01.
//

import SwiftUI

struct Breakdown: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 26) {
                Text("내역")
                    .font(.system(size: 24))
                    .fontWeight(.semibold)
                
                Button {
                    //나눔 내역 뷰
                } label: {
                    Text("나눔 내역")
                        .font(.system(size: 18))
                        .fontWeight(.semibold)
                }
                
                Button {
                    // 받음 내역 뷰
                } label: {
                    Text("받음 내역")
                        .font(.system(size: 18))
                        .fontWeight(.semibold)
                }
                
                Button {
                    // 즐겨찾기 목록
                } label: {
                    Text("즐겨찾기 목록")
                        .font(.system(size: 18))
                        .fontWeight(.semibold)
                }

            }
            .accentColor(.black)
            .padding(.horizontal, 16)
            .frame(height: 191)
            
            Spacer()
        }
    }
}

struct Breakdown_Previews: PreviewProvider {
    static var previews: some View {
        Breakdown()
    }
}
