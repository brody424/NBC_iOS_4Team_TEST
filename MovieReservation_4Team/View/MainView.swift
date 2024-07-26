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
    
    let pageLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.lightGray
        label.textAlignment = .center
        label.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        return label
    }()
    
    let firstButton: UIButton = {
        let button = UIButton()
        button.setTitle("Coming Soon", for: .normal)
        button.setTitleColor(UIColor.mainWhite, for: .normal)
        button.titleLabel?.font = FontNames.mainFont.font()
        button.contentHorizontalAlignment = .left
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 40)
        button.semanticContentAttribute = .forceLeftToRight
        return button
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
    
    let secondButton: UIButton = {
        let button = UIButton()
        button.setTitle("Latest Movies", for: .normal)
        button.setTitleColor(UIColor.mainWhite, for: .normal)
        button.titleLabel?.font = FontNames.mainFont.font()
        button.contentHorizontalAlignment = .left
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 40)
        button.semanticContentAttribute = .forceLeftToRight
        return button
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
    
    let thirdButton: UIButton = {
        let button = UIButton()
        button.setTitle("Genre", for: .normal)
        button.setTitleColor(UIColor.mainWhite, for: .normal)
        button.titleLabel?.font = FontNames.mainFont.font()
        button.contentHorizontalAlignment = .left
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 40)
        button.semanticContentAttribute = .forceLeftToRight
        return button
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
        setupPageLabel()
        setupFirstButton()
        setupSecondCollectionView()
        setupSecondButton()
        setupThirdCollectionView()
        setupThirdButton()
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
    
    func setupPageLabel() {
        contentView.addSubview(pageLabel)
        
        pageLabel.snp.makeConstraints {
            $0.bottom.equalTo(firstCollectionView.snp.bottom).offset(0)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(20)
            $0.width.equalTo(60) // 페이지 레이블 너비 설정
        }
    }
    
    func setupFirstButton() {
        contentView.addSubview(firstButton)
        
        firstButton.snp.makeConstraints {
            $0.top.equalTo(firstCollectionView.snp.bottom).offset(30)
            $0.leading.trailing.equalTo(contentView).inset(16)
            $0.height.equalTo(30)
        }
        
        let arrowImageView = UIImageView(image: UIImage(systemName: "chevron.right"))
        arrowImageView.tintColor = UIColor.mainWhite
        firstButton.addSubview(arrowImageView)
        
        arrowImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-16)
            $0.width.height.equalTo(20)
        }
    }
    
    func setupSecondCollectionView() {
        contentView.addSubview(secondCollectionView)
        
        secondCollectionView.snp.makeConstraints {
            $0.top.equalTo(firstButton.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(contentView).inset(16)
            $0.height.equalTo(200)
        }
    }
    
    func setupSecondButton() {
        contentView.addSubview(secondButton)
        
        secondButton.snp.makeConstraints {
            $0.top.equalTo(secondCollectionView.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(contentView).inset(16)
            $0.height.equalTo(30)
        }
        
        let arrowImageView = UIImageView(image: UIImage(systemName: "chevron.right"))
        arrowImageView.tintColor = UIColor.mainWhite
        secondButton.addSubview(arrowImageView)
        
        arrowImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-16)
            $0.width.height.equalTo(20)
        }
    }
    
    func setupThirdCollectionView() {
        contentView.addSubview(thirdCollectionView)
        
        thirdCollectionView.snp.makeConstraints {
            $0.top.equalTo(secondButton.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(contentView).inset(16)
            $0.height.equalTo(200)
        }
    }
    
    func setupThirdButton() {
        contentView.addSubview(thirdButton)
        
        thirdButton.snp.makeConstraints {
            $0.top.equalTo(thirdCollectionView.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(contentView).inset(16)
            $0.height.equalTo(30)
        }
        
        let arrowImageView = UIImageView(image: UIImage(systemName: "chevron.right"))
        arrowImageView.tintColor = UIColor.mainWhite
        thirdButton.addSubview(arrowImageView)
        
        arrowImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-16)
            $0.width.height.equalTo(20)
        }
    }
    
    func setupFourthCollectionView() {
        contentView.addSubview(fourthCollectionView)
        
        fourthCollectionView.snp.makeConstraints {
            $0.top.equalTo(thirdButton.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(contentView).inset(16)
            $0.height.equalTo(200)
            $0.bottom.equalTo(contentView.safeAreaLayoutGuide.snp.bottom).offset(-20)
        }
    }
}
