//
//  Get.swift
//  BookSharer
//
//  Created by 최성빈 on 2023/07/01.
//

import SwiftUI

struct Get: View {
    @ObservedObject private var viewModel = BoardViewModel()
    @State private var didLoad = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(viewModel.boards, id: \.boardGiveId) { board in
                        GetDetails(board: board)
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
}


struct Get_Previews: PreviewProvider {
    static var previews: some View {
        Get()
    }
}
