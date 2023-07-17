//
//  ShareDetails.swift
//  BookSharer
//
//  Created by 최성빈 on 2023/07/01.
//

import SwiftUI

struct ShareDetails: View {
    var body: some View {
        NavigationLink {
            SharePost()
        } label: {
            VStack(alignment: .leading, spacing: 13)  {
                HStack(alignment: .center, spacing: 0) {
                    Text("책 이미지")
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 52)
                .padding(.vertical, 0)
                .frame(height: 166, alignment: .center)
                .background(Color(red: 0.85, green: 0.85, blue: 0.85))
                .cornerRadius(12)
                
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("책 나눔 제목")
                        .fontWeight(.semibold)
                        .font(.system(size: 16))
                    Text("카테고리/상세카테고리")
                        .font(.system(size: 14))
                    Text("지역")
                        .font(.system(size: 14))
                    HStack(alignment: .center, spacing: 4){
                        Image(systemName: "heart")
                            .font(.system(size: 12))
                        Text("3")
                            .font(.system(size: 12))
                    }
                }

            }
        }

        

        
        
        
    }
}

struct ShareDetails_Previews: PreviewProvider {
    static var previews: some View {
        ShareDetails()
    }
}
