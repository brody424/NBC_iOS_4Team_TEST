import Foundation

struct Movie: Decodable {
    let id: Int
    let title: String
    let posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
    }
}

struct MovieDetail: Decodable {
    let title: String
    let overview: String
    let releaseDate: String
    let genres: [Genre]
    let voteAverage: Double
    let runtime: Int
    let posterPath: String?
    
    struct Genre: Decodable {
        let name: String
    }
    
    enum CodingKeys: String, CodingKey {
        case title
        case overview
        case releaseDate = "release_date"
        case genres
        case voteAverage = "vote_average"
        case runtime
        case posterPath = "poster_path"
    }
}

class NetworkManager {
    static let shared = NetworkManager()
    private let apiKey = "c272149d0f0d1ed77d32b7d71522185e"
    private let baseUrl = "https://api.themoviedb.org/3"
    
    private init() {}
    
    //MARK: -실시간 인기 영화 가져오기
    func fetchPopularMovies(page: Int, completion: @escaping ([Movie]?) -> Void) {
        let urlString = "\(baseUrl)/movie/popular?api_key=\(apiKey)&language=ko-KR&region=KR&page=\(page)"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data returned")
                completion(nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(MovieResponse.self, from: data)
                completion(result.results)
            } catch let jsonError {
                print("JSON error: \(jsonError.localizedDescription)")
                print(String(data: data, encoding: .utf8) ?? "No readable data")
                completion(nil)
            }
        }
        
        task.resume()
    }
    
    
    //MARK: -최신 개봉 영화 가져오기
    func fetchNowPlayingMovies(page: Int, completion: @escaping ([Movie]?) -> Void) {
        let urlString = "\(baseUrl)/movie/now_playing?api_key=\(apiKey)&language=ko-KR&region=KR&page=\(page)"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data returned")
                completion(nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(MovieResponse.self, from: data)
                completion(result.results)
            } catch let jsonError {
                print("JSON error: \(jsonError.localizedDescription)")
                print(String(data: data, encoding: .utf8) ?? "No readable data")
                completion(nil)
            }
        }
        
        task.resume()
    }
    
    //MARK: -특정 영화 상세 정보 가져오기 
    func fetchMovieDetail(movieId: Int, completion: @escaping (MovieDetail?) -> Void) {
        let urlString = "\(baseUrl)/movie/\(movieId)?api_key=\(apiKey)&language=ko-KR"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data returned")
                completion(nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let movieDetail = try decoder.decode(MovieDetail.self, from: data)
                completion(movieDetail)
            } catch let jsonError {
                print("JSON error: \(jsonError.localizedDescription)")
                print(String(data: data, encoding: .utf8) ?? "No readable data")
                completion(nil)
            }
        }
        
        task.resume()
    }
}

struct MovieResponse: Decodable {
    let results: [Movie]
}
