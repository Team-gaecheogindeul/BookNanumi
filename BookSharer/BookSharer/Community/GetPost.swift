//
//  GetPost.swift
//  BookSharer
//
//  Created by 최성빈 on 2023/07/10.
//

import SwiftUI

struct GetPost: View {
    @Environment(\.presentationMode) var presentationMode
    
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
                    Text("글 제목")
                        .font(.system(size: 28))
                        .fontWeight(.semibold)
                        .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    Spacer()
                }
                CommuWriterProfile()
                Divider()
                GetPostContent()
                Divider()
                Comment()
            }
            
            
        }
    }
}

struct CommuWriterProfile: View  {
    
    var body: some View {
        HStack(alignment: .center, spacing: 8){
            Image(systemName: "person.crop.circle")
                .frame(width: 80.0, height: 80.0)
                .font(.system(size: 52))
            
            VStack(alignment: .leading, spacing: 8) {
                Text("닉네임")
                    .font(.system(size: 16))
                    .fontWeight(.semibold)
                Text("새싹 나누미")
                    .font(.system(size: 14))
                    .foregroundColor(.black.opacity(0.5))
            }
        }
        .frame(width: 390, height: 90, alignment: .leading)
    }
}

// 글 내용
struct GetPostContent: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 60) {
            VStack(alignment: .leading, spacing: 8) {
                ScrollView {
                    Text("글 내용")
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
                            Text("3")
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

//댓글
struct Comment: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("댓글")
                Text("4")
                Spacer()
            }
            
            ForEach(0..<4) { _ in
                CommentDetails()
                Divider()
            }
            CommentDetails2()
            
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
        GetPost()
    }
}
