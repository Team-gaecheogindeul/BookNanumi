//
//  ShareView.swift
//  BookSharer
//
//  Created by 최성빈 on 2023/07/01.
//

import SwiftUI

struct ShareView: View {
    var body: some View {
        
        VStack {
            //상단바
            SVTopbar()
            Divider()
            
            // 버튼
            SVButton()
            
            // 나눠요 뷰
            Share()
            
            Spacer()
        }
        
    }
}

struct ShareView_Previews: PreviewProvider {
    static var previews: some View {
        ShareView()
    }
}
