//
//  ComuTopbar.swift
//  BookSharer
//
//  Created by 최성빈 on 2023/09/04.
//

import SwiftUI

struct ComuTopbar: View {
    @Binding var showMenu : Bool
    
    var body: some View {
        HStack{
            Button(action:{
                 withAnimation{
                     self.showMenu.toggle()
                 }
             })
             { Image(systemName:"text.justify")
                    .font(.system(size: 26))
            }
            .frame(width: 36, height: 36)
            
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
        .padding(.horizontal, 14)
        .accentColor(.black)
    }
}

struct ComuTopbar_Previews: PreviewProvider {
    static var previews: some View {
        ComuTopbar(showMenu: .constant(false))
    }
}
