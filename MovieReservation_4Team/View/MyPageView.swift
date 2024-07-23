//
//  MyPageView.swift
//  MovieReservation_4Team
//
//  Created by 4Team on 7/22/24.
//

import UIKit
import SnapKit

class MyPageView: UIView {
    
    private let informationLabel: UILabel = {
        let label = UILabel()
        label.text = "회원 정보"
        label.textColor = UIColor.mainWhite
        label.font = FontNames.mainFont.font()
        return label
    }()
    
    private let Image: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 80
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.gray.cgColor
        imageView.backgroundColor = .white
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "사용자 이름"
        label.textColor = UIColor.mainWhite
        label.font = FontNames.subFont.font()
        return label
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.isScrollEnabled = false // 스크롤 비활성화
        tableView.backgroundColor = UIColor.mainBlack
        return tableView
    }()
    
    private let logoImage: UIImageView = {
        let logoImage = UIImageView()
        logoImage.image = UIImage(named: "LOGO")
        logoImage.contentMode = .scaleAspectFill
        return logoImage
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        [
            informationLabel,
            Image,
            nameLabel,
            tableView,
            logoImage
        ].forEach { self.addSubview($0) }
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupConstraints() {
        informationLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(70)
        }
        
        Image.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(informationLabel.snp.bottom).offset(50)
            $0.width.height.equalTo(160)
        }
        
        nameLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(Image.snp.bottom).offset(20)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(20)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(240) // 각 셀의 높이를 60으로 설정
        }
        logoImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top .equalTo(tableView.snp.bottom).offset(60)
            $0.width.equalTo(300)
        }
    }
}

extension MyPageView: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        
        switch indexPath.row {
        case 0:
            cell.configure(text: "정보 수정")
        case 1:
            cell.configure(text: "로그아웃")
        case 2:
            cell.configure(text: "회원 탈퇴")
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60 // 각 셀의 높이를 60으로 설정
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.mainBlack
        
        let titleLabel = UILabel()
        titleLabel.text = "계정"
        titleLabel.textColor = UIColor.mainWhite
        titleLabel.font = FontNames.mainFont.font()
        
        headerView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(16)
            $0.bottom.equalToSuperview().offset(-8)
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // 셀 선택에 따른 동작을 여기에 추가할 수 있습니다.
        switch indexPath.row {
        case 0:
            print("회원 정보 선택됨")
        case 1:
            print("로그아웃 선택됨")
        case 2:
            print("회원 탈퇴 선택됨")
        default:
            break
        }
    }
}


