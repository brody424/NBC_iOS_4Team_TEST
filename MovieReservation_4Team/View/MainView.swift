//
//  MainView.swift
//  MovieReservation_4Team
//
//  Created by 4Team on 7/22/24.
//

import UIKit
import SnapKit

class MainView: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    let contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    let firstCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 32, height: 200)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.mainBlack
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "FirstCell")
        return collectionView
    }()
    
    let secondCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 150, height: 200)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.mainBlack
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "SecondCell")
        return collectionView
    }()
    
    let thirdCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 150, height: 200)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.mainBlack
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "ThirdCell")
        return collectionView
    }()
    
    let fourthCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 150, height: 150)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.mainBlack
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "FourthCell")
        return collectionView
    }()
    
    let firstLabelContainer: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.mainWhite.cgColor
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    let secondLabelContainer: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.mainWhite.cgColor
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    let thirdLabelContainer: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.mainWhite.cgColor
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    let firstLabel: UILabel = {
        let label = UILabel()
        label.text = "개봉 예정"
        label.textColor = UIColor.mainWhite
        label.textAlignment = .center
        return label
    }()
    
    let secondLabel: UILabel = {
        let label = UILabel()
        label.text = "추천 영화"
        label.textColor = UIColor.mainWhite
        label.textAlignment = .center
        return label
    }()
    
    let thirdLabel: UILabel = {
        let label = UILabel()
        label.text = "인기 영화"
        label.textColor = UIColor.mainWhite
        label.textAlignment = .center
        return label
    }()
    
    let firstCollectionViewImages = ["image1", "image2"]
    let secondCollectionViewImages = ["image3", "image4", "image5"]
    let thirdCollectionViewImages = ["image6", "image7", "image8"]
    let fourthCollectionViewImages = ["image9", "image10", "image11"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        setupView()
    }
    
    func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
    }
    
    func setupView() {
        setupBackgroundColor()
        setupNavigationBar()
        setupFirstCollectionView()
        setupFirstLabel()
        setupSecondCollectionView()
        setupSecondLabel()
        setupThirdCollectionView()
        setupThirdLabel()
        setupFourthCollectionView()
    }
    
    func setupBackgroundColor() {
        self.view.backgroundColor = UIColor.mainBlack
        contentView.backgroundColor = UIColor.mainBlack
    }
    
    func setupNavigationBar() {
        let navigationBar = UINavigationBar()
        contentView.addSubview(navigationBar)
        
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(44)
        }
        
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        navigationBar.backgroundColor = .mainBlack
        
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 20),
            .foregroundColor: UIColor.mainWhite
        ]
        navigationBar.titleTextAttributes = titleAttributes
        
        let navigationItem = UINavigationItem(title: "Movie")
        
        if let profileImage = UIImage(named: "profile_image") {
            let profileButton = UIBarButtonItem(image: profileImage, style: .plain, target: self, action: #selector(profileButtonTapped))
            navigationItem.rightBarButtonItem = profileButton
        } else {
            print("프로필 이미지를 찾을 수 없습니다.")
        }
        
        navigationBar.setItems([navigationItem], animated: false)
    }
    
    func setupFirstCollectionView() {
        contentView.addSubview(firstCollectionView)
        firstCollectionView.dataSource = self
        firstCollectionView.delegate = self
        
        firstCollectionView.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top).offset(44)
            $0.leading.trailing.equalTo(contentView).inset(16)
            $0.height.equalTo(200)
        }
    }
    
    func setupFirstLabel() {
        contentView.addSubview(firstLabelContainer)
        firstLabelContainer.addSubview(firstLabel)
        
        firstLabelContainer.snp.makeConstraints {
            $0.top.equalTo(firstCollectionView.snp.bottom).offset(20)
            $0.leading.equalTo(contentView.safeAreaLayoutGuide.snp.leading).offset(16)
            $0.height.equalTo(50)
            $0.width.equalTo(100)
        }
        
        firstLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(8)
        }
    }
    
    func setupSecondCollectionView() {
        contentView.addSubview(secondCollectionView)
        secondCollectionView.dataSource = self
        secondCollectionView.delegate = self
        
        secondCollectionView.snp.makeConstraints {
            $0.top.equalTo(firstLabelContainer.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(contentView).inset(16)
            $0.height.equalTo(150)
        }
    }
    
    func setupSecondLabel() {
        contentView.addSubview(secondLabelContainer)
        secondLabelContainer.addSubview(secondLabel)
        
        secondLabelContainer.snp.makeConstraints {
            $0.top.equalTo(secondCollectionView.snp.bottom).offset(20)
            $0.leading.equalTo(contentView.safeAreaLayoutGuide.snp.leading).offset(16)
            $0.height.equalTo(50)
            $0.width.equalTo(100)
        }
        
        secondLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(8)
        }
    }
    
    func setupThirdCollectionView() {
        contentView.addSubview(thirdCollectionView)
        thirdCollectionView.dataSource = self
        thirdCollectionView.delegate = self
        
        thirdCollectionView.snp.makeConstraints {
            $0.top.equalTo(secondLabelContainer.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(contentView).inset(16)
            $0.height.equalTo(150)
        }
    }
    
    func setupThirdLabel() {
        contentView.addSubview(thirdLabelContainer)
        thirdLabelContainer.addSubview(thirdLabel)
        
        thirdLabelContainer.snp.makeConstraints {
            $0.top.equalTo(thirdCollectionView.snp.bottom).offset(20)
            $0.leading.equalTo(contentView.safeAreaLayoutGuide.snp.leading).offset(16)
            $0.height.equalTo(50)
            $0.width.equalTo(100)
        }
        
        thirdLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(8)
        }
    }
    
    func setupFourthCollectionView() {
        contentView.addSubview(fourthCollectionView)
        fourthCollectionView.dataSource = self
        fourthCollectionView.delegate = self
        
        fourthCollectionView.snp.makeConstraints {
            $0.top.equalTo(thirdLabelContainer.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(contentView).inset(16)
            $0.height.equalTo(150)
            $0.bottom.equalTo(contentView.safeAreaLayoutGuide.snp.bottom).offset(-20)
        }
    }
    
    @objc func profileButtonTapped() {
        print("Profile button tapped")
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case firstCollectionView:
            return firstCollectionViewImages.count
        case secondCollectionView:
            return secondCollectionViewImages.count
        case thirdCollectionView:
            return thirdCollectionViewImages.count
        case fourthCollectionView:
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
        case firstCollectionView:
            return "FirstCell"
        case secondCollectionView:
            return "SecondCell"
        case thirdCollectionView:
            return "ThirdCell"
        case fourthCollectionView:
            return "FourthCell"
        default:
            return "Cell"
        }
    }
    
    private func imageName(for collectionView: UICollectionView, at indexPath: IndexPath) -> String {
        switch collectionView {
        case firstCollectionView:
            return firstCollectionViewImages[indexPath.item]
        case secondCollectionView:
            return secondCollectionViewImages[indexPath.item]
        case thirdCollectionView:
            return thirdCollectionViewImages[indexPath.item]
        case fourthCollectionView:
            return fourthCollectionViewImages[indexPath.item]
        default:
            return ""
        }
    }
}
#Preview("MainView") { MainView() }
