//
//  CommunityView.swift
//  BookSharer
//
//  Created by 최성빈 on 2023/09/04.
//

import SwiftUI

struct CommunityView: View {

    //Menu가 보이는지 안 보이는지에 대한 변수 선언
    
    @Binding var showMenu : Bool
    
     var body: some View {
        let drag = DragGesture()
            .onEnded {
                if $0.translation.width < -100 {
                    withAnimation{
                        self.showMenu = false
                    }
                }
        }
        return GeometryReader{ geometry in
                ZStack(alignment:.leading) {
                    CommunityMainView(showMenu: self.$showMenu)
                        .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                        .offset(x:self.showMenu ? geometry.size.width/2 : 0)
                    
                    if self.showMenu {
                        MenuView(showMenu: $showMenu)
                                           .frame(width:geometry.size.width/2)
                                        .transition(.move(edge: .leading))
                                   }
                }
            .gesture(drag)  //drag로 메뉴 슬라이딩 제어
            }


         
    }
}

struct CommunityMainView: View {
    
    @Binding var showMenu : Bool
    @ObservedObject private var viewModel = CommunityViewModel()
    @State private var showCreatePostView = false
    @State private var communityPosts: [CommunityDTO] = [] // 게시글 목록을 저장할 배열
    
    var body: some View {
        ZStack {
            VStack {
                ComuTopbar(showMenu: $showMenu)
                Divider()
                
                ScrollView {
                    VStack {
                        Text("모든 게시글")
                            .font(.system(size: 24))
                            .fontWeight(.semibold)
                        
                        ForEach(communityPosts, id: \.board_id) { post in
                            MiniCommu(board: post)
                            Divider()
                        }
                    }
                }
                
                Spacer()
            }
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    
                    Button(action: {
                        // 글쓰기 버튼이 눌렸을 때 수행할 액션
                        showCreatePostView.toggle()
                    }) {
                        Image(systemName: "square.and.pencil")
                            .font(.system(size: 24))
                            .padding()
                            .background(Color("MainColor"))
                            .foregroundColor(.white)
                            .cornerRadius(30)
                            .shadow(color: .gray, radius: 3)
                    }
                    .padding()
                    .padding(.bottom)
                }
            }
        }
        .sheet(isPresented: $showCreatePostView) {
            CreateCommu(viewModel: viewModel)
        }
        .onAppear {
            // 화면이 나타날 때 게시글 목록을 가져오도록 호출
            viewModel.fetchCommunityPosts(type: "Free") { result in
                switch result {
                case .success(let posts):
                    // 성공적으로 데이터를 가져온 경우
                    communityPosts = posts
                case .failure(let error):
                    // 데이터 가져오기 실패한 경우
                    print("Error fetching community posts: \(error)")
                }
            }
        }
    }
}


// 사이드 메뉴
struct MenuView: View {
    @Binding var showMenu : Bool
    
    var body: some View {
        VStack(alignment: .leading){
            NavigationLink {
                freeCommu()
            } label: {
                Text("자유게시판")
                        .foregroundColor(.gray)
                        .font(.headline)
                        .padding(.top, 100)
            }
            
            
            Text("학습 게시판")
                .foregroundColor(.gray)
                .font(.headline)
                .padding(.top, 30)
            
            Text("고등학교 입시 게시판")
                    .foregroundColor(.gray)
                    .font(.headline)
                    .padding(.top, 30)
            
            Text("대학교 입시 게시판")
                .foregroundColor(.gray)
                .font(.headline)
                .padding(.top, 30)
            

            
            Spacer()
        }
        .padding(.leading, 14.0)
        .frame(maxWidth: .infinity, alignment:.leading)
        .background(Color(UIColor.systemGray5))
    }
}

//자유게시판
struct freeCommu:View {
    @ObservedObject private var viewModel = CommunityViewModel()
    @State private var communityPosts: [CommunityDTO] = []

    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(communityPosts, id: \.board_id) { post in
                    MiniCommu(board: post)
                    
                }
            }
        }
        .onAppear {
            // 화면이 나타날 때 게시글 목록을 가져오도록 호출
            viewModel.fetchCommunityPosts(type: "Free") { result in
                switch result {
                case .success(let posts):
                    // 성공적으로 데이터를 가져온 경우
                    communityPosts = posts
                case .failure(let error):
                    // 데이터 가져오기 실패한 경우
                    print("Error fetching community posts: \(error)")
                }
            }
        }
    }
}


struct CommunityView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityView(showMenu: .constant(false))
    }
}
