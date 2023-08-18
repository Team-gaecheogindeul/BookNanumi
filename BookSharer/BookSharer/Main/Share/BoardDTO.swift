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
    let userSeq: Int?
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
    
    init(boardGiveId: Int? = nil, boardTitle: String? = nil, userSeq: Int? = nil, categoryId: String? = nil, subCategoryId: String? = nil, bookStory: String? = nil, stateUnderscore: String? = nil, stateNotes: String? = nil, stateCover: String? = nil, stateWrittenName: String? = nil, statePageColorChange: String? = nil, statePageDamage: String? = nil, cityId: String? = nil, meetWantLocation: String? = nil, parcelIndex: String? = nil, directIndex: String? = nil, userName: String? = nil, date: String? = nil) {
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
    }
}

struct BoardEntity {
    var id: Int64 // 나눔 게시글 아이디
    var boardTitle: String // 게시글 제목
    var userSeq: Int // 회원 일련번호
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
    }
}




class BoardViewModel: ObservableObject {
    @Published var boards = [BoardDTO]()
    
    private let delegateHelper = URLSessionDelegateHelper()

    init() {
        loadData()
    }

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
                print("Received data: \(String(data: data, encoding: .utf8) ?? "Invalid data")")
                
                do {
                    if let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                       let boardTotalList = jsonObject["boardTotalList"] as? [[String: Any]] {
                        
                        var decodedBoards: [BoardDTO] = []
                        for board in boardTotalList {
                            print(board)
                            let boardGiveId = board["board_give_id"] as? Int
                            let boardTitle = board["board_title"] as? String
                            let userSeq = board["user_seq"] as? Int
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
                            let boardDTO = BoardDTO(boardGiveId: boardGiveId ?? 1, boardTitle: boardTitle ?? "", userSeq: userSeq!, categoryId: categoryId!,subCategoryId: subCategoryId ?? "", bookStory: bookStory ?? "", stateUnderscore: stateUnderscore ?? "", stateNotes: stateNotes ?? "", stateCover: stateCover ?? "", stateWrittenName: stateWrittenName ?? "", statePageColorChange: statePageColorChange ?? "", statePageDamage: statePageDamage ?? "", cityId: cityId ?? "", meetWantLocation: meetWantLocation ?? "", parcelIndex: parcelIndex ?? "", directIndex: directIndex ?? "", userName: userName ?? "", date: date ?? "")
                                
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
            "date": boardDTO.date
        ]

        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: boardDict, options: []) else {
            print("Error: Failed to create jsonData")
            return
        }
        request.httpBody = jsonData
        print(String(data: jsonData, encoding: .utf8) ?? "Invalid JSON")


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

}


struct ServerResponse: Codable {
    let result: String
}
