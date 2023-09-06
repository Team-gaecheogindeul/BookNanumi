//
//  ShareView.swift
//  BookSharer
//
//  Created by 최성빈 on 2023/07/01.
//

import SwiftUI

struct ShareView: View {
    @State private var showCreatePostView = false
    @StateObject private var viewModel = BoardViewModel()
    
    @State private var selectedCategories: [String: Set<String>] = ["참고서": [], "국내소설": [], "외국소설": []]

    var body: some View {
        ZStack {
            VStack {
                //상단바
                SVTopbar()
                Divider()

                // 버튼
                SVButton(selectedCategories: $selectedCategories)
                
                // 나눠요 뷰
                Share(selectedCategories: selectedCategories)
            }
            
            // 오른쪽 하단에 고정된 글쓰기 버튼 추가
            VStack {
                Spacer()

                HStack {
                    Spacer()
                    
                    Button(action: {
                        // 글쓰기 버튼이 눌렸을 때 수행할 액션
                        showCreatePostView.toggle()
                    }) {
                        Image(systemName: "square.and.pencil")
                            .font(.system(size: 24))
                            .padding()
                            .background(Color("MainColor"))
                            .foregroundColor(.white)
                            .cornerRadius(30)
                            .shadow(color: .gray, radius: 3)
                    }
                    .padding()
                    .padding(.bottom)
                }
            }
        }
        .sheet(isPresented: $showCreatePostView) {
            CreatePostView(viewModel: viewModel)
        }
    }
}

struct ShareView_Previews: PreviewProvider {
    static var previews: some View {
        ShareView()
    }
}
