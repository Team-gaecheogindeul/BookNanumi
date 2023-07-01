//
//  CVTopbar.swift
//  BookSharer
//
//  Created by 최성빈 on 2023/07/01.
//

import SwiftUI

struct CVTopbar: View {
    var body: some View {
        HStack {
            Spacer()
            
            Button {
                
            } label: {
                Image(systemName: "bell")
                    .font(.system(size: 26))
            }
            .frame(width: 36, height: 36)
        }
        .padding(.trailing, 14)
        .accentColor(.black)

        
    }
}

struct CVTopbar_Previews: PreviewProvider {
    static var previews: some View {
        CVTopbar()
    }
}
