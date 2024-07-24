import UIKit

class MovieInfoViewController: UIViewController {
    
    var movie: Movie?
    let posterImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        if let movie = movie, let posterPath = movie.posterPath {
            let imageUrl = "https://image.tmdb.org/t/p/w500\(posterPath)"
            NetworkManager.shared.loadImage(from: imageUrl, into: posterImageView)
        }
    }
    
    func setupView() {
        view.backgroundColor = .white
        view.addSubview(posterImageView)
        
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.clipsToBounds = true
        
        posterImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(200)
        }
    }
}
