//
//  ChattingView.swift
//  BookSharer
//
//  Created by 최성빈 on 2023/07/01.
//

import SwiftUI

struct ChattingView: View {
    var body: some View {
        VStack {
            //상단 바
            CVTopbar()
            Divider()
            
            ScrollView {
                VStack {
                    ChattingList()
                }
            }
            
            Spacer()
        }
        
    }
}




struct ChattingView_Previews: PreviewProvider {
    static var previews: some View {
        ChattingView()
    }
}
