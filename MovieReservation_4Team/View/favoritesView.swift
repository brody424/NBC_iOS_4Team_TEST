//
//  BookmarkView.swift
//  MovieReservation_4Team
//
//  Created by 4Team on 7/22/24.
//
import UIKit
import SnapKit

// MARK: - FavoritesView
class FavoritesView: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    // MARK: - CollectionViewData 구조체
    // UICollectionView의 데이터 모델을 정의합니다.
    struct CollectionViewData {
        let title: String
        let imageName: String


        static let data: [CollectionViewData] = [
            CollectionViewData(title: "movie", imageName: "image1"),
            CollectionViewData(title: "movie2", imageName: "image2"),
            CollectionViewData(title: "movie3", imageName: "image3"),
            CollectionViewData(title: "movie4", imageName: "image4"),
            CollectionViewData(title: "movie5", imageName: "image5"),
            CollectionViewData(title: "movie6", imageName: "image6"),
            CollectionViewData(title: "movie7", imageName: "image7"),
            CollectionViewData(title: "movie8", imageName: "image8"),
            CollectionViewData(title: "movie9", imageName: "image9")
        ]
    }
    
    let userButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "person.circle.fill"), for: .normal)
        return button
    }()

    // MARK: - UICollectionView 설정
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 4
        layout.sectionInset = UIEdgeInsets(top: 10, left: 8, bottom: 10, right: 8)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.mainBlack
        collectionView.register(FavoritesViewCell.self, forCellWithReuseIdentifier: "CustomCell")
        return collectionView
    }()

    // MARK: - 초기화
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCollectionView()
    }

    private func setupCollectionView() {

        addSubview(collectionView)

        collectionView.dataSource = self
        collectionView.delegate = self

        // SnapKit을 사용하여 CollectionView의 제약 조건 설정
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    // MARK: - UICollectionViewDataSource

    // 섹션의 항목 수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CollectionViewData.data.count
    }

    // 셀 구성
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as! FavoritesViewCell
        let data = CollectionViewData.data[indexPath.item]
        cell.configure(with: data) // 셀을 데이터로 구성
        return cell
    }

    // MARK: - UICollectionViewDelegateFlowLayout

    // 셀의 크기를 반환합니다.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 30) / 3 // 3열 레이아웃을 위해 셀의 너비 계산
        return CGSize(width: width, height: width * 1.8) // 셀의 높이는 너비의 1.5배
    }
}

// MARK: - FavoritesViewCell
class FavoritesViewCell: UICollectionViewCell {

    private var isFavorite: Bool = false // 하트 버튼의 상태를 추적하는 변수

    // MARK: - UI 요소 정의
    let containerView: UIView = {
        let view = UIView()
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.layer.shadowOpacity = 0.4
        view.layer.shadowRadius = 8
        return view
    }()

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 4
        imageView.clipsToBounds = true
        return imageView
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = FontNames.subFont2.font()
        label.textColor = UIColor.mainWhite
        return label
    }()

    let favoriteButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "heartimage"), for: .normal) // 빈 하트 이미지
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupActions()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        setupActions()
    }

    private func setupUI() {
        contentView.addSubview(containerView)
        containerView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(favoriteButton)

        containerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(40)
        }

        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(containerView.snp.bottom).offset(4)
            $0.centerX.equalTo(containerView.snp.centerX)
        }

        favoriteButton.snp.makeConstraints {
            $0.bottom.equalTo(imageView.snp.bottom).inset(4)
            $0.trailing.equalTo(imageView.snp.trailing).inset(4)
            $0.width.height.equalTo(30)
        }
    }

    private func setupActions() {
        favoriteButton.addTarget(self, action: #selector(toggleFavorite), for: .touchUpInside)
    }

    @objc private func toggleFavorite() {
        isFavorite.toggle() // 버튼 클릭 시 상태 반전

        let heartImageName = isFavorite ? "heartfilled" : "heartimage" // 채워진 하트 이미지와 빈 하트 이미지
        favoriteButton.setImage(UIImage(named: heartImageName), for: .normal)

        //하트이미지 클릭시 영화정보 사라지게하는 버튼 구현
    }

    func configure(with data: FavoritesView.CollectionViewData) {
        imageView.image = UIImage(named: data.imageName)
        titleLabel.text = data.title
    }
}

#Preview {
    let favoritesView = FavoritesView()
    return favoritesView
}
