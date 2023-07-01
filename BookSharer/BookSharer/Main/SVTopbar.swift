//
//  SVTopbar.swift
//  BookSharer
//
//  Created by 최성빈 on 2023/07/01.
//

import SwiftUI

struct SVTopbar: View {
    var body: some View {
        HStack{
            Spacer()
            
            Button {
                
            } label: {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 26))
            }
            .frame(width: 36, height: 36)
            
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

struct SVTopbar_Previews: PreviewProvider {
    static var previews: some View {
        SVTopbar()
    }
}
