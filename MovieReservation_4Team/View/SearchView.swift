//
//  SearchView.swift
//  MovieReservation_4Team
//
//  Created by 4Team on 7/22/24.
//

import UIKit
import SnapKit

class SearchView: UIView, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
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
        
        // 서치바 색깔 변경
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
        
        // 아이콘 색깔 변경
        if let magnifyingGlass = search.searchTextField.leftView as? UIImageView {
            magnifyingGlass.image = magnifyingGlass.image?.withRenderingMode(.alwaysTemplate)
            magnifyingGlass.tintColor = UIColor.mainWhite
        }
        return search
    }()
    
    private let tableView = UITableView()
    
    // 샘플 데이터
    private let movies = ["스마일", "어벤져스", "해리포터", "라라랜드", "나홀로 집에"]
    private let movieImages = ["image11", "image2", "image3", "image4", "image5"]
    private var filteredMovies = [String]()
    private var filteredImages = [String]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        self.backgroundColor = UIColor.mainBlack
        
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "MovieCell")
        tableView.backgroundColor = UIColor.mainBlack
        tableView.separatorColor = .white
        
        [
            searchLabel,
            searchBar,
            tableView
        ].forEach { self.addSubview($0) }
        
        searchLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(60)
            $0.centerX.equalToSuperview()
        }
        
        searchBar.snp.makeConstraints {
            $0.top.equalTo(searchLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(8)
            $0.trailing.equalToSuperview().offset(-8)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(10)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        // Initialize with all movies and images
        filteredMovies = movies
        filteredImages = movieImages
    }
    
    // MARK: - 데이터 소스 매서드
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieTableViewCell
        cell.configure(with: filteredMovies[indexPath.row], imageName: filteredImages[indexPath.row])
        return cell
    }
    
    // MARK: - 서치바 딜리게이트 메서드
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredMovies = movies
            filteredImages = movieImages
        } else {
            filteredMovies = []
            filteredImages = []
            for (index, movie) in movies.enumerated() {
                if movie.lowercased().contains(searchText.lowercased()) {
                    filteredMovies.append(movie)
                    filteredImages.append(movieImages[index])
                }
            }
        }
        tableView.reloadData()
    }
    
    // 키보드 사라짐
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    // 키보드 보임
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.becomeFirstResponder()
    }
}

class MovieTableViewCell: UITableViewCell {
    
    private let movieImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.contentMode = .scaleToFill
        imageview.layer.cornerRadius = 10
        imageview.clipsToBounds = true
        return imageview
    }()
    private let movieTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.mainWhite
        label.font = FontNames.mainFont.font()
        label.numberOfLines = 1
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        [
            movieImageView,
            movieTitleLabel
        ].forEach{ self.addSubview($0) }
        movieImageView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview().inset(8)
            $0.width.equalTo(200) //이미지 넓이
            $0.height.equalTo(200) // 이미지 높이
        }
        
        movieTitleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(movieImageView.snp.trailing).offset(12)
            $0.trailing.equalToSuperview().offset(-8)
        }
    }
    
    func configure(with title: String, imageName: String) {
        movieTitleLabel.text = title
        movieImageView.image = UIImage(named: imageName)
        self.backgroundColor = UIColor.mainBlack
    }
}

#Preview {
    let lc = SearchView()
    return lc
}
