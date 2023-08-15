//
//  ChattingList.swift
//  BookSharer
//
//  Created by 최성빈 on 2023/07/01.
//

import SwiftUI
import SDWebImageSwiftUI

struct ChattingList: View {
    
    
    @State var user: User?
    
    @ObservedObject private var vm = CreateNewMessageViewModel()
    
    var body: some View {
        
        ForEach(vm.users) { user in
            
            NavigationLink {
                ChattingDetails(user: user)
            } label: {
                VStack(spacing: 0) {
                    HStack(spacing: 8) {
                        WebImage(url: URL(string: user.profileImageUrl))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 60, height: 60)
                            .clipped()
                            .cornerRadius(50)
                            .overlay(RoundedRectangle(cornerRadius: 50)
                                        .stroke(Color(.label), lineWidth: 2)
                            )
                            .padding(.all)
                        
                        
                        VStack(alignment: .leading, spacing: 8)  {
                            HStack(spacing: 8) {
                                Text(user.userName)
                                    .fontWeight(.semibold)
                                    .font(.system(size: 16))
                                
                                Text("1일전")
                                    .font(.system(size: 12))
                                    .foregroundColor(.black.opacity(0.5))
                            }
                            Text("recentMessage.text")
                                .font(.system(size: 14))
                        }
                        
                        Spacer()
                    }
                    
                    Divider()
                }

            }

            
        }

    }
}



struct ChattingList_Previews: PreviewProvider {
    static var previews: some View {
        ChattingList()
    }
}

