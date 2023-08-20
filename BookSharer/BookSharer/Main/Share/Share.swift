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
    
    var selectedCategories: [String: Set<String>]

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 2), spacing: 16) {
                    
                    let reversedBoards = viewModel.boards.reversed()

                    // 선택된 카테고리를 기준으로 게시물을 필터링합니다.
                    ForEach(reversedBoards.filter { board in
                        selectedCategories.values.allSatisfy({ $0.isEmpty }) ||
                        selectedCategories[board.categoryId ?? ""]?.contains(board.subCategoryId ?? "") ?? false
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
        Share(selectedCategories: [:])
    }
}
