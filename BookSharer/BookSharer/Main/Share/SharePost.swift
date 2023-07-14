//
//  SharePost.swift
//  BookSharer
//
//  Created by 최성빈 on 2023/07/10.
//

import SwiftUI

struct SharePost: View {
    var body: some View {
        VStack {
            ScrollView{
                BookImage()
                WriterProfile()
                Divider()
                BookProfile()
                Divider()
                PostContent()
                Divider()
                BookCondision()
                Divider()
                ShareWay()
            }
            Bottombar()
        }
        .edgesIgnoringSafeArea(.all)
    }
}


// 책 이미지
struct BookImage: View {
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            Text("책 이미지")
                .font(.system(size: 24))
                .foregroundColor(.white)
        }
        .padding(.horizontal, 52)
        .padding(.vertical, 0)
        .frame(width: 390, height: 390, alignment: .center)
        .background(Color(red: 0.85, green: 0.85, blue: 0.85))

    }
}

// 글쓴이 정보
struct WriterProfile: View  {
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

//책 정보
struct BookProfile: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            VStack(alignment: .leading, spacing: 8) {
                Text("책 나눔 제목")
                    .font(.system(size: 24))
                    .fontWeight(.semibold)
                Text("카테고리/상세 카테고리")
                    .font(.system(size: 14))
                    .foregroundColor(.black.opacity(0.5))
            }
            VStack(alignment: .leading, spacing: 7) {
                HStack(alignment: .top, spacing: 42) {
                    Text("저자")
                        .font(.system(size: 14))
                        .foregroundColor(.black.opacity(0.5))
                    Text("저자 이름")
                        .font(.system(size: 14))
                }
                HStack(alignment: .top, spacing: 30) {
                    Text("출판사")
                        .font(.system(size: 14))
                        .foregroundColor(.black.opacity(0.5))
                    Text("출판사 이름")
                        .font(.system(size: 14))
                }
                HStack(alignment: .top, spacing: 30) {
                    Text("출판일")
                        .font(.system(size: 14))
                        .foregroundColor(.black.opacity(0.5))
                    Text("2013년 6월 30일")
                        .font(.system(size: 14))
                }
            }
            
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 20)
        .frame(width: 390, height: 192, alignment: .topLeading)
    }
}

// 글 내용
struct PostContent: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 35) {
            Text("글 내용")
                .font(.system(size: 16))
            
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
        .frame(width: 390, height: 95, alignment: .topLeading)
        
    }
}

// 책 상태
struct BookCondision: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20){
            Text("책 상태")
                .font(.system(size: 18))
            
            VStack(alignment: .leading, spacing: 12) {
                HStack(alignment: .top, spacing: 37) {
                    Text("밑줄 흔적")
                    
                    HStack(alignment: .top, spacing: 37) {
                        Text("상")
                        Text("중")
                        Text("하")
                        Text("없음")
                    }
                }
                HStack(alignment: .top, spacing: 37) {
                    Text("필기 흔적")
                    
                    HStack(alignment: .top, spacing: 37) {
                        Text("상")
                        Text("중")
                        Text("하")
                        Text("없음")
                    }
                }
                HStack(alignment: .top, spacing: 53) {
                    Text("겉표지")
                    
                    HStack(alignment: .top, spacing: 37) {
                        Text("깨끗함")
                        Text("깨끗하지 않음")
                    }
                }
                
                HStack(alignment: .top, spacing: 37) {
                    Text("이름 기입")
                    
                    HStack(alignment: .top, spacing: 37) {
                        Text("있음")
                        Text("없음")
                    }
                }
                HStack(alignment: .top, spacing: 24) {
                    Text("페이지 변색")
                    
                    HStack(alignment: .top, spacing: 37) {
                        Text("있음")
                        Text("없음")
                    }
                }
                HStack(alignment: .top, spacing: 24) {
                    Text("페이지 훼손")
                    
                    HStack(alignment: .top, spacing: 37) {
                        Text("있음")
                        Text("없음")
                            
                    }
                }
            }
                .font(.system(size: 14))
                .foregroundColor(.black.opacity(0.5))
        }
        .padding(.horizontal, 14.0)
        .frame(width: 390, height: 265, alignment: .leading)
        
    }
}


// 나눔 방법
struct ShareWay: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("나눔 방법")
                .font(.system(size: 18))
            
            VStack(alignment: .leading, spacing: 12) {
                HStack(alignment: .top, spacing: 57)  {
                    Text("택배")
                    HStack(alignment: .top, spacing: 14) {
                        Text("가능")
                        Text("불가능")
                    }
                }
                
                HStack(alignment: .top, spacing: 45) {
                    Text("직거래")
                    HStack(alignment: .top, spacing: 14) {
                        Text("가능")
                        Text("불가능")
                    }
                }
                
                HStack(alignment: .top, spacing: 57) {
                    Text("지역")
                    Text("시/도 - 시/구/군 - 동/읍/면")
                }
                
                HStack(alignment: .top, spacing: 16) {
                    Text("원하는 장소")
                    Text("XX 건물 1층")
                }
                
            }
            .font(.system(size: 14))
            .foregroundColor(.black.opacity(0.5))
        }
        .padding(.horizontal, 14)
        .frame(width: 390, height: 200, alignment: .leading)
        
    }
}

// 하단 바
struct Bottombar: View {
    var body: some View {
        HStack(alignment: .center, spacing: 9) {
            //즐겨찾기 버튼
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
                .padding(0)
                .frame(width: 56, height: 56, alignment: .center)
                .cornerRadius(6)
                .overlay(
                  RoundedRectangle(cornerRadius: 6)
                    .inset(by: 0.5)
                    .stroke(Color(red: 0.96, green: 0.96, blue: 0.96), lineWidth: 1)
                )
            }
            // 채팅 버튼
            Button {
                
            } label: {
                HStack {
                    Text("채팅하기")
                        .font(.system(size: 24))
                        .fontWeight(.bold)
                    .foregroundColor(Color.white)
                }
                .padding(10)
                .frame(width: 272, height: 56, alignment: .center)
                .background(Color(red: 0.3, green: 0.69, blue: 0.31))
                .cornerRadius(6)
            }

            
            
        }
        .padding(0)
        .frame(width: 390, height: 100, alignment: .center)
        .overlay(
        Rectangle()
        .inset(by: 0.5)
        .stroke(Color(red: 0.96, green: 0.96, blue: 0.96), lineWidth: 1)
        )
        
    }
}

struct SharePost_Previews: PreviewProvider {
    static var previews: some View {
        SharePost()
    }
}
