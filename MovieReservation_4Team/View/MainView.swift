//
//  MainView.swift
//  MovieReservation_4Team
//
//  Created by 4Team on 7/22/24.
//

import UIKit
import SnapKit

class MainView: UIView {
    
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
        layout.itemSize = CGSize(width: 150, height: 200)
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
        label.text = "최신 영화"
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupScrollView()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupScrollView()
        setupView()
    }

    func setupScrollView() {
        addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide)
        }
        
        scrollView.addSubview(contentView)

        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
    }
    
    func setupView() {
        setupBackgroundColor()
        setupFirstCollectionView()
        setupFirstLabel()
        setupSecondCollectionView()
        setupSecondLabel()
        setupThirdCollectionView()
        setupThirdLabel()
        setupFourthCollectionView()
    }
    
    func setupBackgroundColor() {
        backgroundColor = UIColor.mainBlack
        contentView.backgroundColor = UIColor.mainBlack
    }

    
    func setupFirstCollectionView() {
        contentView.addSubview(firstCollectionView)
        
        firstCollectionView.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top).offset(0)
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
            $0.height.equalTo(40)
            $0.width.equalTo(90)
        }
        
        firstLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(8)
        }
    }
    
    func setupSecondCollectionView() {
        contentView.addSubview(secondCollectionView)
        
        secondCollectionView.snp.makeConstraints {
            $0.top.equalTo(firstLabelContainer.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(contentView).inset(16)
            $0.height.equalTo(200)
        }
    }
    
    func setupSecondLabel() {
        contentView.addSubview(secondLabelContainer)
        secondLabelContainer.addSubview(secondLabel)
        
        secondLabelContainer.snp.makeConstraints {
            $0.top.equalTo(secondCollectionView.snp.bottom).offset(10)
            $0.leading.equalTo(contentView.safeAreaLayoutGuide.snp.leading).offset(16)
            $0.height.equalTo(40)
            $0.width.equalTo(90)
        }
        
        secondLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(8)
        }
    }
    
    func setupThirdCollectionView() {
        contentView.addSubview(thirdCollectionView)
        
        thirdCollectionView.snp.makeConstraints {
            $0.top.equalTo(secondLabelContainer.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(contentView).inset(16)
            $0.height.equalTo(200)
        }
    }
    
    func setupThirdLabel() {
        contentView.addSubview(thirdLabelContainer)
        thirdLabelContainer.addSubview(thirdLabel)
        
        thirdLabelContainer.snp.makeConstraints {
            $0.top.equalTo(thirdCollectionView.snp.bottom).offset(20)
            $0.leading.equalTo(contentView.safeAreaLayoutGuide.snp.leading).offset(16)
            $0.height.equalTo(40)
            $0.width.equalTo(90)
        }
        
        thirdLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(8)
        }
    }
    
    func setupFourthCollectionView() {
        contentView.addSubview(fourthCollectionView)
        
        fourthCollectionView.snp.makeConstraints {
            $0.top.equalTo(thirdLabelContainer.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(contentView).inset(16)
            $0.height.equalTo(200)
            $0.bottom.equalTo(contentView.safeAreaLayoutGuide.snp.bottom).offset(-20)
        }
    }
}
