//
//  MainController.swift
//  MovieReservation_4Team
//
//  Created by t2023-m0023 on 7/22/24.
//

import UIKit

class MainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let mainView = MainView()
    
    var firstCollectionViewMovies: [Movie] = []
    var secondCollectionViewMovies: [Movie] = []
    var thirdCollectionViewMovies: [Movie] = []
    var fourthCollectionViewMovies: [Movie] = []
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        fetchData()
        
        self.title = "MOVIE"
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
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        if let posterPath = movie.posterPath {
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
            return CGSize(width: UIScreen.main.bounds.width - 32, height: 200)
        case mainView.secondCollectionView, mainView.thirdCollectionView:
            return CGSize(width: 150, height: 200)
        case mainView.fourthCollectionView:
            return CGSize(width: 150, height: 200)
        default:
            return CGSize.zero
        }
    }
}
