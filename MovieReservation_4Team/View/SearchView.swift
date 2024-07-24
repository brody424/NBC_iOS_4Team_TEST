import UIKit
import SnapKit
import Kingfisher

class SearchView: UIView {
    
    let searchLabel: UILabel = {
        let label = UILabel()
        label.text = "검 색"
        label.textColor = UIColor.mainWhite
        label.font = FontNames.mainFont.font()
        return label
    }()
    
    let searchBar: UISearchBar = {
        let search = UISearchBar()
        search.placeholder = "영화 검색"
        search.barStyle = .default
        search.searchBarStyle = .minimal
        
        if let searchTextField = search.value(forKey: "searchField") as? UITextField {
            searchTextField.textColor = UIColor.mainWhite
            searchTextField.backgroundColor = .clear
            searchTextField.borderStyle = .none
            searchTextField.layer.borderColor = UIColor.mainWhite.cgColor
            searchTextField.layer.borderWidth = 2
            searchTextField.layer.cornerRadius = 10
            searchTextField.layer.masksToBounds = true
            searchTextField.attributedPlaceholder = NSAttributedString(
                string: search.placeholder ?? "",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.mainWhite.withAlphaComponent(1)]
            )
        }
        
        if let magnifyingGlass = search.searchTextField.leftView as? UIImageView {
            magnifyingGlass.image = magnifyingGlass.image?.withRenderingMode(.alwaysTemplate)
            magnifyingGlass.tintColor = UIColor.mainWhite
        }
        return search
    }()
    
    let recentSearchesLabel: UILabel = {
        let label = UILabel()
        label.text = "최근 검색"
        label.textColor = UIColor.mainWhite
        label.font = FontNames.mainFont.font()
        return label
    }()
    
    let clearAllButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("전체 삭제", for: .normal)
        button.setTitleColor(UIColor.gray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return button
    }()
    
    // Collection View for search results
    let searchResultsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        // Configure item size to fit two items horizontally
        let itemWidth = (UIScreen.main.bounds.width - 24) / 2  // Adjust 24 for horizontal padding
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth * 1.5)  // Maintain aspect ratio
        
        // Set spacing between items and lines
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.mainBlack
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "MovieCollectionViewCell")
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.backgroundColor = UIColor.mainBlack
        
        [searchLabel, searchBar, recentSearchesLabel, clearAllButton, searchResultsCollectionView].forEach { self.addSubview($0) }
        
        searchLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(60)
            $0.centerX.equalToSuperview()
        }
        
        searchBar.snp.makeConstraints {
            $0.top.equalTo(searchLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(8)
            $0.trailing.equalToSuperview().offset(-8)
        }
        
        recentSearchesLabel.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(8)
        }
        
        clearAllButton.snp.makeConstraints {
            $0.centerY.equalTo(recentSearchesLabel)
            $0.trailing.equalToSuperview().offset(-8)
        }
        
        searchResultsCollectionView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(8)
            $0.trailing.equalToSuperview().offset(-8)
            $0.top.equalTo(searchBar.snp.bottom).offset(10)
            $0.bottom.equalToSuperview().offset(-10)
        }
    }
}

class MovieCollectionViewCell: UICollectionViewCell {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.numberOfLines = 2
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        
        imageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(imageView.snp.width).multipliedBy(1.5) // Adjust the aspect ratio as needed
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview().inset(5)
            $0.bottom.equalToSuperview().inset(5)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with movie: Movie) {
        titleLabel.text = movie.title
        if let imagePath = movie.posterPath {
            let url = URL(string: "https://image.tmdb.org/t/p/w500\(imagePath)")!
            imageView.kf.setImage(with: url)
        }
    }
}
