//
//  Share.swift
//  BookSharer
//
//  Created by 최성빈 on 2023/07/01.
//

import SwiftUI

struct Share: View {
    @ObservedObject private var viewModel = BoardViewModel()
    @State private var didLoad = false
    
    @State private var selectedCategories: Set<String> = [] // 카테고리 필터
    
    var body: some View {
        NavigationView {
            
            ScrollView {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 2), spacing: 16) {
                    // 선택된 카테고리를 기준으로 게시물을 필터링합니다.
                    ForEach(viewModel.boards.filter { board in
                        selectedCategories.isEmpty || selectedCategories.contains(board.subCategoryId ?? "")
                    }, id: \.boardGiveId) { board in
                        ShareDetails(board: board)
                    }
                }
                .padding()
            }
        }
            .onAppear { didLoad = true }
            .onChange(of: didLoad) { _ in
                if didLoad {
                    viewModel.loadData()
                }
            }
        }
}




struct Share_Previews: PreviewProvider {
    static var previews: some View {
        Share()
    }
}
