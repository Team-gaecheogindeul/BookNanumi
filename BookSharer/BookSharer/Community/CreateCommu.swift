//
//  CreateCommu.swift
//  BookSharer
//
//  Created by 최성빈 on 2023/09/19.
//

import SwiftUI




struct CreateCommu: View {
    @State private var title = ""
    @State private var content = ""
    @State private var imageUrls: [URL] = [] // Array to store multiple images
    @State var shouldShowImagePicker = false // Image picker toggle
    
    @State private var base64Images: [String] = []
    
    @ObservedObject var viewModel: CommunityViewModel
    
    private let categoryTypeMapping: [String: String] = [
        "자유게시판": "Free",
        "학습게시판": "Learn",
        "중학교 입시 게시판": "School",
        "고등학교 입시 게시판": "College"
    ]





    var body: some View {
        NavigationView {
            ScrollView {
                VStack {

                    Button(action: {
                        // 카메라 버튼 액션
                        shouldShowImagePicker.toggle()
                    }) {
                        if let imageUrl = imageUrls.first, let imageData = try? Data(contentsOf: imageUrl) {
                            Image(uiImage: UIImage(data: imageData)!)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 166, alignment: .center)
                                .clipped()
                                .cornerRadius(12)
                        } else {
                            Image(systemName: "camera")
                                .font(.system(size: 24))
                                .padding()
                                .background(Color(UIColor.systemGray5))
                                .cornerRadius(8)
                        }
                    }.padding(.all)
                    .buttonStyle(PlainButtonStyle())

                    
                    categoryPicker

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
                                .frame(height: 300)
                            if content.isEmpty {
                                Text("내용을 입력하세요.")
                                    .foregroundColor(Color(UIColor.systemGray2))
                                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 230, trailing: 190))

                            }
                            
                        }
                    }
                    .padding(.all)


                    
                    

                    
                    // 게시글 저장 버튼
                    Button(action: {
                        // 날짜
                        let currentDate = Date()
                        let dateFormatter = DateFormatter()

                        // 날짜 형식 설정
                        dateFormatter.locale = Locale(identifier: "ko_KR")
                        dateFormatter.dateFormat = "yyyy년 M월 d일"

                        let formattedDateString = dateFormatter.string(from: currentDate)
                        if let formattedDate = dateFormatter.date(from: formattedDateString) {
                            print("date: \(formattedDate)")
                        } else {
                            print("날짜 형식이 잘못되었습니다")
                        }
                        
                        // 이미지 데이터 읽기
                        var imageDataArray: [Data] = []
                        for imageUrl in imageUrls {
                            if let imageData = try? Data(contentsOf: imageUrl) {
                                imageDataArray.append(imageData)
                            }
                        }

                        base64Images = imageDataArray.map { imageData in
                            return imageData.base64EncodedString()
                        }

                        // 카테고리 초기화
                        let selectedCategory = categories[selectedCategoryIndex]
                        let type = categoryTypeMapping[selectedCategory] ?? "Free"
                        
                        // communityDTO 초기화
                        let communityDTO = CommunityDTO(
                            board_title: title,
                            category_id: selectedCategory, // Use the selected category
                            board_story: content,
                            boardImageUrls: base64Images, // Add base64 image strings
                            date: formattedDateString, // Use the formatted date
                            likeCount: 0,
                            user_seq: "", // Set user_seq and other user-related data as needed
                            nickName: "",
                            UserImageUrl: "",
                            UserGrade: ""
                        )
                        
                        // Call the ViewModel function to save the posting
                        viewModel.savePosting(type: type, communityDTO: communityDTO) { result in
                            switch result {
                            case .success(let message):
                                print("Posting saved successfully: \(message)")
                                // Reset input fields or navigate to a different view
                                
                            case .failure(let error):
                                print("Error saving posting: \(error.localizedDescription)")
                                // Handle the error, display an alert, etc.
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
                .fullScreenCover(isPresented: $shouldShowImagePicker, onDismiss: nil) {
                            ImageUrlPicker(imageUrls: $imageUrls)
                        }
                    }
            .edgesIgnoringSafeArea(.bottom)
            .navigationTitle("게시물 작성")
        }
    }
    @State private var selectedCategoryIndex = 0
    let categories = ["자유게시판", "학습게시판", "중학교 입시 게시판", "고등학교 입시 게시판"]

    private var categoryPicker: some View {
        VStack(alignment: .leading) {

            Picker(selection: $selectedCategoryIndex, label: Text("카테고리")) {
                ForEach(0..<categories.count) { index in
                    Text(self.categories[index]).tag(index)
                }
            }
            .pickerStyle(MenuPickerStyle())
        }.padding(.bottom)
    }



}





struct CreateCommu_Previews: PreviewProvider {
    static var previews: some View {
        CreateCommu(viewModel: CommunityViewModel())
    }
}



