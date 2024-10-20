//
//  NewsView.swift
//  News
//
//  Created by Айтолкун Анарбекова on 20.10.2024.
//

import UIKit

class NewsView: UIView {
    
    let tableView = UITableView()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.textAlignment = .left
        label.textColor = .black
        label.numberOfLines = 0
        label.text = "News"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        
        addSubview(titleLabel)
        addSubview(tableView)
       
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(20)
            make.leading.equalToSuperview().offset(20)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-20)
        }
      
    }

}
