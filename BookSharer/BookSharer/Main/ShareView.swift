//
//  ShareView.swift
//  BookSharer
//
//  Created by 최성빈 on 2023/07/01.
//

import SwiftUI

struct ShareView: View {
    @State private var SVBSelection = 1
    
    var body: some View {
        
        VStack {
            //상단바
            SVTopbar()
            Divider()
            
            // 버튼
            SVButton(SVBSelection: $SVBSelection)
            
            // 나눠요 뷰
            if(SVBSelection == 1) {
                Share()
            } else {
                Get()
            }
            
            
            Spacer()
        }
        
    }
}

struct ShareView_Previews: PreviewProvider {
    static var previews: some View {
        ShareView()
    }
}
