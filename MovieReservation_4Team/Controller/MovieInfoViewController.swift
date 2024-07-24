import UIKit

class MovieInfoViewController: UIViewController {
    var movieInfoView = MovieInfoView()
    
    
    
//    let networkManager: NetworkManagerProtocol //같은 프로토콜 채택 중
//    init(networkManager: NetworkManagerProtocol) {
//        self.networkManager = networkManager
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func loadView() {
        view = movieInfoView
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        // 실시간 인기 영화 가져오기
        NetworkManager.shared.fetchPopularMovies(page: 1) { movies in
            if let movies = movies {
                for movie in movies {
                    print("Title: \(movie.title), ID: \(movie.id), Poster Path: \(movie.posterPath ?? "N/A")")
                }
            }
        }
        
//        // 최신 개봉 영화 가져오기
//        NetworkManager.shared.fetchNowPlayingMovies(page: 1) { movies in
//            if let movies = movies {
//                for movie in movies {
//                    print("Title: \(movie.title), ID: \(movie.id), Poster Path: \(movie.posterPath ?? "N/A")")
//                }
//            }
//        }
        
        // 특정 영화의 상세 정보 가져오기
        NetworkManager.shared.fetchMovieDetail(movieId: 1022789) { movieDetail in
            if let movieDetail = movieDetail {
                DispatchQueue.main.async {
                    self.movieInfoView.movieTitleLabel.text = movieDetail.title
                    self.movieInfoView.openingDateLabel.text = movieDetail.releaseDate
                    self.movieInfoView.descriptionLabel.text = movieDetail.overview
                    self.movieInfoView.runningTimeLabel.text = "\(movieDetail.runtime)분"
                    self.movieInfoView.genreLabel.text = movieDetail.genres.map { $0.name }.joined(separator: "/")
                    
                    if let posterPath = movieDetail.posterPath {
                        let fullPosterUrl = "https://image.tmdb.org/t/p/w500/\(posterPath)"
                        self.loadImage(from: fullPosterUrl)
                    }
                }
            }
        }
    }
    
    //MARK: -다운로드한 이미지를 movieInfoView.movieImageView에 설정
    func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        // 네트워크에서 이미지 다운로드
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error loading image: \(error.localizedDescription)")
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                print("Error: Unable to load image data")
                return
            }
            
            // 메인 스레드에서 이미지 뷰 업데이트
            DispatchQueue.main.async {
                self.movieInfoView.movieImageView.image = image
            }
        }.resume()
    }
}
