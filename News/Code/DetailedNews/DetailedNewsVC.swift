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
    private var isStarred = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = DetailedNewsView()
        view.backgroundColor = .white
        navigationItem.title = "News info"
        contentView.starButton.addTarget(self, action: #selector(starButtonTapped), for: .touchUpInside)
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
    
    private func updateStarButton() {
        let starImageName = isStarred ? "star.fill" : "star"
        contentView.starButton.setImage(UIImage(systemName: starImageName), for: .normal)
    }
    
    @objc private func starButtonTapped() {
        isStarred.toggle()
        updateStarButton()
    }
}
