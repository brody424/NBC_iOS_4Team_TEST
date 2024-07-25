import UIKit
class MovieInfoViewController: UIViewController {
    
    var movieInfoView = MovieInfoView()
    
    //  let networkManager: NetworkManagerProtocol //같은 프로토콜 채택 중
    //  init(networkManager: NetworkManagerProtocol) {
    //    self.networkManager = networkManager
    //  }
    //
    //  required init?(coder: NSCoder) {
    //    fatalError("init(coder:) has not been implemented")
    //  }
    
    override func loadView() {
        view = movieInfoView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieInfoView.reservationButton.addTarget(self, action: #selector(showModal), for: .touchDown)
        
//        readMovieDetail()
    }
    
    // [예약하기] 버튼 클릭 시 모달 띄우기
    @objc
    func showModal(){
        let modalVc = ModalViewController()
        if let modal = modalVc.sheetPresentationController {
            modal.detents = [.medium()]
        }
        present(modalVc, animated: true)
    }
    
    //ModalVC에서 데이터를 전달 받아오는 메서드
    func selectedMovieData(count: String, date: String, movieID: Int) {
      let vc = ReservaitionController()
      print(count, date, movieID)
      navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func readMovieDetail(movieID: Int) {
        // 특정 영화의 상세 정보 가져오기
        var movieId = 0
        NetworkManager.shared.fetchMovieDetail(movieId: movieID) { movieDetail in
            movieId = movieID
            print(movieId)
            
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
                        //            NetworkManager.shared.loadImage(from: fullPosterUrl) { image in
                        //              self.movieInfoView.movieImageView.image = image
                        //            }
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

#Preview {
    let MovieInfoViewController = MovieInfoViewController()
    return MovieInfoViewController
}
