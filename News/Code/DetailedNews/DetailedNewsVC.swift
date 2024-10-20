//
//  DetailedNews.swift
//  News
//
//  Created by Айтолкун Анарбекова on 20.10.2024.
//

import UIKit
import SDWebImage

class DetailedNewsVC: UIViewController {
    
    private var contentView: DetailedNewsView {
        view as! DetailedNewsView
    }
    
    var article: Article?
    private var newsEntity: NewsEntity?
    private var isStarred = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = DetailedNewsView()
        view.backgroundColor = .white
        navigationItem.title = "News info"
        contentView.starButton.addTarget(self, action: #selector(starButtonTapped), for: .touchUpInside)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(urlLabelTapped))
        contentView.urlLabel.addGestureRecognizer(tapGesture)
        configureView()

    }
    
    func configure(with article: Article) {
        self.article = article
    }
    private func configureView() {
        guard let article = article else { return }
        contentView.authorLabel.text = "\(article.creator?.first ?? "Unknown Author")"
        contentView.descriptionLabel.text = article.description ?? "Empty Description"
        contentView.urlLabel.text = article.link
        
        if let imageUrl = URL(string: article.imageURL ?? "") {
            loadImage(from: imageUrl)
        }
        updateStarButton()

    }
    
    private func loadImage(from url: URL) {
        contentView.imageView.sd_setImage(with: url)
    }
    
    @objc private func urlLabelTapped() {
        guard let urlString = contentView.urlLabel.text, let url = URL(string: urlString) else { return }
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    private func updateStarButton() {
        let starImageName = isStarred ? "star.fill" : "star"
        contentView.starButton.setImage(UIImage(systemName: starImageName), for: .normal)
        
    }
    
    @objc private func starButtonTapped() {
        isStarred.toggle()
        updateStarButton()

        
        if isStarred {
            if let article = article {
                StorageManager.shared.addNews(
                    image: article.imageURL ?? "",
                    authorName: article.creator?.first ?? "",
                    description: article.description ?? "",
                    url: article.link ?? "",
                    isFavorite: true
                )
            }
        } else {
            if let newsEntity = newsEntity {
                StorageManager.shared.toggleFavorite(news: newsEntity)
            }
        }
    }
}
