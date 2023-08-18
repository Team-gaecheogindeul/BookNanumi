//
//  GetPost.swift
//  BookSharer
//
//  Created by 최성빈 on 2023/07/10.
//

import SwiftUI

struct GetPost: View {
    @Environment(\.presentationMode) var presentationMode
    var board: BoardDTO
    
    var backButton: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "arrow.left")
                .foregroundColor(.black)
                .font(.system(size: 22))
                .frame(width: 36, height: 36)
        }
    }

    var shareButton: some View {
        Button(action: {
            // 공유 기능 구현
        }) {
            Image(systemName: "square.and.arrow.up")
                .foregroundColor(.black)
                .font(.system(size: 22))
                .frame(width: 36, height: 36)
        }
    }
    
    var body: some View {
        VStack {
            ScrollView {
                WriterProfile(board: board)
                Divider()
                GetPostContent()
                Divider()
                ShareWay(board: board)
            }
            
            
            Bottombar()
        }
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: backButton, trailing: shareButton)
    }
}

// 글 내용
struct GetPostContent: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 60) {
            VStack(alignment: .leading, spacing: 8) {
                Text("글 제목")
                    .font(.system(size: 24))
                    .fontWeight(.semibold)
                Text("카테고리/상세 카테고리")
                    .font(.system(size: 12))
                    .foregroundColor(.black.opacity(0.5))
                Text("글 내용")
                    .font(.system(size: 16))
            }
            HStack(alignment: .top, spacing: 10) {
                Text("2023년 6월 30일")
                    .font(.system(size: 10))
                    .foregroundColor(.black.opacity(0.5))
                
                Button {
                    
                } label: {
                    Text("게시글 신고하기")
                        .font(.system(size: 10))
                        .foregroundColor(.black.opacity(0.5))
                        .underline()
                }
            }
        }
        .padding(14)
        .frame(width: 390, alignment: .topLeading)
        

    }
}



struct GetPost_Previews: PreviewProvider {
    static var previews: some View {
        GetPost(board: BoardDTO())
    }
}
