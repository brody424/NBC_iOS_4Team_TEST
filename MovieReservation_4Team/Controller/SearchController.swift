import UIKit

class SearchViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate {
    
    private let searchView = SearchView()
    private var searchResults: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(searchView)
        searchView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        searchView.searchResultsCollectionView.dataSource = self
        searchView.searchResultsCollectionView.delegate = self
        searchView.searchBar.delegate = self

    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            searchResults = [] 
        } else {
            fetchMovies(with: searchText)
        }
        searchView.searchResultsCollectionView.reloadData()
    }
    
    func fetchMovies(with query: String) {
        // 영화 가져오기 구현 예시
        NetworkManager.shared.fetchPopularMovies(page: 1) { [weak self] movies in
            guard let self = self else { return }
            self.searchResults = movies?.filter { $0.title.lowercased().contains(query.lowercased()) } ?? []
            DispatchQueue.main.async {
                self.searchView.searchResultsCollectionView.reloadData()
            }
        }
    }
    
    // MARK: - 컬렉션뷰 데이터 소스
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
        let movie = searchResults[indexPath.item]
        cell.configure(with: movie)
        return cell
    }
    
    // MARK: - 딜리게이트레이아웃
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 16) / 2
        let height = width * 1.5
        return CGSize(width: width, height: height)
    }
}
