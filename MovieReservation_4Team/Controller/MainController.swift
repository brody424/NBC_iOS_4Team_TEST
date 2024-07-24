//
//  MainController.swift
//  MovieReservation_4Team
//
//  Created by t2023-m0023 on 7/22/24.
//

import UIKit

class MainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let mainView = MainView()
    
    let firstCollectionViewImages = ["image1", "image2"]
    let secondCollectionViewImages = ["image3", "image4", "image5"]
    let thirdCollectionViewImages = ["image6", "image7", "image8"]
    let fourthCollectionViewImages = ["image9", "image10", "image11"]
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        
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

    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case mainView.firstCollectionView:
            return firstCollectionViewImages.count
        case mainView.secondCollectionView:
            return secondCollectionViewImages.count
        case mainView.thirdCollectionView:
            return thirdCollectionViewImages.count
        case mainView.fourthCollectionView:
            return fourthCollectionViewImages.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier(for: collectionView), for: indexPath)
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        
        let imageName = imageName(for: collectionView, at: indexPath)
        let imageView = UIImageView(image: UIImage(named: imageName))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
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
    
    private func imageName(for collectionView: UICollectionView, at indexPath: IndexPath) -> String {
        switch collectionView {
        case mainView.firstCollectionView:
            return firstCollectionViewImages[indexPath.item]
        case mainView.secondCollectionView:
            return secondCollectionViewImages[indexPath.item]
        case mainView.thirdCollectionView:
            return thirdCollectionViewImages[indexPath.item]
        case mainView.fourthCollectionView:
            return fourthCollectionViewImages[indexPath.item]
        default:
            return ""
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
            return CGSize(width: 150, height: 200) // 네 번째 컬렉션 뷰 아이템 크기 설정
        default:
            return CGSize.zero
        }
    }
}
