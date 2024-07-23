//
//  CustomNavVC.swift
//  MovieReservation_4Team
//
//  Created by t2023-m0023 on 7/23/24.
//

import UIKit
import SnapKit

class ExampleViewController: UIViewController {

    private let customNavBarView = CustomNavigationBarView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        // CustomNavigationBarView를 서브뷰로 추가
        view.addSubview(customNavBarView)

        // SnapKit으로 CustomNavigationBarView의 위치 및 크기 설정
        customNavBarView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(100)
        }

        // 네비게이션 바의 제목 및 버튼 설정
        customNavBarView.setTitle("Example Title",
                                  leftButtonAction: #selector(backButtonTapped),
                                  rightButtonImage: UIImage(systemName: "gear"),
                                  rightButtonAction: #selector(rightButtonTapped),
                                  target: self)
    }

    @objc private func backButtonTapped() {
        // 커스텀 네비게이션 바에서 설정한 backButtonTapped 호출
        customNavBarView.backButtonTapped()
    }

    @objc private func rightButtonTapped() {
        print("Right button tapped")
    }
}
