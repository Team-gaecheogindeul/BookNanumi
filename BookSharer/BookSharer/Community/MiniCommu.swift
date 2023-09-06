//
//  MiniCommu.swift
//  BookSharer
//
//  Created by 최성빈 on 2023/09/05.
//

import SwiftUI

struct MiniCommu: View {
    var body: some View {
        NavigationLink {
            GetPost()
        } label: {
            HStack(alignment: .center, spacing: 8){
                Image(systemName: "person.crop.circle")
                    .frame(width: 80.0, height: 80.0)
                    .font(.system(size: 46))
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("게시글 제목")
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                    HStack {
                        Text("작성자")
                            .font(.system(size: 14))
                        .foregroundColor(.black.opacity(0.5))
                        Text("09/05 12:14")
                            .font(.system(size: 14))
                        .foregroundColor(.black.opacity(0.5))
                    }
                }
                HStack {
                    Spacer()
                    Image(systemName: "heart")
                        .font(.system(size: 16))
                        .foregroundColor(Color("MainColor"))
                    Text("3")
                        .foregroundColor(Color("MainColor"))
                    Image(systemName: "message")
                        .font(.system(size: 16))
                        .foregroundColor(Color("MainColor"))
                    Text("1")
                        .foregroundColor(Color("MainColor"))
                }
            }
            .padding(.trailing, 14.0)
            .frame(width: 390, height: 56, alignment: .leading)
        }
        
    }
}

struct MiniCommu_Previews: PreviewProvider {
    static var previews: some View {
        MiniCommu()
    }
}
