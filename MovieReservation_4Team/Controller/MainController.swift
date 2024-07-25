import UIKit

class MainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let mainView = MainView()
    
    var firstCollectionViewMovies: [Movie] = []
    var secondCollectionViewMovies: [Movie] = []
    var thirdCollectionViewMovies: [Movie] = []
    var fourthCollectionViewMovies: [Movie] = []
    
    var slideTimer: Timer?
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        fetchData()
        startSlideTimer() // 타이머 시작
        
        self.title = "NIGABOX"
        
        // 프로필 이미지 버튼 추가
        let profileButton = UIButton(type: .custom)
        profileButton.setImage(UIImage(named: "profile"), for: .normal) // "profileImage"는 프로젝트에 추가된 이미지 이름입니다.
        profileButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        profileButton.layer.cornerRadius = 15
        profileButton.clipsToBounds = true
        profileButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        profileButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        profileButton.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
        
        let profileBarButtonItem = UIBarButtonItem(customView: profileButton)
        self.navigationItem.rightBarButtonItem = profileBarButtonItem
    }
    
    @objc func profileButtonTapped() {
        let myPageVC = MyPageController() // 이동할 프로필 페이지
        self.navigationController?.pushViewController(myPageVC, animated: true)
    }
    
    func setupCollectionView() {
        mainView.firstCollectionView.dataSource = self
        mainView.firstCollectionView.delegate = self
        
        mainView.secondCollectionView.dataSource = self
        mainView.secondCollectionView.delegate = self
        
        mainView.thirdCollectionView.dataSource = self
        mainView.thirdCollectionView.delegate = self
        
        mainView.fourthCollectionView.dataSource = self
        mainView.fourthCollectionView.delegate = self
    }
    
    func fetchData() {
        NetworkManager.shared.fetchPopularMovies(page: 1) { [weak self] movies in
            guard let self = self, let movies = movies else { return }
            DispatchQueue.main.async {
                self.firstCollectionViewMovies = movies
                self.mainView.firstCollectionView.reloadData()
            }
        }
        
        NetworkManager.shared.fetchNowPlayingMovies(page: 1) { [weak self] movies in
            guard let self = self, let movies = movies else { return }
            DispatchQueue.main.async {
                self.secondCollectionViewMovies = movies
                self.mainView.secondCollectionView.reloadData()
            }
        }
        
        NetworkManager.shared.fetchPopularMovies(page: 1) { [weak self] movies in
            guard let self = self, let movies = movies else { return }
            DispatchQueue.main.async {
                self.thirdCollectionViewMovies = movies
                self.mainView.thirdCollectionView.reloadData()
            }
        }
        
        NetworkManager.shared.fetchNowPlayingMovies(page: 1) { [weak self] movies in
            guard let self = self, let movies = movies else { return }
            DispatchQueue.main.async {
                self.fourthCollectionViewMovies = movies
                self.mainView.fourthCollectionView.reloadData()
            }
        }
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case mainView.firstCollectionView:
            return firstCollectionViewMovies.count
        case mainView.secondCollectionView:
            return secondCollectionViewMovies.count
        case mainView.thirdCollectionView:
            return thirdCollectionViewMovies.count
        case mainView.fourthCollectionView:
            return fourthCollectionViewMovies.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier(for: collectionView), for: indexPath)
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        
        cell.contentView.layer.cornerRadius = 10
        cell.contentView.layer.shadowColor = UIColor.black.cgColor
        cell.contentView.layer.shadowOpacity = 10
        cell.contentView.layer.shadowOffset = CGSize(width: 0, height: 10)
        cell.contentView.layer.shadowRadius = 8
        
        let movie: Movie
        switch collectionView {
        case mainView.firstCollectionView:
            movie = firstCollectionViewMovies[indexPath.item]
        case mainView.secondCollectionView:
            movie = secondCollectionViewMovies[indexPath.item]
        case mainView.thirdCollectionView:
            movie = thirdCollectionViewMovies[indexPath.item]
        case mainView.fourthCollectionView:
            movie = fourthCollectionViewMovies[indexPath.item]
        default:
            fatalError("Unknown collection view")
        }
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        
        // 첫 번째 컬렉션 뷰는 가로 이미지, 나머지는 세로 포스터
        if collectionView == mainView.firstCollectionView, let backdropPath = movie.backdropPath {
            let imageUrl = "https://image.tmdb.org/t/p/w500\(backdropPath)"
            NetworkManager.shared.loadImage(from: imageUrl, into: imageView)
        } else if let posterPath = movie.posterPath {
            let imageUrl = "https://image.tmdb.org/t/p/w500\(posterPath)"
            NetworkManager.shared.loadImage(from: imageUrl, into: imageView)
        }
        cell.contentView.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        return cell
    }
    
    private func cellIdentifier(for collectionView: UICollectionView) -> String {
        switch collectionView {
        case mainView.firstCollectionView:
            return "FirstCell"
        case mainView.secondCollectionView:
            return "SecondCell"
        case mainView.thirdCollectionView:
            return "ThirdCell"
        case mainView.fourthCollectionView:
            return "FourthCell"
        default:
            return "Cell"
        }
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case mainView.firstCollectionView:
            // 가로 이미지 크기 설정
            return CGSize(width: UIScreen.main.bounds.width - 32, height: 200)
        case mainView.secondCollectionView, mainView.thirdCollectionView, mainView.fourthCollectionView:
            // 세로 포스터 크기 설정
            return CGSize(width: 150, height: 200)
        default:
            return CGSize.zero
        }
    }
    
    // 실시간 인기, 최신, 추천, 상위 평점
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie: Movie
        let movieInfoVC = MovieInfoViewController()
        
        switch collectionView {
        case mainView.firstCollectionView:
            movie = firstCollectionViewMovies[indexPath.item]
            movieInfoVC.readMovieDetail(movieID: movie.id)
        case mainView.secondCollectionView:
            movie = secondCollectionViewMovies[indexPath.item]
            movieInfoVC.readMovieDetail(movieID: movie.id)
        case mainView.thirdCollectionView:
            movie = thirdCollectionViewMovies[indexPath.item]
            movieInfoVC.readMovieDetail(movieID: movie.id)
        case mainView.fourthCollectionView:
            movie = fourthCollectionViewMovies[indexPath.item]
            movieInfoVC.readMovieDetail(movieID: movie.id)
        default:
            fatalError("Unknown collection view")
        }
        
        navigationController?.pushViewController(movieInfoVC, animated: true)
    }
    
    // MARK: - 슬라이드 타이머 설정
    
    func startSlideTimer() {
        slideTimer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(slideToNextItem), userInfo: nil, repeats: true)
    }
    
    func stopSlideTimer() {
        slideTimer?.invalidate()
        slideTimer = nil
    }
    
    @objc func slideToNextItem() {
        let collectionView = mainView.firstCollectionView
        
        let visibleItems = collectionView.indexPathsForVisibleItems.sorted()
        guard let currentItem = visibleItems.first else { return }
        
        let nextItem = IndexPath(item: (currentItem.item + 1) % firstCollectionViewMovies.count, section: currentItem.section)
        
        collectionView.scrollToItem(at: nextItem, at: .centeredHorizontally, animated: true)
    }
}
