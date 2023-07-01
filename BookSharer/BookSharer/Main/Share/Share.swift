//
//  Share.swift
//  BookSharer
//
//  Created by 최성빈 on 2023/07/01.
//

import SwiftUI

struct Share: View {
    var body: some View {
        ScrollView {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 2), spacing: 16) {
                ForEach(0..<9) { _ in
                    ShareDetails()
                }
            }
            .padding()
        }
    }
}


struct Share_Previews: PreviewProvider {
    static var previews: some View {
        Share()
    }
}
