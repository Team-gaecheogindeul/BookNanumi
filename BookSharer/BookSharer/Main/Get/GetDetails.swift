//
//  GetDetails.swift
//  BookSharer
//
//  Created by 최성빈 on 2023/07/01.
//

import SwiftUI

struct GetDetails: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                VStack(alignment: .leading, spacing: 12) {
                    VStack(alignment: .leading, spacing: 6)  {
                        Text("글 제목")
                            .fontWeight(.semibold)
                            .font(.system(size: 16))
                        Text("카테고리/상세 카테고리")
                            .font(.system(size: 12))
                            .foregroundColor(.black.opacity(0.5))
                    }
                    
                    Text("글 내용")
                        .font(.system(size: 14))
                    Text("06/28 | 작성자")
                        .font(.system(size: 12))
                        .foregroundColor(.black.opacity(0.5))
                    
                }
                Spacer()
            }
            .padding(.all, 14)
            
            Divider()
        }

    }
}

struct GetDetails_Previews: PreviewProvider {
    static var previews: some View {
        GetDetails()
    }
}
