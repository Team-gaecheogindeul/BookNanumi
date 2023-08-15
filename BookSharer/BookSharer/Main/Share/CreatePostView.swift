//
//  CreateSharePostView.swift
//  BookSharer
//
//  Created by 최성빈 on 2023/08/07.
//

import SwiftUI

enum PostType: String, CaseIterable {
    case share = "나누기"
    case get = "나눔 받기"
}

enum BookCategory: String, CaseIterable {
    case referenceBooks = "참고서"
    case domesticBooks = "국내도서"
    case foreignBooks = "외국도서"
}

enum SubCategory: String, CaseIterable {
    case elementary = "초등학교"
    case middleSchool = "중학교"
    case highSchool = "고등학교"
    case university = "대학생"
    case others = "기타"

    case literature = "문학/소설"
    case history = "역사/사회"
    case humanities = "인문/철학"
    case economics = "경제/경영"
    case selfDevelopment = "자기계발"
    case hobby = "취미"
}

struct CreatePostView: View {
    @State private var title = ""
    @State private var content = ""
    @State private var category = ""
    @State private var contact = ""
    @State private var postType: PostType = PostType.allCases.first!
    @State private var selectedCategoryIndex = -1
    @State private var selectedSubCategory = -1
    
    @ObservedObject var viewModel: BoardViewModel
    
    @Environment(\.presentationMode) var presentationMode

    private func subCategories(for category: BookCategory) -> [SubCategory] {
        switch category {
        case .referenceBooks:
            return [.elementary, .middleSchool, .highSchool, .university, .others]
        case .domesticBooks, .foreignBooks:
            return [.literature, .history, .humanities, .economics, .selfDevelopment, .hobby, .others]
        }
    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Picker("글쓰기 선택", selection: $postType) {
                        ForEach(PostType.allCases, id: \.self) { type in
                            Text(type.rawValue).tag(type)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                     .padding(.bottom)

                    Button(action: {
                        // 카메라 버튼 액션
                    }) {
                        Image(systemName: "camera")
                            .font(.system(size: 24))
                            .padding()
                            .background(Color(UIColor.systemGray5))
                            .cornerRadius(8)
                    }.buttonStyle(PlainButtonStyle())

                    VStack(alignment: .leading) {
                        Text("제목")
                        TextField("제목을 입력하세요.", text: $title)
                            .padding()
                            .background(Color(UIColor.systemGray5))
                            .cornerRadius(8)
                    }.padding(.bottom)

                    VStack(alignment: .leading) {
                        Text("내용")
                        TextField("내용을 입력하세요.", text: $content)
                            .padding()
                            .background(Color(UIColor.systemGray5))
                            .cornerRadius(8)
                    }.padding(.bottom)

                    categoryPicker
                    
                    if postType == PostType.share {
                        CreateSharePost
                    }
                    
                    shareingWay()
                    
                    // 게시글 저장 버튼
                    Button(action: {
                        let newBoardDTO = BoardDTO(boardGiveId: 1, boardTitle: content, userSeq: 1, categoryId: 1, bookTitle: "ds", bookStory: "ds", bookWriter: "sda", publisherName: "asd", publisherDate: "Sad", stateUnderscore: 1, stateNotes: 1, stateCover: 1, stateWrittenName: 1, statePageColorChange: 1, statePageDamage: 1, cityId: 1, meetWantLocation: 1)
                        viewModel.save(boardDTO: newBoardDTO) { result in
                            DispatchQueue.main.async {
                                switch result {
                                case .success(let message):
                                    print("저장 완료 - \(message)")
                                case .failure(let error):
                                    print("저장 실패 - \(error.localizedDescription)")
                                }
                            }
                        }
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("게시물 저장")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color("MainColor"))
                            .foregroundColor(Color.white)
                            .cornerRadius(8)
                    }

                    .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)

                }
                .padding(.horizontal, 16)
            }
            .edgesIgnoringSafeArea(.bottom)
            .navigationTitle("게시물 작성")
        }
    }

    private var categoryPicker: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("카테고리")
            
            Picker("카테고리", selection: $selectedCategoryIndex) {
                ForEach(BookCategory.allCases.indices, id: \.self) { index in
                    Text(BookCategory.allCases[index].rawValue).tag(index)
                }
            }.pickerStyle(MenuPickerStyle())
             .labelsHidden()

            if selectedCategoryIndex >= 0 {
                Picker("하위 카테고리", selection: $selectedSubCategory) {
                    ForEach(subCategories(for: BookCategory.allCases[selectedCategoryIndex]).indices, id: \.self) { index in
                        Text(subCategories(for: BookCategory.allCases[selectedCategoryIndex])[index].rawValue).tag(index)
                    }
                }.pickerStyle(MenuPickerStyle())
                 .labelsHidden()
            }
        }.padding(.bottom)
    }

    // 책 상태
    @State private var underLineIndex = ""
    @State private var takeNotesIndex = ""
    @State private var bookCoverIndex = ""
    @State private var nameSignIndex = ""
    @State private var pageDamageIndex = ""

    // 나눔 게시물 추가 필드
    private var CreateSharePost: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("책 상태")
            ConditionPickerView(title: "밑줄 상태", options: ["상", "중", "하", "없음"], selectedIndex: $underLineIndex)
            ConditionPickerView(title: "필기 흔적", options: ["상", "중", "하", "없음"], selectedIndex: $takeNotesIndex)
            ConditionPickerView(title: "겉표지", options: ["깨끗함", "깨끗하지 않음"], selectedIndex: $bookCoverIndex)
            ConditionPickerView(title: "이름 기입", options: ["있음", "없음"], selectedIndex: $nameSignIndex)
            ConditionPickerView(title: "페이지 훼손", options: ["있음", "없음"], selectedIndex: $pageDamageIndex)
        }
    }
}

struct ConditionPickerView: View {
    let title: String
    let options: [String]
    @Binding var selectedIndex: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .fontWeight(.semibold)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(options, id: \.self) { option in
                        Button(action: {
                            selectedIndex = (selectedIndex == option) ? "" : option
                        }) {
                            Text(option)
                                .padding(.horizontal, 20)
                                .padding(2.0)
                                .background(selectedIndex == option ? Color("MainColor") : Color(UIColor.systemGray5))
                                .foregroundColor(selectedIndex == option ? Color.white : Color.black)
                                .cornerRadius(8)
                        }
                    }
                }
            }
        }
    }
}

// 나눔 방법

struct shareingWay: View {
    @State private var pageDamageIndex = ""
    var body: some View {
        VStack {
            Text("나눔 방법")
            ConditionPickerView(title: "택배", options: ["가능", "불가능"], selectedIndex: $pageDamageIndex)
            ConditionPickerView(title: "직거래", options: ["가능", "불가능"], selectedIndex: $pageDamageIndex)
        }
    }
    
    

}


struct CreatePostView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePostView(viewModel: BoardViewModel())
    }
}



