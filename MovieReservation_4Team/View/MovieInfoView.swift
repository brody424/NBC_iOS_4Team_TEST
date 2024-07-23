//
//  movieInfoView.swift
//  MovieReservation_4Team
//
//  Created by 4Team on 7/22/24.
//

import UIKit
import SnapKit

class MovieInfoView: UIView {
    //영화 이미지
    var movieImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .lightGray
        image.clipsToBounds = true
        return image
    }()
    //영화 제목
    var movieTitleLabel: UILabel = {
        let title = UILabel()
        title.text = "Me Before You"
        title.textColor = UIColor.mainWhite
        title.font = FontNames.mainFont.font()
        return title
    }()
    //개봉 날짜
    var openingDateLabel: UILabel = {
        let Date = UILabel()
        Date.text = "2016.06.01."
        Date.textAlignment = .center
        Date.textColor = UIColor.mainWhite
        Date.font = FontNames.subFont.font()
        return Date
    }()
    //상영시간
    var runningTimeLabel: UILabel = {
        let runningTime = UILabel()
        runningTime.text = "110분"
        runningTime.textAlignment = .center
        runningTime.textColor = UIColor.mainWhite
        runningTime.font = FontNames.subFont.font()
        return runningTime
    }()
    //영화 장르
    var genreLabel: UILabel = {
        let genre = UILabel()
        genre.text = "멜로/로맨스"
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
        description.numberOfLines = 5
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 6
        // 한글 줄바꿈 적용
        if #available(iOS 14.0, *) {
            paragraphStyle.lineBreakStrategy = .hangulWordPriority
        }
        
        description.text = "이별을 준비하는 마지막에 나타난 짜증나는 여자 내 평생 최고의 6개월을 선물했다 6년 동안이나 일하던 카페가 문을 닫는 바람에 백수가 된 루이자(에밀리아 클라크)는 새 직장을 찾던 중 촉망 받던 젊은 사업가였던 전신마비 환자 윌(샘 클라플린)의 6개월 임시 간병인이 된다. 루이자의 우스꽝스러운 옷, 썰렁한 농담들, 속마음을 그대로 드러내는 얼굴 표정이 신경 쓰이는 윌. 말만 하면 멍청이 보듯 두 살짜리처럼 취급하고 개망나니처럼 구는 윌이 치사하기만 한 루이자. 그렇게 둘은 서로의 인생을 향해 차츰 걸어 들어가는데..."
        return description
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
        
        [openingDateLabel,runningTimeLabel, genreLabel].forEach { infoStackView.addArrangedSubview($0)
        }
        
        [movieImageView, movieTitleLabel, infoStackView, descriptionLabel, reservationButton].forEach{self.addSubview($0)}
        
        //오토레이아웃
        movieImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(380)
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
            $0.height.equalTo(100)
        }
        reservationButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().inset(32)
//            $0.top.equalTo(descriptionLabel.snp.bottom).offset(24)
            $0.height.equalTo(50)
        }

    }
    
}

#Preview {
    let movieInfoView = MovieInfoView()
    return movieInfoView
}



