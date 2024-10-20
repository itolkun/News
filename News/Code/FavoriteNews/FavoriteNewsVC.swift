//
//  FavoriteNewsVC.swift
//  News
//
//  Created by Айтолкун Анарбекова on 20.10.2024.
//

import UIKit

class FavoriteNewsVC: UIViewController {
    
    private var contentView: FavoriteNewsView {
        view as! FavoriteNewsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = FavoriteNewsView()
        view.backgroundColor = .white
        
    }
}
