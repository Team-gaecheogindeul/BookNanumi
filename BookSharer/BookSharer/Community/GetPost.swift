//
//  GetPost.swift
//  BookSharer
//
//  Created by 최성빈 on 2023/07/10.
//

import SwiftUI

struct GetPost: View {
    @Environment(\.presentationMode) var presentationMode
    var board: CommunityDTO
    
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
                HStack {
                    Text(board.board_title ?? "")
                        .font(.system(size: 28))
                        .fontWeight(.semibold)
                        .padding(.all)
                    Spacer()
                }
                CommuWriterProfile(board: board)
                Divider()
                GetPostContent(board: board)
                Divider()
                Comment()
            }
            
            
        }
    }
}

struct CommuWriterProfile: View  {
    var board: CommunityDTO
    
    var body: some View {
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
                    .font(.system(size: 52))
    
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text(board.nickName ?? "")
                    .font(.system(size: 16))
                    .fontWeight(.semibold)
                Text(board.UserGrade ?? "")
                    .font(.system(size: 14))
                    .foregroundColor(.black.opacity(0.5))
            }
        }
        .frame(width: 390, height: 90, alignment: .leading)
    }
}

// 글 내용
struct GetPostContent: View {
    var board: CommunityDTO
    
    var body: some View {
        VStack(alignment: .leading, spacing: 60) {
            VStack(alignment: .leading, spacing: 8) {
                ScrollView {
                    Text(board.board_story ?? "")
                        .font(.system(size: 18))
                }
                .frame(height: /*@START_MENU_TOKEN@*/100.0/*@END_MENU_TOKEN@*/)
                
                HStack {
                    Spacer()
                    Button {
                        
                    } label: {
                        VStack(alignment: .center, spacing: -1) {
                            Image(systemName: "heart")
                                .font(.system(size: 24))
                                .frame(width: /*@START_MENU_TOKEN@*/36.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/36.0/*@END_MENU_TOKEN@*/)
                                .foregroundColor(.black)
                            Text("0")
                                .font(.system(size: 14))
                                .fontWeight(.semibold)
                                .foregroundColor(.black.opacity(0.5))
                        }
                        .frame(width: 56, height: 56, alignment: .center)
                        .cornerRadius(6)
                        .overlay(
                          RoundedRectangle(cornerRadius: 6)
                            .inset(by: 0.5)
                            .stroke(Color(red: 0.96, green: 0.96, blue: 0.96), lineWidth: 1)
                        )
                }
                    Spacer()
                }
                
            }
            HStack {
                Text(board.date ?? "")
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

//댓글
struct Comment: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("댓글")
                Text("0")
                Spacer()
            }
            
//            ForEach(0..<4) { _ in
//                CommentDetails()
//                Divider()
//            }
//            CommentDetails2()
            
        }
        .padding(.horizontal, 14.0)
    }
}

struct CommentDetails: View {
    var body: some View {
        HStack(alignment: .center, spacing: 8){
            VStack {
                Image(systemName: "person.crop.circle")
                    .font(.system(size: 36))
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("작성자")
                        .font(.system(size: 16))
                    .fontWeight(.semibold)
                    Text("09/05 12:14")
                        .font(.system(size: 12))
                        .foregroundColor(.black.opacity(0.5))
                }
                HStack {
                    Text("댓글 내용")
                        .font(.system(size: 14))
                    
                }
                HStack {
                    Text("답글 달기")
                        .font(.system(size: 12))
                        .foregroundColor(.black.opacity(0.5))
                    Text("신고")
                        .font(.system(size: 12))
                        .foregroundColor(.black.opacity(0.5))
                }
            }

        }
        .frame(height: 66, alignment: .leading)
    }
}

struct CommentDetails2: View {
    var body: some View {
        HStack(alignment: .center, spacing: 8){
            VStack {
                Image(systemName: "person.crop.circle")
                    .font(.system(size: 36))
                Spacer()
            }
            .padding(.leading, 40.0)
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("작성자")
                        .font(.system(size: 16))
                    .fontWeight(.semibold)
                    Text("09/05 12:14")
                        .font(.system(size: 12))
                        .foregroundColor(.black.opacity(0.5))
                }
                HStack {
                    Text("댓글 내용")
                        .font(.system(size: 14))
                    
                }
                HStack {
                    Text("답글 달기")
                        .font(.system(size: 12))
                        .foregroundColor(.black.opacity(0.5))
                    Text("신고")
                        .font(.system(size: 12))
                        .foregroundColor(.black.opacity(0.5))
                }
            }

        }
        .frame(height: 66, alignment: .leading)
        
    }
}


struct GetPost_Previews: PreviewProvider {
    static var previews: some View {
        GetPost(board: CommunityDTO())
    }
}
