//
//  ChattingDetails.swift
//  BookSharer
//
//  Created by 최성빈 on 2023/07/01.
//

import SwiftUI

struct ChattingDetails: View {
    
    let user: User?
    
    init(user: User?) {
        self.user = user
        self.vm = .init(user: user)
    }
    
    @ObservedObject var vm: ChattingDetailsViewModel
    
    var body: some View {
        ZStack {
            messagesView
            Text(vm.errorMessage)
        }
        .navigationTitle(user?.userName ?? "")
            .navigationBarTitleDisplayMode(.inline)
//            .navigationBarItems(trailing: Button(action: {
//                vm.count += 1
//            }, label: {
//                Text("Count: \(vm.count)")
//            }))
    }
    
    static let emptyScrollToString = "Empty"
    
    private var messagesView: some View {
        VStack {
            if #available(iOS 15.0, *) {
                ScrollView {
                    ScrollViewReader { scrollViewProxy in
                        VStack {
                            ForEach(vm.chatMessages) { message in
                                MessageView(message: message)
                            }
                            
                            HStack{ Spacer() }
                            .id(Self.emptyScrollToString)
                        }
                        .onReceive(vm.$count) { _ in
                            withAnimation(.easeOut(duration: 0.5)) {
                                scrollViewProxy.scrollTo(Self.emptyScrollToString, anchor: .bottom)
                            }
                            
                        }
                        
                        
                        
                    }
                    
                }
                .safeAreaInset(edge: .bottom) {
                    chatBottomBar
                        .background(Color(.systemBackground).ignoresSafeArea())
                }
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
    private var chatBottomBar: some View {
        HStack(spacing: 16) {
            Image(systemName: "photo.on.rectangle")
                .font(.system(size: 24))
                .foregroundColor(Color("MainColor"))
            
            ZStack(alignment: .trailing) {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(height: 33)
                    .background(Color(red: 0.96, green: 0.96, blue: 0.96))
                    .cornerRadius(6)
                
                TextEditor(text: $vm.chatText)
                    .opacity(vm.chatText.isEmpty ? 0.5 : 1)
                    .padding(.trailing, 40) // 이 부분을 추가하여 텍스트가 버튼 뒤에 보이지 않게 만듭니다.
                
                Button {
                    vm.handleSend()
                } label: {
                    Image(systemName: "paperplane.circle")
                        .font(.system(size: 26))
                        .foregroundColor(Color("MainColor"))
                        .frame(height: 33) 
                        .background(.clear)
                }
                .cornerRadius(6)
                .padding(.trailing, 8)
            }
            .frame(height: 40)

        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }


}

struct MessageView: View {
    
    let message: ChatMessage
    
    var body: some View {
        VStack {
            if message.fromId == FirebaseManager.shared.auth.currentUser?.uid {
                HStack {
                    Spacer()
                    HStack {
                        Text(message.text)
                            .foregroundColor(.white)
                    }
                    .padding()
                    .background(Color("MainColor"))
                    .cornerRadius(8)
                }
            } else {
                HStack {
                    HStack {
                        Text(message.text)
                            .foregroundColor(.black)
                    }
                    .padding()
                    .background(Color(red: 0.96, green: 0.96, blue: 0.96))
                    .cornerRadius(8)
                    Spacer()
                }
            }
        }
        .padding(.horizontal)
        .padding(.top, 8)
    }
}





struct ChattingDetails_Previews: PreviewProvider {
    static var exampleUser: User = {
        let data: [String: Any] = [
            "uid": "1",
            "userName": "ExampleUser",
            "email": "example@user.com",
            "profileImageUrl": "https://example.com/example-image.jpg"
        ]
        return User(data: data)
    }()
    
    static let exampleViewModel = ChattingDetailsViewModel(user: exampleUser)
    
    static var previews: some View {
        ChattingDetails(user: exampleUser)
    }
}

