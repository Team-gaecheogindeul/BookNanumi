//
//  ChattingList.swift
//  BookSharer
//
//  Created by 최성빈 on 2023/07/01.
//

import SwiftUI

struct ChattingList: View {
    var body: some View {
        
        VStack(spacing: 0) {
            HStack(spacing: 8) {
                Image(systemName: "person.crop.circle")
                    .frame(width: 80.0, height: 80.0)
                .font(.system(size: 52))
                
                VStack(alignment: .leading, spacing: 8)  {
                    HStack(spacing: 8) {
                        Text("닉네임")
                            .fontWeight(.semibold)
                            .font(.system(size: 16))
                        
                        Text("1일전")
                            .font(.system(size: 12))
                            .foregroundColor(.black.opacity(0.5))
                    }
                    Text("채팅 내용")
                        .font(.system(size: 14))
                }
                
                Spacer()
            }
            
            Divider()
        }

    }
}

struct ChattingList_Previews: PreviewProvider {
    static var previews: some View {
        ChattingList()
    }
}
