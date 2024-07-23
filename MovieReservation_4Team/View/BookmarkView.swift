//
//  BookmarkView.swift
//  MovieReservation_4Team
//
//  Created by 4Team on 7/22/24.
//

import UIKit
import SnapKit

class BookmarkView: UIView {

    private let customNavBarView = CustomNavigationBarView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        backgroundColor = UIColor.mainBlack

        addSubview(customNavBarView)

        customNavBarView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(70)
        }
    }

    func configureNavigationBar(withTitle title: String, rightButtonAction: Selector?, target: Any?) {
        let rightButtonImage = UIImage(named: "settings_icon") // 커스텀 이미지 파일 이름
        customNavBarView.setTitle(title,
                                  leftButtonAction: nil,
                                  rightButtonImage: rightButtonImage,
                                  rightButtonAction: rightButtonAction,
                                  target: target)
    }

    @objc private func backButtonTapped() {
        // 뒤로가기 버튼 액션
        (UIApplication.shared.connectedScenes.first?.delegate as? UIWindowSceneDelegate)?.window??.rootViewController?.navigationController?.popViewController(animated: true)
    }
}
