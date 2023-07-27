//
//  ProfileSettingView.swift
//  BookSharer
//
//  Created by 최성빈 on 2023/07/25.
//

import SwiftUI

struct ProfileSettingView: View {
    @State private var nameText: String = ""
    @State var shouldShowImagePicker = false
    @State var image: UIImage?
    @EnvironmentObject var viewModel: ViewModel                 // ViewModel
    @Environment(\.dismiss) private var dismiss            // View전환
    
    var body: some View {
            VStack(spacing: 30) {
                Text("프로필 설정")
                .font(.largeTitle)
                
                
                VStack(spacing: 15) {
                    Button {
                        shouldShowImagePicker.toggle()
                    } label: {
                        
                        VStack {
                            if let image = self.image {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 128, height: 128)
                                    .cornerRadius(64)
                            } else {
                                Image(systemName: "person.fill")
                                    .font(.system(size: 64))
                                    .padding()
                                    .foregroundColor(Color(.label))
                            }
                        }
                        .overlay(RoundedRectangle(cornerRadius: 64)
                                    .stroke(Color.black, lineWidth: 3)
                        )
                        
                    }
                    Button {
                        shouldShowImagePicker.toggle()
                    } label: {
                        Text("프로필 사진 변경")
                    }
                }
                


            VStack(alignment: .leading) {
                Text("닉네임")
                    .font(.headline)
                TextField("닉네임을 입력해주세요", text: $nameText)
                    .padding()
                    .background(.thinMaterial)
                    .cornerRadius(10)
                    .textInputAutocapitalization(.never)
            }
                
                Button {



                    viewModel.userSetting(userName: nameText, profileImage: image)
                        dismiss() // 뷰 닫기
                } label: {
                    Text("확인")
                        .frame(width: 100, height: 50)
                        .background(!checkSignUpCondition() ? .gray : Color("MainColor"))
                        .foregroundColor(.white)
                        .cornerRadius(10)
 
                }
                .disabled(!checkSignUpCondition() ? true : false)
            
                
                
            Spacer()
                Button {
                    viewModel.signOut()
                } label: {
                    Text("로그아웃")
                }
        }
        .padding()
        .fullScreenCover(isPresented: $shouldShowImagePicker, onDismiss: nil) {
            ImagePicker(image: $image)
        }
        
    }
        func checkSignUpCondition () -> Bool {
            if  nameText.isEmpty {
                return false
            }
            return true
        }
}

struct ProfileSettingView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSettingView()
    }
}
