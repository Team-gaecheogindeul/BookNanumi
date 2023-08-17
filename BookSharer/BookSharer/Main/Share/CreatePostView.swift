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
    // 게시글 저장 성공시 콜백 함수를 추가합니다.
    func saveSuccessful() {
        viewModel.loadData()
        presentationMode.wrappedValue.dismiss()
    }



    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Picker("글쓰기 선택", selection: $postType) {
                        ForEach(PostType.allCases, id: \.self) { type in
                            Text(type.rawValue).tag(type)
                        }
                    }
                    .padding(.all).pickerStyle(SegmentedPickerStyle())
                     

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
                    }
                    .padding(.all)

                    VStack(alignment: .leading) {
                        Text("내용")
                        ZStack {
                            RoundedRectangle(cornerRadius: 8).fill(Color(UIColor.systemGray5))
                            TextEditor(text: $content)
                                .colorMultiply(Color(UIColor.systemGray5))
                                .padding()
                                .frame(height: 100)
                            if content.isEmpty {
                                Text("내용을 입력하세요.")
                                    .foregroundColor(Color(UIColor.systemGray2))
                                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 35, trailing: 190))

                            }
                            
                        }
                    }
                    .padding(.all)


                    categoryPicker
                        .padding(.all)
                    
                    if postType == PostType.share {
                        Divider()
                            .frame(height: 16) // 높이 변경
                            .background(Color(red: 0.98, green: 0.98, blue: 0.98))
                            .overlay(Rectangle().frame(height: 1).foregroundColor(Color(red: 0.98, green: 0.98, blue: 0.98))) // 굵기 조정
                        CreateSharePost
                            .padding(.all)
                    }
                    Divider()
                        .frame(height: 16) // 높이 변경
                        .background(Color(red: 0.98, green: 0.98, blue: 0.98))
                        .overlay(Rectangle().frame(height: 1).foregroundColor(Color(red: 0.98, green: 0.98, blue: 0.98))) // 굵기 조정
                    shareingWay()
                        .padding(.all)
                    
                    // 게시글 저장 버튼
                    Button(action: {
                        let newBoardDTO = BoardDTO(boardGiveId: 1, boardTitle: title, userSeq: 1, categoryId: "", bookStory: content, stateUnderscore: "", stateNotes: "", stateCover: "", stateWrittenName: "", statePageColorChange: "", statePageDamage: "", cityId: "", meetWantLocation: "")
                        viewModel.save(boardDTO: newBoardDTO) { result in
                            DispatchQueue.main.async {
                                print(2121)
                                switch result {
                                case .success(let message):
                                    print("저장 완료 - \(message)")
                                    saveSuccessful()
                                case .failure(let error):
                                    print("저장 실패 - \(error.localizedDescription)")
                                }
                            }
                        }
                    }) {
                        Text("게시물 저장")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color("MainColor"))
                            .foregroundColor(Color.white)
                            .cornerRadius(8)
                    }
                    .padding(.all)


                }
            }
    
            .edgesIgnoringSafeArea(.bottom)
            .navigationTitle("게시물 작성")
        }
    }

    private var categoryPicker: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("카테고리")
                    .font(.system(size: 24))
                    .fontWeight(.semibold)
                Spacer()
            }
            
            HStack {
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
                .font(.system(size: 24))
                .fontWeight(.semibold)
                .padding(.bottom)
            ConditionPickerView(title: "밑줄 상태", options: ["상", "중", "하", "없음"], selectedIndex: $underLineIndex)
            ConditionPickerView(title: "필기 흔적", options: ["상", "중", "하", "없음"], selectedIndex: $takeNotesIndex)
            ConditionPickerView(title: "겉표지", options: ["깨끗함", "깨끗하지 않음"], selectedIndex: $bookCoverIndex)
            ConditionPickerView(title: "이름 기입", options: ["있음", "없음"], selectedIndex: $nameSignIndex)
            ConditionPickerView(title: "페이지 훼손", options: ["있음", "없음"], selectedIndex: $pageDamageIndex)
        }
    }
}

// 상태 버튼
struct ConditionPickerView: View {
    let title: String
    let options: [String]
    @Binding var selectedIndex: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(options, id: \.self) { option in
                        Button(action: {
                            selectedIndex = (selectedIndex == option) ? "" : option
                        }) {
                            Text(option)
                                .padding(.horizontal, 20)
                                .padding(2.0)
                                .background(selectedIndex == option ? Color(UIColor.systemGray2) : Color(UIColor.systemGray5))
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
    @State private var parcelIndex = ""
    @State private var directIndex = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("나눔 방법")
                .font(.system(size: 24))
                .fontWeight(.semibold)
                .padding(.bottom)
            ConditionPickerView(title: "택배", options: ["가능", "불가능"], selectedIndex: $parcelIndex)
            ConditionPickerView(title: "직거래", options: ["가능", "불가능"], selectedIndex: $directIndex)
        }
    }

}


struct CreatePostView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePostView(viewModel: BoardViewModel())
    }
}



