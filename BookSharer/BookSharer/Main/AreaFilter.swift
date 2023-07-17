//
//  AreaFilter.swift
//  BookSharer
//
//  Created by 최성빈 on 2023/07/14.
//

import SwiftUI

struct AreaFilter: View {
    @Binding var isAreaFilter: Bool
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Spacer()
                Text("지역")
                    .font(.system(size: 20))
                    .font(.headline)
                    .fontWeight(.semibold)
                    .padding(.leading, 20)
                Spacer()
                Button(action: {
                    self.isAreaFilter = false
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.gray)
                        .padding(.trailing, 20)
                }
            }
            .padding(.top)
            
            HStack(alignment: .center, spacing: 85)  {
                Text("시/도")
                Text("시/구/군")
                Text("동/읍/면")
            }
            .font(.system(size: 18))
            .fontWeight(.semibold)
            .frame(width: 390, height: 40, alignment: .center)
            .overlay(
            Rectangle()
            .inset(by: 0.5)
            .stroke(.black, lineWidth: 2)
            )
            HStack {
                City()
                Divider()
                District()
                Divider()
                Towm()
            }
            
            
            Spacer()
            CategoryBottombar()
        }
        .edgesIgnoringSafeArea(.bottom)
        .presentationDetents([.medium])
        
        
    }
}
//시
struct City: View {
    let CityList = ["서울", "경기", "인천", "부산", "대구", "광주", "대전", "울산", "경남", "경북", "충남", "충북", "전남", "전북", "강원", "제주", "세종"]
    var body: some View {
        ScrollView {
            ForEach(CityList, id: \.self) { index in
                Button {
                    
                } label: {
                    Text(index)
                        .font(.system(size: 20))
                        .foregroundColor(.black)
                }
                .padding(10)
                .frame(width: 111, height: 40, alignment: .center)

            }
        }
    }
    
}

struct District: View {
    let Seoul = ["전체", "강남구","강동구", "강북구", "강서구", "관악구", "광진구", "구로구", "금천구", "노원구", "도봉구", "동대문구", "동작구", "마포구", "서대문구", "서초구", "성동구", "성북구", "송파구", "양천구", "영등포구", "용산구", "은평구", "종로구", "중구", "중랑구"]
    
    var body: some View {
        ScrollView {
            ForEach(Seoul, id: \.self) { index in
                Button {
                    
                } label: {
                    Text(index)
                        .font(.system(size: 20))
                        .foregroundColor(.black)
                }
                .padding(10)
                .frame(width: 151, height: 40, alignment: .center)

            }
        }

    }
}

struct Towm: View {
    let Gangnam = ["전체", "개포1동", "개포2동", "개포4동", "개포동", "논현1동", "논현2동", "논현동", "대치1동", "대치2동", "대치4동", "대치동", "도곡1동", "도곡2동", "도곡동", "삼성1동", "삼성2동", "삼성동", "세곡동", "수서동", "신사동", "압구정동", "역삼1동", "역삼2동", "역삼동", "율현동", "일원1동", "일원2동", "일원동", "일원본동", "자곡동", "청담동"]
    var body: some View {
        ScrollView {
            ForEach(Gangnam, id: \.self) { index in
                Button {
                    
                } label: {
                    Text(index)
                        .font(.system(size: 20))
                        .foregroundColor(.black)
                }
                .padding(10)
                .frame(width: 111, height: 40, alignment: .center)

            }
        }
    }
}


struct AreaFilter_Previews: PreviewProvider {
    static var previews: some View {
        AreaFilter(isAreaFilter: .constant(false))
    }
}
