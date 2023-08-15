//
//  Share.swift
//  BookSharer
//
//  Created by 최성빈 on 2023/07/01.
//

import SwiftUI

struct Share: View {
    @StateObject private var viewModel = BoardViewModel()
    @State private var didLoad = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                ShareDetails(boardTotal: BoardTotalDTO(boardGiveId: 1, boardTitle: "예시 게시물 제목", categoryId: 1, meetWantLocation: 2))
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 2), spacing: 16) {
                    // boardGiveId를 식별자로 사용합니다.
                    ForEach(viewModel.boards, id: \.boardGiveId) { board in
                        ShareDetails(boardTotal: board)
                    }
                }
                .padding()
            }
            .onAppear { didLoad = true }
            .onChange(of: didLoad) { _ in
                if didLoad {
                    viewModel.loadData()
                }
            }
        }
    }

}



struct Share_Previews: PreviewProvider {
    static var previews: some View {
        Share()
    }
}
