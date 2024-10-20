//
//  NewsVC.swift
//  News
//
//  Created by Айтолкун Анарбекова on 20.10.2024.
//

import UIKit

class NewsVC: UIViewController {
    
    let networkManager = NetworkManager()
    
    private var contentView: NewsView {
        view as! NewsView
    }
    
    private var newsArticles: [Article] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view = NewsView()
        view.backgroundColor = .white
        navigationItem.title = "News"
        contentView.tableView.delegate = self
        contentView.tableView.dataSource = self
        contentView.tableView.register(NewsCell.self, forCellReuseIdentifier: "NewsCell")
        fetchNews()

    }
    
    private func fetchNews() {
        networkManager.fetchNews { [weak self] result in
            switch result {
            case .success(let articles):
                self?.newsArticles = articles
                
                DispatchQueue.main.async {
                    self?.contentView.tableView.reloadData()
                }
            case .failure(let error):
                print("Error fetching news: \(error.localizedDescription)")
            }
        }
    }
}

extension NewsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
        
        let article = newsArticles[indexPath.row]
        
        cell.titleLabel.text = "\(article.creator?.first ?? "Unknown Author")"
        cell.subtitleLabel.text = article.description ?? "Empty Description"
        
        let rawDate = article.pubDate ?? "Empty Date"
        if let formattedDate = formatDate(rawDate) {
            cell.dateLabel.text = formattedDate
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedArticle = newsArticles[indexPath.row]
        let detailedNewsVC = DetailedNewsVC()
        
        detailedNewsVC.configure(with: selectedArticle)
        
        navigationController?.pushViewController(detailedNewsVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
}
