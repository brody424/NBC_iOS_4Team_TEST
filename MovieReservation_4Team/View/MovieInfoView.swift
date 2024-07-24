//
//  movieInfoView.swift
//  MovieReservation_4Team
//
//  Created by 4Team on 7/22/24.
//

import UIKit
import SnapKit

class MovieInfoView: UIView {
    private var isExpanded = false
    
    //영화 이미지
    var movieImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.backgroundColor = .lightGray
        image.clipsToBounds = true
        return image
    }()
    //영화 제목
    var movieTitleLabel: UILabel = {
        let title = UILabel()
        title.textColor = UIColor.mainWhite
        title.font = FontNames.mainFont.font()
        return title
    }()
    //개봉 날짜
    var openingDateLabel: UILabel = {
        let Date = UILabel()
        Date.textAlignment = .center
        Date.textColor = UIColor.mainWhite
        Date.font = FontNames.subFont.font()
        return Date
    }()
    //상영시간
    var runningTimeLabel: UILabel = {
        let runningTime = UILabel()
        runningTime.textAlignment = .center
        runningTime.textColor = UIColor.mainWhite
        runningTime.font = FontNames.subFont.font()
        return runningTime
    }()
    //영화 장르
    var genreLabel: UILabel = {
        let genre = UILabel()
        genre.textAlignment = .center
        genre.textColor = UIColor.mainWhite
        genre.font = FontNames.subFont.font()
        return genre
    }()
    //개봉날짜/시간/장르 담을 가로 stackView
    var infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    //찜
    var likeImageView: UIImageView = {
        let like = UIImageView()
        return like
    }()
    //영화 평점
    var reviewScoreLabel: UILabel = {
        let reviewScore = UILabel()
        return reviewScore
    }()
    //영화 줄거리
    var descriptionLabel: UILabel = {
        let description = UILabel()
        description.textColor = .mainWhite
        description.font = FontNames.subFont.font()
        description.numberOfLines = 4
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 6
        return description
    }()
    //더보기 기능
    var moreButton: UIButton = {
        let button = UIButton()
        button.setTitle("더보기", for: .normal)
        button.setTitleColor(.mainWhite, for: .normal)
        button.backgroundColor = .mainBlack
        button.titleLabel?.font = FontNames.subFont.font()
        button.addTarget(self, action: #selector(moreButtonTapped), for: .touchDown)
        return button
    }()
    //예매하기 버튼
    var reservationButton: UIButton = {
        let button = UIButton()
        button.setTitle("예매하기", for: .normal)
        button.setTitleColor(.mainWhite, for: .normal)
        button.backgroundColor = .mainRed
        button.layer.cornerRadius = 8
        return button
    }()
    
    
    //MARK: -init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -메서드
    private func configureUI(){
        self.backgroundColor = UIColor.mainBlack
        
        //StackView에 추가
        [openingDateLabel,runningTimeLabel, genreLabel].forEach { infoStackView.addArrangedSubview($0)
        }
        
        //View에 추가
        [movieImageView, movieTitleLabel, infoStackView, descriptionLabel, moreButton, reservationButton].forEach{self.addSubview($0)}
        
        //오토레이아웃
        movieImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(450)
        }
        movieTitleLabel.snp.makeConstraints {
            $0.top.equalTo(movieImageView.snp.bottom).offset(30)
            $0.leading.equalToSuperview().inset(24)
        }
        infoStackView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(24)
            $0.top.equalTo(movieTitleLabel.snp.bottom).offset(10)
            $0.width.equalTo(250)
        }
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(infoStackView.snp.bottom).offset(24)
            $0.trailing.leading.equalToSuperview().inset(24)
            //            $0.height.equalTo(100)
        }
        moreButton.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom)
            $0.trailing.equalTo(descriptionLabel.snp.trailing)
        }
        reservationButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().inset(32)
            //            $0.top.equalTo(descriptionLabel.snp.bottom).offset(24)
            $0.height.equalTo(50)
        }
        
    }
    
    @objc private func moreButtonTapped() {
        isExpanded.toggle()
        descriptionLabel.numberOfLines = isExpanded ? 0 : 4
        moreButton.setTitle(isExpanded ? "닫기" : "더보기", for: .normal)
        // 레이아웃 업데이트
        layoutIfNeeded()
    }
    
}

#Preview {
    let movieInfoView = MovieInfoView()
    return movieInfoView
}



