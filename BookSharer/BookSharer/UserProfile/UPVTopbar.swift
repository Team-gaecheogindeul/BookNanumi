//
//  UPVTopbar.swift
//  BookSharer
//
//  Created by 최성빈 on 2023/07/01.
//

import SwiftUI

struct UPVTopbar: View {
    var body: some View {
        HStack {
            Spacer()
            Button {
                
            } label: {
                Image(systemName: "gearshape")
                    .font(.system(size: 26))
                    .frame(width: 36.0, height: 36.0)
            }
            .padding(.trailing, 14.0)
            .accentColor(.black)
        }
    }
}

struct UPVTopbar_Previews: PreviewProvider {
    static var previews: some View {
        UPVTopbar()
    }
}
