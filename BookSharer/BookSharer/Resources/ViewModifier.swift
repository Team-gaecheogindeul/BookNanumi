//
//  ViewModifier.swift
//  BookSharer
//
//  Created by 최성빈 on 2023/07/13.
//

import SwiftUI

struct ButtonStyleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .fontWeight(.semibold)
            .font(.system(size: 12))
            .foregroundColor(Color.black)
            .padding(.horizontal, 14)
            .padding(.vertical, 8)
            .cornerRadius(19)
            .overlay(
                RoundedRectangle(cornerRadius: 19)
                    .stroke(Color(red: 0.14, green: 0.14, blue: 0.15), lineWidth: 1)
            )
    }
}


