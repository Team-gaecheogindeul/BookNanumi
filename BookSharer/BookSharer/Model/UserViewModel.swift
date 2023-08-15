//
//  UserViewModel.swift
//  BookSharer
//
//  Created by 최성빈 on 2023/07/28.
//

import Foundation
import Firebase

struct RecentMessage: Identifiable {
    
    var id: String { documentId }
    
    let documentId: String
    let text, userName: String
    let fromId, toId: String
    let profileImageUrl: String
    let timestamp: Timestamp
    
    init(documentId: String, data: [String: Any]) {
        self.documentId = documentId
        self.text = data["text"] as? String ?? ""
        self.fromId = data["fromId"] as? String ?? ""
        self.toId = data["toId"] as? String ?? ""
        self.profileImageUrl = data["profileImageUrl"] as? String ?? ""
        self.userName = data["userName"] as? String ?? ""
        self.timestamp = data["timestamp"] as? Timestamp ?? Timestamp(date: Date())
    }
}

struct User: Identifiable {
    var id: String { uid }
    
    let uid, email, userName, profileImageUrl: String
    
    init(data: [String: Any]) {
        self.uid = data["uid"] as? String ?? ""
        self.userName = data["userName"] as? String ?? ""
        self.email = data["email"] as? String ?? ""
        self.profileImageUrl = data["profileImageUrl"] as? String ?? ""
    }
}

class UserViewModel: ObservableObject {
    @Published var errorMessage = ""
    @Published var user: User?
    @Published var recentMessages = [RecentMessage]()
    
    init(){
        fetchCurrentUser()
        
        fetchRecentMessages()
    }
    
    private func fetchRecentMessages() { // 새로운 채팅로그가 맨 위로
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        
        FirebaseManager.shared.firestore
            .collection("recent_messages")
            .document(uid)
            .collection("messages")
            .order(by: "timestamp")
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    self.errorMessage = "Failed to listen for recent messages: \(error)"
                    print(error)
                    return
                }
                
                querySnapshot?.documentChanges.forEach({ change in
                    let docId = change.document.documentID
                    
                    if let index = self.recentMessages.firstIndex(where: { rm in
                        return rm.documentId == docId
                    }) {
                        self.recentMessages.remove(at: index)
                    }
                    
                    self.recentMessages.insert(.init(documentId: docId, data: change.document.data()), at: 0)
                    
                    
//                    self.recentMessages.append()
                })
            }
    }
    
    private func fetchCurrentUser() { // 유저 정보 파이어베이스 클라우드 저장
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid
        else { return }
        
        FirebaseManager.shared.firestore.collection("users")
            .document(uid).getDocument{ snapshot, error in
                if let error = error {
                    print("Failed to fetch currnet user:", error)
                    return
                }
            
                guard let data = snapshot?.data() else {
                    print("No data found")
                    return
                    
                }
                
                self.user = .init(data: data)
                

        }
    }
}
