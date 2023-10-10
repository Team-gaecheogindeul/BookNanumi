//
//  MiniCommu.swift
//  BookSharer
//
//  Created by 최성빈 on 2023/09/05.
//

import SwiftUI

struct MiniCommu: View {
    var board: CommunityDTO
    
    var body: some View {
        NavigationLink {
            GetPost(board: board)
        } label: {
            HStack(alignment: .center, spacing: 8){
                if let imageUrl = board.UserImageUrl, let imageData = Data(base64Encoded: imageUrl) {
                    Image(uiImage: UIImage(data: imageData)!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80.0, height: 80.0)
                        .font(.system(size: 46))
                        .cornerRadius(12)
                }else {
                    Image(systemName: "person.crop.circle")
                        .frame(width: 80.0, height: 80.0)
                        .font(.system(size: 46))
        
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text(board.board_title ?? "")
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                    HStack {
                        Text(board.nickName ?? "")
                            .font(.system(size: 14))
                        .foregroundColor(.black.opacity(0.5))
                        Text(board.date ?? "")
                            .font(.system(size: 14))
                        .foregroundColor(.black.opacity(0.5))
                    }
                }
                HStack {
                    Spacer()
                    Image(systemName: "heart")
                        .font(.system(size: 16))
                        .foregroundColor(Color("MainColor"))
                    Text("0")
                        .foregroundColor(Color("MainColor"))
                    Image(systemName: "message")
                        .font(.system(size: 16))
                        .foregroundColor(Color("MainColor"))
                    Text("0")
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
        MiniCommu(board: CommunityDTO())
    }
}
