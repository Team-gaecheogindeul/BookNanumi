//
//  SVButton.swift
//  BookSharer
//
//  Created by 최성빈 on 2023/07/01.
//

import SwiftUI

struct SVButton: View {
    @State private var isCategoryFilter = false // 카테고리 필터
    @State private var isAreaFilter = false // 지역 필터
    
    @Binding var selectedCategories: [String: Set<String>]
    
    
    var body: some View {
        HStack (spacing: 10) {
            
            Button {
                isCategoryFilter = true
            } label: {
                HStack{
                    Text("카테고리")
                    Image(systemName: "control")
                        .rotationEffect(.degrees(180))
                        .font(.system(size: 12))
                        .frame(width: 12, height: 12)
                }
            }
                .modifier(ButtonStyleModifier())
                .sheet(isPresented: $isCategoryFilter) {
                    CategoryFilter(isCategoryFilter: $isCategoryFilter, selectedCategories: $selectedCategories)
            }
            
            
            Button {
                isAreaFilter = true
            } label: {
                HStack{
                    Text("지역")
                    Image(systemName: "control")
                        .rotationEffect(.degrees(180))
                        .font(.system(size: 12))
                        .frame(width: 12, height: 12)
                }
            }
                .modifier(ButtonStyleModifier())
                .sheet(isPresented: $isAreaFilter) {
                    AreaFilter(isAreaFilter: $isAreaFilter)
                }
            
            
            Spacer()
        }
        .padding(.horizontal, 14)
        .frame(height: 60)
    }
}

struct SVButton_Previews: PreviewProvider {
    static var previews: some View {
        SVButton(selectedCategories: .constant([:]))
    }
}
