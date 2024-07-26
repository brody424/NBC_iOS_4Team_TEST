import UIKit

class MainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let mainView = MainView()
    
    var firstCollectionViewMovies: [Movie] = []
    var secondCollectionViewMovies: [Movie] = []
    var thirdCollectionViewMovies: [Movie] = []
    var fourthCollectionViewMovies: [Movie] = []
    var selectedCategoryMovies: [Movie] = []
    
    var slideTimer: Timer?
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        fetchData()
        startSlideTimer() // 타이머 시작
        
        self.navigationItem.title = "NIGABOX"
        
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
        
        // 카테고리 버튼에 액션 추가
        mainView.firstButton.addTarget(self, action: #selector(showFirstCategory), for: .touchUpInside)
        mainView.secondButton.addTarget(self, action: #selector(showSecondCategory), for: .touchUpInside)
        mainView.thirdButton.addTarget(self, action: #selector(showThirdCategory), for: .touchUpInside)
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
                self.updatePageLabel() // 페이지 레이블 업데이트
            }
        }
    
        NetworkManager.shared.fetchUpcomingMovies(page: 2) { [weak self] movies in
            guard let self = self, let movies = movies else { return }
            DispatchQueue.main.async {
                self.secondCollectionViewMovies = movies
                self.mainView.secondCollectionView.reloadData()
            }
        }
        
        // 여기에서 third와 fourth 컬렉션의 데이터 소스를 바꿈
        NetworkManager.shared.fetchNowPlayingMovies(page: 4) { [weak self] movies in
            guard let self = self, let movies = movies else { return }
            DispatchQueue.main.async {
                self.thirdCollectionViewMovies = movies
                self.mainView.thirdCollectionView.reloadData()
            }
        }
        
        NetworkManager.shared.fetchMoviesByGenre(genreId: 27, page: 1) { [weak self] movies in
            guard let self = self, let movies = movies else { return }
            DispatchQueue.main.async {
                self.fourthCollectionViewMovies = movies
                self.mainView.fourthCollectionView.reloadData()
            }
        }
    }
    
    func updatePageLabel() {
        let currentPage = Int(round(mainView.firstCollectionView.contentOffset.x / mainView.firstCollectionView.frame.width))
        let totalPage = firstCollectionViewMovies.count
        mainView.pageLabel.text = "\(currentPage + 1) / \(totalPage)"
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
            return selectedCategoryMovies.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier(for: collectionView), for: indexPath)
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        
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
            movie = selectedCategoryMovies[indexPath.item]
        }
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10 // 외곽을 살짝 둥글게 설정
        
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
            return "CategoryCell"
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
            let width = (UIScreen.main.bounds.width - 40) / 3 // 3개의 아이템을 한 줄에 배치하고, 아이템 사이의 간격 10을 고려
            return CGSize(width: width, height: width * 1.5) // 높이는 너비의 1.5배로 설정
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
            movie = selectedCategoryMovies[indexPath.item]
            movieInfoVC.readMovieDetail(movieID: movie.id)
        }
        dismiss(animated: true) { [weak self] in
            self?.navigationController?.pushViewController(movieInfoVC, animated: true)
        }
    }
    
    // 자동 슬라이드 기능
    func startSlideTimer() {
        slideTimer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(slideToNext), userInfo: nil, repeats: true)
    }
    
    @objc func slideToNext() {
        let collectionView = mainView.firstCollectionView
        let visibleItems = collectionView.indexPathsForVisibleItems
        if let currentItem = visibleItems.first {
            let nextItem = IndexPath(item: (currentItem.item + 1) % firstCollectionViewMovies.count, section: currentItem.section)
            collectionView.scrollToItem(at: nextItem, at: .centeredHorizontally, animated: true)
            updatePageLabel() // 페이지 레이블 업데이트
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == mainView.firstCollectionView {
            updatePageLabel()
        }
    }
    
    @objc func showFirstCategory() {
        selectedCategoryMovies = secondCollectionViewMovies
        showCategoryModal(title: "Coming Soon")
    }
    
    @objc func showSecondCategory() {
        selectedCategoryMovies = thirdCollectionViewMovies
        showCategoryModal(title: "Latest Movies")
    }
    
    @objc func showThirdCategory() {
        selectedCategoryMovies = fourthCollectionViewMovies
        showCategoryModal(title: "Genre")
    }
    
    func showCategoryModal(title: String) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .mainBlack
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CategoryCell")
        
        let modalViewController = UIViewController()
        modalViewController.view.backgroundColor = .mainBlack
        modalViewController.title = title
        modalViewController.view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(modalViewController.view.safeAreaLayoutGuide).inset(10)
        }
        
        let navController = UINavigationController(rootViewController: modalViewController)
        present(navController, animated: true, completion: nil)
    }
}
