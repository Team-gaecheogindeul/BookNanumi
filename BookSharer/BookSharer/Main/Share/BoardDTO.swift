import SwiftUI
import Foundation
import Combine

struct MessageResponse: Codable {
    let message: String
}

// 게시글 등록

struct BoardList {
    let boardTotalList: [BoardDTO]
}

struct BoardDTO: Codable {
    let boardGiveId: Int?
    let boardTitle: String?
    let userSeq: String?
    let categoryId: String?
    let subCategoryId: String?
    let bookStory: String?
    let stateUnderscore: String?
    let stateNotes: String?
    let stateCover: String?
    let stateWrittenName: String?
    let statePageColorChange: String?
    let statePageDamage: String?
    let cityId: String?
    let meetWantLocation: String?
    let parcelIndex: String?
    let directIndex: String?
    let userName: String?
    let date: String?
    let imageUrls: [String]?
    let likeCount: Int?
    
    init(boardGiveId: Int? = nil, boardTitle: String? = nil, userSeq: String? = nil, categoryId: String? = nil, subCategoryId: String? = nil, bookStory: String? = nil, stateUnderscore: String? = nil, stateNotes: String? = nil, stateCover: String? = nil, stateWrittenName: String? = nil, statePageColorChange: String? = nil, statePageDamage: String? = nil, cityId: String? = nil, meetWantLocation: String? = nil, parcelIndex: String? = nil, directIndex: String? = nil, userName: String? = nil, date: String? = nil, imageUrls: [String]? = nil, likeCount: Int? = 0) {
        self.boardGiveId = boardGiveId
        self.boardTitle = boardTitle
        self.userSeq = userSeq
        self.categoryId = categoryId
        self.subCategoryId = subCategoryId
        self.bookStory = bookStory
        self.stateUnderscore = stateUnderscore
        self.stateNotes = stateNotes
        self.stateCover = stateCover
        self.stateWrittenName = stateWrittenName
        self.statePageColorChange = statePageColorChange
        self.statePageDamage = statePageDamage
        self.cityId = cityId
        self.meetWantLocation = meetWantLocation
        self.parcelIndex = parcelIndex
        self.directIndex = directIndex
        self.userName = userName
        self.date = date
        self.imageUrls = imageUrls
        self.likeCount = likeCount
    }
}

struct BoardEntity {
    var id: Int64 // 나눔 게시글 아이디
    var boardTitle: String // 게시글 제목
    var userSeq: String // 회원 일련번호
    var categoryId: String // 책 카테고리 아이디
    var subCategoryId: String // 책 카테고리 아이디
    var bookStory: String // 책 내용
    var stateUnderscore: String // 상태_밑줄 흔적
    var stateNotes: String // 상태_필기 흔적
    var stateCover: String // 상태_겉표지 상태
    var stateWrittenName: String // 상태_이름 기입
    var statePageColorChange: String // 상태_페이지 변색
    var statePageDamage: String // 상태_페이지_손상
    var cityId: String // 지역 아이디
    var meetWantLocation: String // 거래 희망 지역
    var parcelIndex: String // 택배
    var directIndex: String // 직거래
    var userName: String // 작성자 이름
    var date: String // 날짜
    var imageUrls: [String] // 이미지
    var likeCoount: Int64
}

extension BoardDTO {
    init(boardEntity: BoardEntity) {
        self.boardGiveId = Int(boardEntity.id)
        self.boardTitle = boardEntity.boardTitle
        self.userSeq = boardEntity.userSeq
        self.categoryId = boardEntity.categoryId
        self.subCategoryId = boardEntity.subCategoryId
        self.bookStory = boardEntity.bookStory
        self.stateUnderscore = boardEntity.stateUnderscore
        self.stateNotes = boardEntity.stateNotes
        self.stateCover = boardEntity.stateCover
        self.stateWrittenName = boardEntity.stateWrittenName
        self.statePageColorChange = boardEntity.statePageColorChange
        self.statePageDamage = boardEntity.statePageDamage
        self.cityId = boardEntity.cityId
        self.meetWantLocation = boardEntity.meetWantLocation
        self.parcelIndex = boardEntity.parcelIndex
        self.directIndex = boardEntity.directIndex
        self.userName = boardEntity.userName
        self.date = boardEntity.date
        self.imageUrls = boardEntity.imageUrls
        self.likeCount = Int(boardEntity.likeCoount)
    }
}


// 커뮤니티 구조체
struct CommunityPost: Codable {
    var title: String
    var content: String
    var category: String
}




class BoardViewModel: ObservableObject {
    @Published var boards = [BoardDTO]()
    @Published var isLiked: Bool = false
    
    private let delegateHelper = URLSessionDelegateHelper()

    init() {
        loadData()
    }

    // 사진 첨부
    
    //[#2. 모든 나눔 게시글 전체 조회]
    func loadData() {
        guard let url = URL(string: "https://43.200.206.14:8443/posting/sharingAll") else { return }
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        let session = URLSession(configuration: .default, delegate: delegateHelper, delegateQueue: nil)
        session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error loading data: \(error.localizedDescription)")
                return
            }

            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                print("Server responded with non-OK status code: \(httpResponse.statusCode)")
                return
            }

            if let data = data {
               // print("Received data: \(String(data: data, encoding: .utf8) ?? "Invalid data")")
                
                do {
                    if let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                       let boardTotalList = jsonObject["boardTotalList"] as? [[String: Any]] {
                        
                        var decodedBoards: [BoardDTO] = []
                        for board in boardTotalList {
                            let boardGiveId = board["board_give_id"] as? Int
                            let boardTitle = board["board_title"] as? String
                            let userSeq = board["user_seq"] as? String
                            let categoryId = board["category_id"] as? String
                            let subCategoryId = board["sub_category_id"] as? String
                            let bookStory = board["book_story"] as? String
                            let stateUnderscore = board["state_underscore"] as? String
                            let stateNotes = board["state_notes"] as? String
                            let stateCover = board["state_cover"] as? String
                            let stateWrittenName = board["state_written_name"] as? String
                            let statePageColorChange = board["state_page_color_change"] as? String
                            let statePageDamage = board["state_page_damage"] as? String
                            let cityId = board["city_id"] as? String
                            let meetWantLocation = board["meet_want_location"] as? String
                            let parcelIndex = board["parcel_index"] as? String
                            let directIndex = board["direct_index"] as? String
                            let userName = board["user_name"] as? String
                            let date = board["date"] as? String
                            let imageUrls = board["imageUrls"] as? [String]
                            let likeCount = board["likeCount"] as? Int
                            let boardDTO = BoardDTO(boardGiveId: boardGiveId ?? 1, boardTitle: boardTitle ?? "", userSeq: userSeq ?? "", categoryId: categoryId!,subCategoryId: subCategoryId ?? "", bookStory: bookStory ?? "", stateUnderscore: stateUnderscore ?? "", stateNotes: stateNotes ?? "", stateCover: stateCover ?? "", stateWrittenName: stateWrittenName ?? "", statePageColorChange: statePageColorChange ?? "", statePageDamage: statePageDamage ?? "", cityId: cityId ?? "", meetWantLocation: meetWantLocation ?? "", parcelIndex: parcelIndex ?? "", directIndex: directIndex ?? "", userName: userName ?? "", date: date ?? "", imageUrls: imageUrls ?? [], likeCount: likeCount ?? 0)
                                
                                decodedBoards.append(boardDTO)
                            
                        }
                        
                        DispatchQueue.main.async {
                            self.boards = decodedBoards
                            
                        }
                        
                    } else {
                        print("Failed to parse JSON!")
                    }
                } catch {
                    print("Failed to decode JSON!")
                }

            }
        }.resume()
    }


    //[#1. (개인) 나눔 게시글 등록 - BoardService 클래스 호출]
    func save(boardDTO: BoardDTO, completion: @escaping (Result<String, Error>) -> Void) {
        let url = URL(string: "https://43.200.206.14:8443/posting/sharing")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        let boardDict: [String: Any] = [
            "board_give_id": boardDTO.boardGiveId,
            "board_title": boardDTO.boardTitle,
            "user_seq": boardDTO.userSeq,
            "category_id": boardDTO.categoryId,
            "sub_category_id": boardDTO.subCategoryId,
            "book_story": boardDTO.bookStory,
            "state_underscore": boardDTO.stateUnderscore,
            "state_notes": boardDTO.stateNotes,
            "state_cover": boardDTO.stateCover,
            "state_written_name": boardDTO.stateWrittenName,
            "state_page_color_change": boardDTO.statePageColorChange,
            "state_page_damage": boardDTO.statePageDamage,
            "city_id": boardDTO.cityId,
            "meet_want_location": boardDTO.meetWantLocation,
            "parcel_index": boardDTO.parcelIndex,
            "direct_index": boardDTO.directIndex,
            "user_name": boardDTO.userName,
            "date": boardDTO.date,
            "imageUrls": boardDTO.imageUrls,
            "likeCount": boardDTO.likeCount
        ]

        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: boardDict, options: []) else {
            print("Error: Failed to create jsonData")
            return
        }
        request.httpBody = jsonData
        //print(String(data: jsonData, encoding: .utf8) ?? "Invalid JSON")


        let session = URLSession(configuration: .default, delegate: delegateHelper, delegateQueue: nil)
        session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                completion(.failure(NSError(domain: "ResponseError", code: httpResponse.statusCode, userInfo: nil)))
                return
            }
            if let data = data {
                let dataString = String(data: data, encoding: .utf8)
                print("Server response: \(dataString ?? "No data string")")
                
                do {
                    if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                       let message = jsonResponse["message"] as? String {
                        DispatchQueue.main.async {
                            self.loadData()
                        }
                        completion(.success(message))
                    } else {
                        completion(.failure(NSError(domain: "ResponseError", code: -2, userInfo: [NSLocalizedDescriptionKey: "Invalid JSON response"])))
                    }
                } catch {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(NSError(domain: "ResponseError", code: -1, userInfo: [NSLocalizedDescriptionKey: "No response data"])))
            }
        }.resume()
    }

    //[#7. 좋아요/좋아요 취소 누르기]
    func sendLike(user_seq: String, board_give_id: Int) {
        guard let url = URL(string: "https://43.200.206.14:8443/LikeOrNot") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let parameters = ["user_seq": user_seq, "board_give_id": board_give_id] as [String : Any]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
            return
        }
        let session = URLSession(configuration:.default, delegate:self.delegateHelper, delegateQueue:nil)
        session.dataTask(with:request) { (data, response, error) in
            if let error = error {
                print("Error sending like:", error)
                return
            }

            if let httpResponse = response as? HTTPURLResponse,
               httpResponse.statusCode != 200 {
                print("Server responded with non-OK status code:", httpResponse.statusCode)
                
                if let data = data {
                    let responseString = String(data: data, encoding: .utf8)
                    print("Server response body:", responseString ?? "No response body")
                }
                
                return
            }


            // Handle response here
            DispatchQueue.main.async {
                self.isLiked = true
            }
            
        }.resume()

    }
    // [#9. 키워드로 게시글 전체 조회]
    func search(keyword: String, page: Int) {
        guard let encodedKeyword = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "https://43.200.206.14:8443/search?keyword=\(encodedKeyword)") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        let session = URLSession(configuration: .default, delegate: delegateHelper, delegateQueue: nil)
        session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error loading data:", error.localizedDescription)
                return
            }

            if let httpResponse = response as? HTTPURLResponse,
               httpResponse.statusCode != 200 {
                print("Server responded with non-OK status code:", httpResponse.statusCode)
                return
            }

            if let data = data {
                do {
                    if let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any],
                       let boardDTOSearchResultList = jsonObject["boardDTOSearchResult"] as? [[String : Any]] {

                        var decodedBoardsSearchResults:[BoardDTO] = []
                        for board in boardDTOSearchResultList {

                            // TODO - BoardDTO의 필드에 맞게 파싱 코드 수정 필요

                            let boardGiveId = board["board_give_id"] as? Int
                            let boardTitle = board["board_title"] as? String
                            let userSeq = board["user_seq"] as? String
                            let categoryId = board["category_id"] as? String
                            let subCategoryId = board["sub_category_id"] as? String
                            let bookStory = board["book_story"] as? String
                            let stateUnderscore = board["state_underscore"] as? String
                            let stateNotes = board["state_notes"] as? String
                            let stateCover = board["state_cover"] as? String
                            let stateWrittenName = board["state_written_name"] as? String
                            let statePageColorChange = board["state_page_color_change"] as? String
                            let statePageDamage = board["state_page_damage"] as? String
                            let cityId = board["city_id"] as? String
                            let meetWantLocation = board["meet_want_location"] as? String
                            let parcelIndex = board["parcel_index"] as? String
                            let directIndex = board["direct_index"] as? String
                            let userName = board["user_name"] as? String
                            let date = board["date"] as? String
                            let imageUrls = board["imageUrls"] as? [String]
                            let likeCount = board["likeCount"] as? Int
                            let boardDTO = BoardDTO(boardGiveId: boardGiveId ?? 1, boardTitle: boardTitle ?? "", userSeq: userSeq!, categoryId: categoryId!,subCategoryId: subCategoryId ?? "", bookStory: bookStory ?? "", stateUnderscore: stateUnderscore ?? "", stateNotes: stateNotes ?? "", stateCover: stateCover ?? "", stateWrittenName: stateWrittenName ?? "", statePageColorChange: statePageColorChange ?? "", statePageDamage: statePageDamage ?? "", cityId: cityId ?? "", meetWantLocation: meetWantLocation ?? "", parcelIndex: parcelIndex ?? "", directIndex: directIndex ?? "", userName: userName ?? "", date: date ?? "", imageUrls: imageUrls ?? [], likeCount: likeCount ?? 0)

                            decodedBoardsSearchResults.append(boardDTO)
                        }

                        DispatchQueue.main.async {
                            self.boards = decodedBoardsSearchResults
                        }
                    } else {
                        print("Failed to parse JSON!")
                    }
                } catch {
                    print("Failed to decode JSON!")
                }
            }
        }.resume()
    }
    
    //[#1. 게시글 등록 ] -저장 완료-
    func savePost(_ post: CommunityPost) {
        // 게시글 카테고리에 따른 URL 생성
        let url = URL(string: "https://43.200.206.14:8443\(post.category)Posting/")!

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let encoder = JSONEncoder()
        
        do {
            let jsonData = try encoder.encode(post)
            request.httpBody = jsonData
            
            request.setValue("application/json", forHTTPHeaderField:"Content-Type")
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                
                if let error = error {
                    print("Error occurred during the network call", error)
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse,
                   !(200...299).contains(httpResponse.statusCode) {
                    print("Server responded with status code \(httpResponse.statusCode)")
                    return
                }
                
                print("Successfully saved post")
                
            }.resume()
            
        } catch {
            print("Failed to encode post:", error)
        }
    }


    
    
    
    
}


struct ServerResponse: Codable {
    let result: String
}
