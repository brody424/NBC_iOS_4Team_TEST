//
//  ThirdViewController.swift
//  MovieReservation_4Team
//
//  Created by t2023-m0112 on 7/23/24.
//

import UIKit
import SnapKit

class ReservaitionController: UIViewController {
    //사용자가 선택한 영화의 id.
    var userMovieId: Int?
    
    private let reservaitionView: ReservaitionView = {
        let view = ReservaitionView()
        view.backgroundColor = .clear // 배경색 조정
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Reservation"
        setupUI()
        configureView()
    }

    private func setupUI() {
        view.addSubview(reservaitionView)

        reservaitionView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.edges.equalToSuperview()
        }
    }

    private func configureView() {
        if let ticketImage = UIImage(named: "ticket"), // 에셋에 있는 이미지 이름으로 변경
           let movieImage = UIImage(named: "image1") { // 에셋에 있는 이미지 이름으로 변경
            reservaitionView.configure(with: ticketImage, movieImage: movieImage)
        } else {
            print("One or more images not found")
        }
    }
}

#Preview("ReservaitionController") {ReservaitionController()}
