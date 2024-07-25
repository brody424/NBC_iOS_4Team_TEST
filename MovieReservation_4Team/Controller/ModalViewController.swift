//
//  ModalViewController.swift
//  MovieReservation_4Team
//
//  Created by ahnzihyeon on 7/25/24.
//

import UIKit
import SnapKit

class ModalViewController: UIViewController {
    
    //예매하기 버튼
    var reservationButton: UIButton = {
        let button = UIButton()
        button.setTitle("예매하기", for: .normal)
        button.setTitleColor(.mainWhite, for: .normal)
        button.backgroundColor = .mainRed
        button.layer.cornerRadius = 8
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.2000000477, green: 0.2000000477, blue: 0.2000000477, alpha: 1)
        setupUI()
    }
    
    func setupUI() {
        view.addSubview(reservationButton)
        
        reservationButton.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview().inset(24)
//            $0.bottom.equalToSuperview().inset(24)
            //$0.top.equalTo(descriptionLabel.snp.bottom).offset(24)
            $0.height.equalTo(50)
        }
    }
    
    
}
