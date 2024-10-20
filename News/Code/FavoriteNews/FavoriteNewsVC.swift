//
//  FavoriteNewsVC.swift
//  News
//
//  Created by Айтолкун Анарбекова on 20.10.2024.
//

import UIKit

class FavoriteNewsVC: UIViewController {
    
    let storageManager = StorageManager.shared
    
    private var contentView: FavoriteNewView {
        view as! FavoriteNewView
    }
    
    private var news: [NewsEntity] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view = FavoriteNewView()
        view.backgroundColor = .white
        navigationItem.title = "Favorite News"
        contentView.tableView.delegate = self
        contentView.tableView.dataSource = self
        contentView.tableView.register(NewsCell.self, forCellReuseIdentifier: "NewsCell")
        fetchNews()
    }
    
    func fetchNews() {
        storageManager.fetchNews { [weak self] news, error in
            if error != nil {
                return
            }
            if let news = news {
                self?.news = news
                self?.contentView.tableView.reloadData()
            }
        }
    }
}

extension FavoriteNewsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
        
        let news = news[indexPath.row]
        
        cell.titleLabel.text = news.author
        cell.subtitleLabel.text = news.descript
        
        let rawDate = news.date ?? "Empty Date"
        if let formattedDate = formatDate(rawDate) {
            cell.dateLabel.text = formattedDate
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedArticle = news[indexPath.row]
        let detailedNewsVC = DetailedNewsVC()
        
//        detailedNewsVC.configure(with: selectedArticle)
        
        navigationController?.pushViewController(detailedNewsVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
}
