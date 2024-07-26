import UIKit
import SnapKit

class SearchView: UIView {

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

    let searchResultsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        // 아이템 사이즈
        let itemWidth = (UIScreen.main.bounds.width - 24) / 2
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth * 1.5)

        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.mainBlack
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "MovieCollectionViewCell")
        return collectionView
    }()

    weak var cellDelegate: MovieCollectionViewCellDelegate? // Delegate for MovieCollectionViewCell

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        self.backgroundColor = UIColor.mainBlack

        [searchBar, recentSearchesLabel, clearAllButton, searchResultsCollectionView].forEach { self.addSubview($0) }

        searchBar.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
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
            $0.bottom.equalToSuperview().offset(-85)
        }

        // 설정된 delegate와 dataSource
        searchResultsCollectionView.dataSource = self
        searchResultsCollectionView.delegate = self
    }
}

// MARK: - UICollectionViewDataSource Methods
extension SearchView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10 // 여기에 실제 데이터 카운트를 반환해야 합니다.
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
        cell.delegate = cellDelegate // Set the delegate for cell
        // Configure cell here
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout Methods
extension SearchView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 24) / 2
        let height = width * 1.5
        return CGSize(width: width, height: height)
    }
}
