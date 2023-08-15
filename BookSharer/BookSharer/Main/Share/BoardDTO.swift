import SwiftUI
import Foundation
import Combine

// 게시글 등록
struct BoardDTO: Codable {
    var boardGiveId: Int64 // 나눔 게시글 아이디
    var boardTitle: String // 게시글 제목
    var userSeq: Int // 회원 일련번호

    var categoryId: Int // 책 카테고리 아이디
    var bookTitle: String // 책 제목
    var bookStory: String // 책 내용
    var bookWriter: String // 작가이름
    var publisherName: String // 출판사
    var publisherDate: String // 출판일

    var stateUnderscore: Int // 상태_밑줄 흔적
    var stateNotes: Int // 상태_필기 흔적
    var stateCover: Int // 상태_겉표지 상태
    var stateWrittenName: Int // 상태_이름 기입
    var statePageColorChange: Int // 상태_페이지 변색
    var statePageDamage: Int // 상태_페이지_손상

    var cityId: Int // 지역 아이디
    var meetWantLocation: Int // 거래 희망 지역
}

struct BoardEntity {
    var id: Int64 // 나눔 게시글 아이디
    var boardTitle: String // 게시글 제목
    var userSeq: Int // 회원 일련번호
    var categoryId: Int // 책 카테고리 아이디
    var bookTitle: String // 책 제목
    var bookStory: String // 책 내용
    var bookWriter: String // 작가이름
    var publisherName: String // 출판사
    var publisherDate: String // 출판일
    var stateUnderscore: Int // 상태_밑줄 흔적
    var stateNotes: Int // 상태_필기 흔적
    var stateCover: Int // 상태_겉표지 상태
    var stateWrittenName: Int // 상태_이름 기입
    var statePageColorChange: Int // 상태_페이지 변색
    var statePageDamage: Int // 상태_페이지_손상
    var cityId: Int // 지역 아이디
    var meetWantLocation: Int // 거래 희망 지역
}

extension BoardDTO {
    init(boardEntity: BoardEntity) {
        self.boardGiveId = boardEntity.id
        self.boardTitle = boardEntity.boardTitle
        self.userSeq = boardEntity.userSeq
        self.categoryId = boardEntity.categoryId
        self.bookTitle = boardEntity.bookTitle
        self.bookStory = boardEntity.bookStory
        self.bookWriter = boardEntity.bookWriter
        self.publisherName = boardEntity.publisherName
        self.publisherDate = boardEntity.publisherDate
        self.stateUnderscore = boardEntity.stateUnderscore
        self.stateNotes = boardEntity.stateNotes
        self.stateCover = boardEntity.stateCover
        self.stateWrittenName = boardEntity.stateWrittenName
        self.statePageColorChange = boardEntity.statePageColorChange
        self.statePageDamage = boardEntity.statePageDamage
        self.cityId = boardEntity.cityId
        self.meetWantLocation = boardEntity.meetWantLocation
    }
}


// 게시글 조회/목록
struct BoardTotalDTO: Codable {
    var boardGiveId: Int64 // 나눔 게시글 아이디
    var boardTitle: String // 게시글 제목
    var categoryId: Int // 책 카테고리 아이디
    var meetWantLocation: Int // 거래 희망 지역
}

extension BoardTotalDTO {
    init(boardTotalEntity: BoardTotalEntity) {
        self.boardGiveId = boardTotalEntity.id
        self.boardTitle = boardTotalEntity.boardTitle
        self.categoryId = boardTotalEntity.categoryId
        self.meetWantLocation = boardTotalEntity.meetWantLocation
    }
}

struct BoardTotalEntity {
    var id: Int64 // 나눔 게시글 아이디
    var boardTitle: String // 게시글 제목
    var categoryId: Int // 책 카테고리 아이디
    var meetWantLocation: Int // 거래 희망 지역
}

class BoardViewModel: ObservableObject {
    @Published var boards = [BoardTotalDTO]()

    init() {
        loadData()
    }

    func loadData() {
        guard let url = URL(string: "http://localhost:8443/posting/sharing") else { return }
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error loading data: \(error.localizedDescription)")
                return
            }

            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                print("Server responded with non-OK status code: \(httpResponse.statusCode)")
                return
            }

            if let data = data {
                if let decodedData = try? JSONDecoder().decode([BoardTotalDTO].self, from: data) {
                    DispatchQueue.main.async {
                        self.boards = decodedData
                    }
                    return
                }
            }
        }.resume()
    }

    func save(boardDTO: BoardDTO, completion: @escaping (Result<String, Error>) -> Void) {
        let url = URL(string: "http://localhost:8443/posting/sharing")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        do {
            let jsonData = try JSONEncoder().encode(boardDTO)
            request.httpBody = jsonData
        } catch {
            completion(.failure(error))
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
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
                    let jsonResponse = try JSONDecoder().decode(ServerResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.loadData()
                    }
                    completion(.success(jsonResponse.result))
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
