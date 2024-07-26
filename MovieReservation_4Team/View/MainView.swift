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
    
    let firstLabel: UILabel = {
        let label = UILabel()
        label.text = "Coming Soon"
        label.textColor = UIColor.mainWhite
        label.textAlignment = .left
        label.font = FontNames.mainFont.font()
        return label
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
    
    let secondLabel: UILabel = {
        let label = UILabel()
        label.text = "Recommend Movies"
        label.textColor = UIColor.mainWhite
        label.textAlignment = .left
        label.font = FontNames.mainFont.font()
        return label
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
    
    let thirdLabel: UILabel = {
        let label = UILabel()
        label.text = "Top Rating"
        label.textColor = UIColor.mainWhite
        label.textAlignment = .left
        label.font = FontNames.mainFont.font()
        return label
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
    
    func setupPageLabel() {
        contentView.addSubview(pageLabel)
        
        pageLabel.snp.makeConstraints {
            $0.bottom.equalTo(firstCollectionView.snp.bottom).offset(-10)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(20)
            $0.width.equalTo(60) // 페이지 레이블 너비 설정
        }
    }
    
    func setupFirstLabel() {
        contentView.addSubview(firstLabel)
        
        firstLabel.snp.makeConstraints {
            $0.top.equalTo(firstCollectionView.snp.bottom).offset(10)
            $0.leading.equalTo(contentView.snp.leading).offset(16) // 컬렉션 뷰와 동일한 leading offset 설정
            $0.height.equalTo(30)
            $0.width.equalTo(150)
        }
    }
    
    func setupSecondCollectionView() {
        contentView.addSubview(secondCollectionView)
        
        secondCollectionView.snp.makeConstraints {
            $0.top.equalTo(firstLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(contentView).inset(16)
            $0.height.equalTo(200)
        }
    }
    
    func setupSecondLabel() {
        contentView.addSubview(secondLabel)
        
        secondLabel.snp.makeConstraints {
            $0.top.equalTo(secondCollectionView.snp.bottom).offset(10)
            $0.leading.equalTo(contentView.snp.leading).offset(16) // 컬렉션 뷰와 동일한 leading offset 설정
            $0.height.equalTo(30)
            $0.width.equalTo(200)
        }
    }
    
    func setupThirdCollectionView() {
        contentView.addSubview(thirdCollectionView)
        
        thirdCollectionView.snp.makeConstraints {
            $0.top.equalTo(secondLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(contentView).inset(16)
            $0.height.equalTo(200)
        }
    }
    
    func setupThirdLabel() {
        contentView.addSubview(thirdLabel)
        
        thirdLabel.snp.makeConstraints {
            $0.top.equalTo(thirdCollectionView.snp.bottom).offset(10)
            $0.leading.equalTo(contentView.snp.leading).offset(16) // 컬렉션 뷰와 동일한 leading offset 설정
            $0.height.equalTo(30)
            $0.width.equalTo(150)
        }
    }
    
    func setupFourthCollectionView() {
        contentView.addSubview(fourthCollectionView)
        
        fourthCollectionView.snp.makeConstraints {
            $0.top.equalTo(thirdLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(contentView).inset(16)
            $0.height.equalTo(200)
            $0.bottom.equalTo(contentView.safeAreaLayoutGuide.snp.bottom).offset(-20)
        }
    }
}
