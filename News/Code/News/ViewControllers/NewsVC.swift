//
//  NewsVC.swift
//  News
//
//  Created by Айтолкун Анарбекова on 20.10.2024.
//

import UIKit
import SDWebImage

class NewsVC: UIViewController {
    
    let networkManager = NetworkManager()
    
    private var contentView: NewsView {
        view as! NewsView
    }
    
    private var newsArticles: [Article] = []
    private var currentPage: String?
    private var isFetchingMore = false
    private var totalResults = 0
           
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view = NewsView()
        view.backgroundColor = .white
        navigationItem.title = "News"
        contentView.tableView.delegate = self
        contentView.tableView.dataSource = self
        contentView.tableView.register(NewsCell.self, forCellReuseIdentifier: "NewsCell")
        fetchNews(page: currentPage)

    }
    
    private func fetchNews(page: String?) {
        guard !isFetchingMore else { return }
        isFetchingMore = true
        
        networkManager.fetchNews(nextPage: page) { [weak self] result in
            switch result {
            case .success(let response):
                self?.newsArticles.append(contentsOf: response.results)
                
                DispatchQueue.main.async {
                    self?.contentView.tableView.reloadData()
                }
                
                self?.currentPage = response.nextPage
                self?.isFetchingMore = false
                
            case .failure(let error):
                print("Error fetching news: \(error.localizedDescription)")
                self?.isFetchingMore = false
            }
        }
    }

}

extension NewsVC: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
        
        let article = newsArticles[indexPath.row]
        
        cell.titleLabel.text = "\(article.creator?.first ?? "Unknown Author")"
        cell.subtitleLabel.text = article.description ?? "Empty Description"
        
        if let imageUrl = article.imageURL, let url = URL(string: imageUrl) {
            cell.imageView1.sd_setImage(with: url, placeholderImage: UIImage(named: "emptyImage"))
        }
        
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let scrollViewHeight = scrollView.frame.size.height
        
        if offsetY > contentHeight - scrollViewHeight {
            fetchNews(page: currentPage)
        }
    }
}
