//
//  Get.swift
//  BookSharer
//
//  Created by 최성빈 on 2023/07/01.
//

import SwiftUI

struct Get: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                ForEach(0..<10) { _ in
                    GetDetails()
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
