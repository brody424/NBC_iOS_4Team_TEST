//
//  BookmarkVC.swift
//  MovieReservation_4Team
//
//  Created by t2023-m0023 on 7/23/24.
//

import UIKit

class BookmarkVC: UIViewController {

    private let bookmarkView = BookmarkView()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupBookmarkView()
    }

    private func setupBookmarkView() {
        view.addSubview(bookmarkView)
        bookmarkView.frame = view.bounds
        bookmarkView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        bookmarkView.configureNavigationBar(withTitle: "관심 목록",
                                            rightButtonAction: #selector(settingsButtonTapped),
                                            target: self)
    }

    @objc private func settingsButtonTapped() {
        print("Settings button tapped")
    }
}

#Preview("BookmarkViewController") { BookmarkVC() }
