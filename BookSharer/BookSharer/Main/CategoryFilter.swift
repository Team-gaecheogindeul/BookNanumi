//
//  CategoryFilter.swift
//  BookSharer
//
//  Created by 최성빈 on 2023/07/13.
//

import SwiftUI

struct CategoryFilter: View {
    @Binding var isCategoryFilter: Bool
    @State private var isCategoryPresented = 0
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Spacer()
                Text("필터")
                    .font(.system(size: 20))
                    .font(.headline)
                    .fontWeight(.semibold)
                    .padding(.leading, 20)
                Spacer()
                Button(action: {
                    self.isCategoryFilter = false
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.gray)
                        .padding(.trailing, 20)
                }
            }
            .padding(.top)
            ScrollView {

                CategoryTopbar(isCategoryPresented: $isCategoryPresented)
                Divider()
                if (isCategoryPresented == 0) {
                    Category()
                } else {
                    Parcel()
                }
                
                
            }
            
            Spacer()
            CategoryBottombar()
        }
        .edgesIgnoringSafeArea(.bottom)
        .presentationDetents([.medium])
        
    }
    
}


// 하단 바
struct CategoryBottombar: View {
    var body: some View {
        HStack(alignment: .center, spacing: 9) {
            //즐겨찾기 버튼
            Button {
                
            } label: {
                VStack(alignment: .center, spacing: -1) {
                    Image(systemName: "arrow.counterclockwise")
                        .font(.system(size: 24))
                        .frame(width: /*@START_MENU_TOKEN@*/36.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/36.0/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.black)
                    Text("초기화")
                        .font(.system(size: 14))
                        .fontWeight(.semibold)
                        .foregroundColor(.black.opacity(0.5))
                }
                .padding(0)
                .frame(width: 56, height: 56, alignment: .center)
                .cornerRadius(6)
                .overlay(
                  RoundedRectangle(cornerRadius: 6)
                    .inset(by: 0.5)
                    .stroke(Color(red: 0.96, green: 0.96, blue: 0.96), lineWidth: 1)
                )
            }
            // 적용하기 버튼
            Button {
                
            } label: {
                HStack {
                    Text("적용하기")
                        .font(.system(size: 24))
                        .fontWeight(.bold)
                    .foregroundColor(Color.white)
                }
                .padding(10)
                .frame(width: 272, height: 56, alignment: .center)
                .background(Color("MainColor"))
                .cornerRadius(6)
            }

            
            
        }
        .padding(0)
        .frame(width: 390, height: 100, alignment: .center)
        .overlay(
        Rectangle()
        .inset(by: 0.5)
        .stroke(Color(red: 0.96, green: 0.96, blue: 0.96), lineWidth: 1)
        )
        
    }
}


// 카테고리 택배 필터
struct CategoryTopbar: View {
    @Binding var isCategoryPresented: Int
    
    var body: some View {
        
        HStack(alignment: .center, spacing: 46) {
            Button {
                isCategoryPresented = 0
            } label: {
                Text("카테고리")
                    .foregroundColor(isCategoryPresented == 0 ? Color.black : Color(red: 0.74, green: 0.74, blue: 0.74))
            }
            Button {
                isCategoryPresented = 1
            } label: {
                Text("택배")
                    .foregroundColor(isCategoryPresented == 1 ? Color.black : Color(red: 0.74, green: 0.74, blue: 0.74))
            }
        }
            .fontWeight(.semibold)
            .font(.system(size: 16))
            .foregroundColor(.black)
            .padding(.horizontal, 13)
            .padding(.vertical, 0)
            .frame(width: 390, height: 32, alignment: .leading)

        
        
    }
}

// 카테고리
struct Category: View {
    let educationLevels = ["초등학교", "중학교", "고등학교", "대학교", "기타"]
    let bookCategory = ["문학/소설", "역사/사회", "인문/철학", "경제/경영", "자기계발", "취미","기타"]
    
    var body: some View {
            VStack(alignment: .leading, spacing: 18) {
                //참고서
                HStack {
                    Text("참고서")
                        .fontWeight(.semibold)
                        .font(.system(size: 16))
                    Spacer()
                    Button {
                        
                    } label: {
                        Text("전체 선택")
                            .font(.system(size: 14))
                            .foregroundColor(Color(red: 0.74, green: 0.74, blue: 0.74))
                    }

                }

                //버튼
                VStack(alignment: .leading, spacing: 18) {
                    HStack {
                        ForEach(0..<4) { index in
                            Button(action: {}) {
                                Text(educationLevels[index])
                            }.modifier(ButtonStyleModifier())
                        }
                    }
                    HStack {
                        ForEach(4..<educationLevels.count) { index in
                            Button(action: {}) {
                                Text(educationLevels[index])
                            }.modifier(ButtonStyleModifier())
                        }
                    }
                }


                Divider()
                //국내도서
                HStack {
                    Text("국내소설")
                        .fontWeight(.semibold)
                        .font(.system(size: 16))
                    Spacer()
                    Button {
                        
                    } label: {
                        Text("전체 선택")
                            .font(.system(size: 14))
                            .foregroundColor(Color(red: 0.74, green: 0.74, blue: 0.74))
                    }

                }

                //버튼
                VStack(alignment: .leading, spacing: 18) {
                    HStack {
                        ForEach(0..<4) { index in
                            Button(action: {}) {
                                Text(bookCategory[index])
                            }.modifier(ButtonStyleModifier())
                        }
                    }
                    HStack {
                        ForEach(4..<bookCategory.count) { index in
                            Button(action: {}) {
                                Text(bookCategory[index])
                            }.modifier(ButtonStyleModifier())
                        }
                    }
                }
                
                Divider()
                
                //외국도서
                HStack {
                    Text("외국소설")
                        .fontWeight(.semibold)
                        .font(.system(size: 16))
                    Spacer()
                    Button {
                        
                    } label: {
                        Text("전체 선택")
                            .font(.system(size: 14))
                            .foregroundColor(Color(red: 0.74, green: 0.74, blue: 0.74))
                    }

                }
                VStack(alignment: .leading, spacing: 18) {
                    HStack {
                        ForEach(0..<4) { index in
                            Button(action: {}) {
                                Text(bookCategory[index])
                            }.modifier(ButtonStyleModifier())
                        }
                    }
                    HStack {
                        ForEach(4..<bookCategory.count) { index in
                            Button(action: {}) {
                                Text(bookCategory[index])
                            }.modifier(ButtonStyleModifier())
                        }
                    }
                }


            }
            .padding(.all, 14.0)
        }
        
}



struct Parcel: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack {
                
                //택배
                Text("택배")
                    .fontWeight(.semibold)
                    .font(.system(size: 16))
                Spacer()
                Button {
                    
                } label: {
                    Text("전체 선택")
                        .font(.system(size: 14))
                        .foregroundColor(Color(red: 0.74, green: 0.74, blue: 0.74))
                }

            }
            HStack {
                Button {
                    
                } label: {
                    Text("가능")
                }
                .modifier(ButtonStyleModifier())
                Button {
                    
                } label: {
                    Text("불가능")
                }
                .modifier(ButtonStyleModifier())

            }
            Divider()
            // 직거래
            HStack {
                Text("직거래")
                    .fontWeight(.semibold)
                    .font(.system(size: 16))
                Spacer()
                Button {
                    
                } label: {
                    Text("전체 선택")
                        .font(.system(size: 14))
                        .foregroundColor(Color(red: 0.74, green: 0.74, blue: 0.74))
                }

            }
            HStack {
                Button {
                    
                } label: {
                    Text("가능")
                }
                .modifier(ButtonStyleModifier())
                Button {
                    
                } label: {
                    Text("불가능")
                }
                .modifier(ButtonStyleModifier())

            }
        }
        .padding(.all, 14.0)
        
        
    }
}


struct CategoryFilter_Previews: PreviewProvider {
    static var previews: some View {
        CategoryFilter(isCategoryFilter: .constant(false))
    }
}
