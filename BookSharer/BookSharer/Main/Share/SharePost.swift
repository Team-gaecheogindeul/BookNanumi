//
//  SharePost.swift
//  BookSharer
//
//  Created by 최성빈 on 2023/07/10.
//

import SwiftUI

struct SharePost: View {
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
            ScrollView{
                BookImage()
                WriterProfile(board: board)
                Divider()
                BookProfile(board: board)
                Divider()
                BookCondision(board: board)
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
    var board: BoardDTO
    
    var body: some View {
        HStack(alignment: .center, spacing: 8){
            Image(systemName: "person.crop.circle")
                .frame(width: 80.0, height: 80.0)
                .font(.system(size: 52))
            
            VStack(alignment: .leading, spacing: 8) {
                Text(board.userName ?? "닉네임")
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
    var board: BoardDTO
    
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            VStack(alignment: .leading, spacing: 8) {
                Text(board.boardTitle ?? "책 나눔 제목")
                    .font(.system(size: 24))
                    .fontWeight(.semibold)
                Text((board.categoryId ?? "") + "/" + (board.subCategoryId ?? ""))
                    .font(.system(size: 12))
                    .foregroundColor(.black.opacity(0.5))
            }
            VStack(alignment: .leading, spacing: 35) {
                Text(board.bookStory ?? "글 내용")
                    .font(.system(size: 16))
                
                HStack(alignment: .top, spacing: 10) {
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
            .frame(width: 390, height: 95, alignment: .topLeading)
            
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 20)
        .frame(width: 390, height: 192, alignment: .topLeading)
    }
}

// 글 내용


// 책 상태
struct BookCondision: View {
    var board: BoardDTO
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20){
            Text("책 상태")
                .font(.system(size: 18))
            
            VStack(alignment: .leading, spacing: 12) {
                HStack(alignment: .top, spacing: 37) {
                    Text("밑줄 흔적")
                    
                    HStack(alignment: .top, spacing: 37) {
                        Text("상")
                            .foregroundColor(board.stateUnderscore == "상" ? .black : .black.opacity(0.5))
                            .fontWeight(board.stateUnderscore == "상" ? .bold : .regular)
                        Text("중")
                            .foregroundColor(board.stateUnderscore == "중" ? .black : .black.opacity(0.5))
                            .fontWeight(board.stateUnderscore == "중" ? .bold : .regular)
                        Text("하")
                            .foregroundColor(board.stateUnderscore == "하" ? .black : .black.opacity(0.5))
                            .fontWeight(board.stateUnderscore == "하" ? .bold : .regular)
                        Text("없음")
                            .foregroundColor(board.stateUnderscore == "없음" ? .black : .black.opacity(0.5))
                            .fontWeight(board.stateUnderscore == "없음" ? .bold : .regular)
                    }


                }
                HStack(alignment: .top, spacing: 37) {
                    Text("필기 흔적")
                    
                    HStack(alignment: .top, spacing: 37) {
                        Text("상")
                            .foregroundColor(board.stateNotes == "상" ? .black : .black.opacity(0.5))
                            .fontWeight(board.stateNotes == "상" ? .bold : .regular)
                        Text("중")
                            .foregroundColor(board.stateNotes == "중" ? .black : .black.opacity(0.5))
                            .fontWeight(board.stateNotes == "중" ? .bold : .regular)
                        Text("하")
                            .foregroundColor(board.stateNotes == "하" ? .black : .black.opacity(0.5))
                            .fontWeight(board.stateNotes == "하" ? .bold : .regular)
                        Text("없음")
                            .foregroundColor(board.stateNotes == "없음" ? .black : .black.opacity(0.5))
                            .fontWeight(board.stateNotes == "없음" ? .bold : .regular)
                    }

                }
                HStack(alignment: .top, spacing: 53) {
                    Text("겉표지")
                    
                    HStack(alignment: .top, spacing: 37) {
                        Text("깨끗함")
                            .foregroundColor(board.stateCover == "깨끗함" ? .black : .black.opacity(0.5))
                            .fontWeight(board.stateCover == "깨끗함" ? .bold : .regular)
                        Text("깨끗하지 않음")
                            .foregroundColor(board.stateCover == "깨끗하지 않음" ? .black : .black.opacity(0.5))
                            .fontWeight(board.stateCover == "깨끗하지 않음" ? .bold: .regular)
                    }
                }
                
                HStack(alignment: .top, spacing: 37) {
                    Text("이름 기입")
                    
                    HStack(alignment: .top, spacing: 37) {
                        Text("있음")
                            .foregroundColor(board.stateWrittenName == "있음" ? .black : .black.opacity(0.5))
                            .fontWeight(board.stateWrittenName == "있음" ? .bold: .regular)
                        Text("없음")
                            .foregroundColor(board.stateWrittenName == "없음" ? .black : .black.opacity(0.5))
                            .fontWeight(board.stateWrittenName == "없음" ? .bold: .regular)
                    }
                }
                HStack(alignment: .top, spacing: 24) {
                    Text("페이지 변색")
                    
                    HStack(alignment: .top, spacing: 37) {
                        Text("있음")
                            .foregroundColor(board.statePageColorChange == "있음" ? .black : .black.opacity(0.5))
                            .fontWeight(board.statePageColorChange == "있음" ? .bold: .regular)
                        Text("없음")
                            .foregroundColor(board.statePageColorChange == "없음" ? .black : .black.opacity(0.5))
                            .fontWeight(board.statePageColorChange == "없음" ? .bold: .regular)
                        
                    }
                }
                HStack(alignment: .top, spacing: 24) {
                    Text("페이지 훼손")
                    
                    HStack(alignment: .top, spacing: 37) {
                        Text("있음")
                            .foregroundColor(board.statePageDamage == "있음" ? .black : .black.opacity(0.5))
                            .fontWeight(board.statePageDamage == "있음" ? .bold: .regular)
                        Text("없음")
                            .foregroundColor(board.statePageDamage == "없음" ? .black : .black.opacity(0.5))
                            .fontWeight(board.statePageDamage == "없음" ? .bold: .regular)
                            
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
    var board: BoardDTO
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("나눔 방법")
                .font(.system(size: 18))
            
            VStack(alignment: .leading, spacing: 12) {
                HStack(alignment: .top, spacing: 57)  {
                    Text("택배")
                    HStack(alignment: .top, spacing: 14) {
                        Text("가능")
                            .foregroundColor(board.parcelIndex == "가능" ? .black : .black.opacity(0.5))
                            .fontWeight(board.parcelIndex == "가능" ? .bold: .regular)
                        Text("불가능")
                            .foregroundColor(board.parcelIndex == "불가능" ? .black : .black.opacity(0.5))
                            .fontWeight(board.parcelIndex == "불가능" ? .bold: .regular)
                    }
                }
                
                HStack(alignment: .top, spacing: 45) {
                    Text("직거래")
                    HStack(alignment: .top, spacing: 14) {
                        Text("가능")
                            .foregroundColor(board.directIndex == "가능" ? .black : .black.opacity(0.5))
                            .fontWeight(board.directIndex == "가능" ? .bold: .regular)
                        Text("불가능")
                            .foregroundColor(board.directIndex == "불가능" ? .black : .black.opacity(0.5))
                            .fontWeight(board.directIndex == "불가능" ? .bold: .regular)
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
    @ObservedObject private var vm = CreateNewMessageViewModel()
    
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
            NavigationLink(destination: vm.users.isEmpty ? nil : ChattingDetails(user: vm.users[0])) {
                HStack {
                    Text("채팅하기")
                        .font(.system(size: 24))
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                }
                .padding(10)
                .frame(width: 272, height: 56, alignment: .center)
                .background(Color("MainColor"))
                .cornerRadius(6)
            }.disabled(vm.users.isEmpty) // 만약 첫 번째 상대 유저가 없다면 NavigationLink 비활성화



            
            
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
        SharePost(board: BoardDTO())
    }
}
