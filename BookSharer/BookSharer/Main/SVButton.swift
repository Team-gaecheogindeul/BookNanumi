//
//  SVButton.swift
//  BookSharer
//
//  Created by 최성빈 on 2023/07/01.
//

import SwiftUI

struct SVButton: View {
    @State private var isActionSheetPresented = false  // 나눠요, 받아요 버튼
    @Binding var SVBSelection: Int // 나눠요, 받아요 값
    @State private var isCategoryFilter = false // 카테고리 필터
    @State private var isAreaFilter = false // 카테고리 필터
    
    
    var body: some View {
        HStack (spacing: 10) {
            Button {
                isActionSheetPresented = true
            } label: {
                HStack{
                    if (SVBSelection == 1) {
                        Text("나눠요")
                    } else {
                        Text("받아요")
                    }
                    
                    Image(systemName: "control")
                        .rotationEffect(.degrees(180))
                        .font(.system(size: 12))
                        .frame(width: 12, height: 12)
                }
            }
            .modifier(ButtonStyleModifier())
            .confirmationDialog("", isPresented: $isActionSheetPresented, titleVisibility: .hidden) {
                Button("나눠요") {
                    SVBSelection = 1
                }
                Button("받아요") {
                    SVBSelection = 2
                }
                Button("취소", role: .cancel) {
                }
           }
            
            
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
                    CategoryFilter(isCategoryFilter: $isCategoryFilter)
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
        SVButton(SVBSelection: .constant(1))
    }
}
