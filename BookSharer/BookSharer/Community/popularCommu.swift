//
//  popularCommu.swift
//  BookSharer
//
//  Created by 최성빈 on 2023/09/05.
//

import SwiftUI

struct popularCommu: View {
    var body: some View {
        VStack{
            Text("실시간 인기")
                .font(.system(size: 24))
                .fontWeight(.semibold)
                
            VStack {
                ForEach(0..<4) { _ in
                    MiniCommu()
                    Divider()
                }
            }
        }
        
    }
}

struct AllCommu: View {
    var body: some View {
        VStack {
            Text("모든 게시글")
                .font(.system(size: 24))
                .fontWeight(.semibold)
            ForEach(0..<6) { _ in
                MiniCommu()
                Divider()
            }
        }
    }
}

struct freeCommu: View {
    var body: some View {
        ForEach(0..<8) { _ in
            MiniCommu()
            Divider()
        }
    }
}

struct popularCommu_Previews: PreviewProvider {
    static var previews: some View {
        popularCommu()
    }
}
