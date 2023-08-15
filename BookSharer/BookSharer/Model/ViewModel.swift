//
//  ViewModel.swift
//  BookSharer
//
//  Created by 최성빈 on 2023/07/17.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser
import UIKit







class ViewModel: ObservableObject {
    @Published var state: SignInState = .signedOut
    @Published var image: UIImage?
    
    let firebaseManager = FirebaseManager.shared
    
    enum SignInState{
        case signedIn
        case signedOut
    }
    
    func emailAuthSignUp(email: String, password: String, completion: (() -> Void)?)  {

        firebaseManager.auth.createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("error: \(error.localizedDescription)")
                
                return
            }
            

            completion?()
            self.emailAuthSignIn(email: email, password: password)
            // 회원가입 후 자동 로그인
        }
    }
    
    func userSetting(userName: String, profileImage: UIImage?) {
        guard let profileImage = profileImage else {
            print("Profile image is missing")
            return
        }
        self.image = profileImage

        let changeRequest = firebaseManager.auth.currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = userName
        changeRequest?.commitChanges { [weak self] error in
            if let error = error {
                print("Error updating displayName: \(error.localizedDescription)")
            }
        }
        
        self.persistImageToStorage()
    }
    

    private func persistImageToStorage() {
        guard let uid = firebaseManager.auth.currentUser?.uid else {return}
        let ref = firebaseManager.storage.reference(withPath: uid)
        guard let imageData = image?.jpegData(compressionQuality: 0.5) else {
            print("Failed to upload image to Storage: Missing information")
            return
        }

        
        ref.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                print("Failed to push image to Storage: \(error)")
                return
            }

            ref.downloadURL { url, error in
                if let error = error {
                    print("Failed to retrieve downloadURL: \(error)")
                    return
                }

                guard let url = url else { return }
                self.storeUserInformation(imageProfileUrl: url)
            }
        }
    }
    
    private func storeUserInformation(imageProfileUrl: URL) {
        guard let uid = firebaseManager.auth.currentUser?.uid else { return }
        guard let email = firebaseManager.auth.currentUser?.email else { return }
        guard let userName = firebaseManager.auth.currentUser?.displayName else { return }
        let userData = ["email": email, "uid": uid,"userName": userName, "profileImageUrl": imageProfileUrl.absoluteString]
        FirebaseManager.shared.firestore.collection("users")
            .document(uid).setData(userData) { err in
                if let err = err {
                    print(err)
                    return
                }
                
                print("Success")
            }
    }

    
    func emailAuthSignIn(email: String, password: String) {
        firebaseManager.auth.signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("error: \(error.localizedDescription)")
                
                return
            }
            
            if result != nil {
                self.state = .signedIn
                print("사용자 이메일: \(String(describing: result?.user.email))")
                print("사용자 이름: \(String(describing: result?.user.displayName))")

            }
        }
    }
    
    

    
    // MARK: - KakaoAuth SignIn Function
    func kakaoAuthSignIn() {
        if AuthApi.hasToken() { // 발급된 토큰이 있는지
            UserApi.shared.accessTokenInfo { _, error in // 해당 토큰이 유효한지
                if let error = error { // 에러가 발생했으면 토큰이 유효하지 않다.
                    self.openKakaoService()
                } else { // 유효한 토큰
                    self.loadingInfoDidKakaoAuth()
                }
            }
        } else { // 만료된 토큰
            self.openKakaoService()
        }
    }
    
    func openKakaoService() {
        if UserApi.isKakaoTalkLoginAvailable() { // 카카오톡 앱 이용 가능한지
            UserApi.shared.loginWithKakaoTalk { oauthToken, error in // 카카오톡 앱으로 로그인
                if let error = error { // 로그인 실패 -> 종료
                    print("Kakao Sign In Error: ", error.localizedDescription)
                    return
                }
                
                _ = oauthToken // 로그인 성공
                self.loadingInfoDidKakaoAuth() // 사용자 정보 불러와서 Firebase Auth 로그인하기
            }
        } else { // 카카오톡 앱 이용 불가능한 사람
            UserApi.shared.loginWithKakaoAccount { oauthToken, error in // 카카오 웹으로 로그인
                if let error = error { // 로그인 실패 -> 종료
                    print("Kakao Sign In Error: ", error.localizedDescription)
                    return
                }
                _ = oauthToken // 로그인 성공
                self.loadingInfoDidKakaoAuth() // 사용자 정보 불러와서 Firebase Auth 로그인하기
            }
        }
    }
    
    func loadingInfoDidKakaoAuth() {
        UserApi.shared.me { kakaoUser, error in
            if let error = error {
                print("카카오톡 사용자 정보 불러오는데 실패했습니다.")
                return
            }

            guard let email = kakaoUser?.kakaoAccount?.email else { return }
            guard let password = kakaoUser?.id else { return }

            Auth.auth().fetchSignInMethods(forEmail: email) { (providers, error) in
                if let providers = providers, !providers.isEmpty {
                    // 계정이 이미 존재하면 로그인 시도
                    self.emailAuthSignIn(email: email, password: "\(password)")
                } else {
                    // 계정이 없으면 가입 시도
                    self.emailAuthSignUp(email: email, password: "\(password)") {
                        self.emailAuthSignIn(email: email, password: "\(password)")
                    }
                }
            }
        }
    }

    
    func signOut() {
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.logout { error in
                if let error = error {
                    print("Kakao logout failed: \(error.localizedDescription)")
                } else {
                    do {
                        try self.firebaseManager.auth.signOut()
                        self.state = .signedOut
                        print("Logout success")
                    } catch let error {
                        print("Firebase signout error: \(error.localizedDescription)")
                    }
                }
            }
        } else {
            do {
                try firebaseManager.auth.signOut()
                self.state = .signedOut
                print("Logout success")
            } catch let error {
                print("Logout error: \(error.localizedDescription)")
            }
        }
    }


}


