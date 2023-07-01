//
//  SVButton.swift
//  BookSharer
//
//  Created by 최성빈 on 2023/07/01.
//

import SwiftUI

struct SVButton: View {
    var body: some View {
        HStack (spacing: 10) {
            Button {
                
            } label: {
                HStack{
                    Text("나눠요")
                        .font(.system(size: 12))
                        .fontWeight(.semibold)
                    Image(systemName: "control")
                        .rotationEffect(.degrees(180))
                        .font(.system(size: 12))
                        .frame(width: 12, height: 12)
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .cornerRadius(19)
            .overlay(
                RoundedRectangle(cornerRadius: 19)
                    .stroke(Color.black, lineWidth: 1)
            )
            .accentColor(.black)
            
            Button {
                
            } label: {
                HStack{
                    Text("카테고리")
                        .font(.system(size: 12))
                        .fontWeight(.semibold)
                    Image(systemName: "control")
                        .rotationEffect(.degrees(180))
                        .font(.system(size: 12))
                        .frame(width: 12, height: 12)
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .cornerRadius(19)
            .overlay(
                RoundedRectangle(cornerRadius: 19)
                    .stroke(Color.black, lineWidth: 1)
            )
            .accentColor(.black)
            
            Button {
                
            } label: {
                HStack{
                    Text("지역")
                        .font(.system(size: 12))
                        .fontWeight(.semibold)
                    Image(systemName: "control")
                        .rotationEffect(.degrees(180))
                        .font(.system(size: 12))
                        .frame(width: 12, height: 12)
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .cornerRadius(19)
            .overlay(
                RoundedRectangle(cornerRadius: 19)
                    .stroke(Color.black, lineWidth: 1)
            )
        .accentColor(.black)
            
            
            Spacer()
        }
        .padding(.horizontal, 14)
        .frame(height: 60)
    }
}

struct SVButton_Previews: PreviewProvider {
    static var previews: some View {
        SVButton()
    }
}
