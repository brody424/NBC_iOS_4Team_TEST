//
//  SearchController.swift
//  MovieReservation_4Team
//
//  Created by t2023-m0117 on 7/24/24.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {
    
    private let searchView = SearchView()
    private let recentSearches = RecentSearches()
    
    override func loadView() {
        self.view = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchView.searchBar.delegate = self
        searchView.recentSearchesTableView.dataSource = self
        searchView.recentSearchesTableView.delegate = self
        searchView.clearAllButton.addTarget(self, action: #selector(clearAllButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - 서치바 딜리게이트
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("검색 텍스트: \(searchText)")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text, !searchText.isEmpty {
            recentSearches.addSearch(searchText)
            searchView.recentSearchesTableView.reloadData()
        }
        searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.becomeFirstResponder()
    }
    
    // MARK: - 테이블뷰 데이터소스
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recentSearches.searches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell
        cell.configure(with: recentSearches.searches[indexPath.row])
        cell.deleteButton.addTarget(self, action: #selector(deleteButtonTapped(_:)), for: .touchUpInside)
        cell.deleteButton.tag = indexPath.row
        return cell
    }
    
    // MARK: - 테이블뷰 딜리게이트
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedSearch = recentSearches.searches[indexPath.row]
        searchView.searchBar.text = selectedSearch
        searchBarSearchButtonClicked(searchView.searchBar) // Trigger a search
        searchView.searchBar.resignFirstResponder()
    }
    
    // MARK: - 전체 삭제
    
    @objc private func clearAllButtonTapped() {
        recentSearches.clearAllSearches()
        searchView.recentSearchesTableView.reloadData()
    }
    
    // MARK: - 개별 삭제
    
    @objc private func deleteButtonTapped(_ sender: UIButton) {
        let index = sender.tag
        recentSearches.removeSearch(at: index)
        searchView.recentSearchesTableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }
}

#Preview {
    let Ac = SearchViewController()
    return Ac
}
