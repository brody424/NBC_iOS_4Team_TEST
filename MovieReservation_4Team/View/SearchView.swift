import UIKit
import SnapKit

class SearchView: UIView, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {
    
    private let searchLabel: UILabel = {
        let label = UILabel()
        label.text = "검 색"
        label.textColor = UIColor.mainWhite
        label.font = FontNames.mainFont.font()
        return label
    }()
    
    private let searchBar: UISearchBar = {
        let search = UISearchBar()
        search.placeholder = "영화 검색"
        search.barStyle = .default
        search.searchBarStyle = .minimal
        
        // Customize the search bar
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
    
    private let recentSearchesLabel: UILabel = {
        let label = UILabel()
        label.text = "최근 검색"
        label.textColor = UIColor.mainWhite
        label.font = FontNames.mainFont.font()
        return label
    }()
    
    private lazy var clearAllButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("전체 삭제", for: .normal)
        button.setTitleColor(UIColor.gray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.addTarget(self, action: #selector(clearAllButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let recentSearchesTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: "SearchTableViewCell")
        tableView.backgroundColor = UIColor.mainBlack
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private var recentSearches: [String] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.backgroundColor = UIColor.mainBlack
        
        searchBar.delegate = self
        recentSearchesTableView.dataSource = self
        recentSearchesTableView.delegate = self
        
        [searchLabel, searchBar, recentSearchesLabel, clearAllButton, recentSearchesTableView].forEach { self.addSubview($0) }
        
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
        
        recentSearchesTableView.snp.makeConstraints {
            $0.top.equalTo(recentSearchesLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(8)
            $0.trailing.equalToSuperview().offset(-8)
            $0.bottom.equalToSuperview().offset(-8)
        }
    }
    
    // MARK: - 서치바딜리게이트
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("검색 텍스트: \(searchText)")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text, !searchText.isEmpty {
            if !recentSearches.contains(searchText) {
                recentSearches.insert(searchText, at: 0)
                recentSearchesTableView.reloadData()
            }
        }
        searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.becomeFirstResponder()
    }
    
    // MARK: - 테이블뷰 데이터소스
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recentSearches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell
        cell.configure(with: recentSearches[indexPath.row])
        cell.deleteButton.addTarget(self, action: #selector(deleteButtonTapped(_:)), for: .touchUpInside)
        cell.deleteButton.tag = indexPath.row
        return cell
    }
    
    // MARK: - 테이블뷰 딜리게이트
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedSearch = recentSearches[indexPath.row]
        searchBar.text = selectedSearch
        searchBarSearchButtonClicked(searchBar) // Trigger a search
        searchBar.resignFirstResponder()
    }
    
    // MARK: - 전체 삭제
    
    @objc private func clearAllButtonTapped() {
        recentSearches.removeAll()
        recentSearchesTableView.reloadData()
    }
    
    // MARK: - 개별 삭제
    
    @objc private func deleteButtonTapped(_ sender: UIButton) {
        let index = sender.tag
        if index >= 0 && index < recentSearches.count {
            recentSearches.remove(at: index)
            recentSearchesTableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        }
    }
}

class SearchTableViewCell: UITableViewCell {
    
    let deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("X", for: .normal)
        button.setTitleColor(UIColor.gray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.mainWhite
        label.font = FontNames.subFont.font()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLabel)
        contentView.addSubview(deleteButton)
        
        deleteButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-8)
            $0.width.height.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(8)
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(deleteButton.snp.leading).offset(-8)
        }
        
        contentView.backgroundColor = UIColor.mainBlack
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with text: String) {
        titleLabel.text = text
    }
}
#Preview {
  let lc = SearchView()
  return lc
}
